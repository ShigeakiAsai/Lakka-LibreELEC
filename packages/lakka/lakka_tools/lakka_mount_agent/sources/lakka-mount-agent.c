/*
 * lakka-mount-agent
 *
 * Watches ConnMan's per-service IPv4 address state over D-Bus (not the
 * aggregated Manager.State, which combine_state() can report as
 * "ready"/"online" from IPv6 alone even while IPv4 is still unconfigured)
 * and restarts a configured set of systemd mount units whenever IPv4
 * connectivity appears, at boot or after roaming back into range.
 *
 * On a successful restart, also notifies RetroArch via its Lakka-only
 * UDS command interface (input_driver_init_command(), HAVE_LAKKA
 * branch in input/input_driver.c) so an OSD message confirms the
 * mount came back — this interface listens unconditionally on Lakka
 * builds regardless of retroarch.cfg's network_cmd_enable/
 * stdin_cmd_enable, so no RetroArch configuration is required.
 *
 * Note: restarts are enqueued with 'systemctl restart --no-block', which
 * returns immediately without waiting for the mount to complete. There is
 * currently no per-call job timeout (systemctl has no such option); if a
 * mount hangs, it hangs until the unit's own configuration (e.g. CIFS
 * 'soft,timeo=' or a [Mount] TimeoutSec=) cuts it off, or until it is
 * dealt with manually. This is a known gap, left for a later revision.
 *
 * SPDX-License-Identifier: GPL-2.0
 * Copyright (C) 2026-present ShigeakiAsai
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <glib.h>
#include <dbus/dbus.h>

#define CONNMAN_SERVICE           "net.connman"
#define CONNMAN_MANAGER_PATH      "/"
#define CONNMAN_MANAGER_INTERFACE "net.connman.Manager"
#define CONNMAN_SERVICE_INTERFACE "net.connman.Service"

#define AGENT_VERSION       "1.0"
#define DEBOUNCE_SECONDS    5

#define RETROARCH_UDS_ABSTRACT_NAME "retroarch/cmd"

static DBusConnection *connection;

static gchar **option_units = NULL;
static gboolean option_debug = FALSE;
static gboolean option_version = FALSE;

static gboolean have_ipv4 = FALSE;
static gint64 last_restart_monotonic = 0;

static GOptionEntry options[] = {
	{ "unit", 'u', 0, G_OPTION_ARG_STRING_ARRAY, &option_units,
	  "systemd mount unit to restart when IPv4 becomes available "
	  "(may be given multiple times)", "UNIT" },
	{ "debug", 0, 0, G_OPTION_ARG_NONE, &option_debug,
	  "Also log normal state transitions (IPv4 gained/lost, debounce "
	  "skips), not just warnings and restarts", NULL },
	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
	  "Show version information and exit" },
	{ NULL },
};

/*
 * Normal-path breadcrumbs (state transitions that are expected and not
 * actionable on their own) are only emitted with --debug, so the
 * default log stays limited to actual restarts and genuine failures.
 */
static void debug_log(const char *format, ...)
{
	va_list args;

	if (!option_debug)
		return;

	va_start(args, format);
	g_logv(G_LOG_DOMAIN, G_LOG_LEVEL_MESSAGE, format, args);
	va_end(args);
}

/*
 * Best-effort notification to RetroArch's Lakka-only UDS command
 * interface. A failed connect() just means RetroArch isn't running
 * right now (or hasn't opened the socket yet), which is routine, not
 * an error worth a warning.
 */
static void notify_retroarch(const char *message)
{
	struct sockaddr_un addr;
	socklen_t addrlen;
	char buf[300];
	int fd, len;

	fd = socket(AF_UNIX, SOCK_STREAM, 0);
	if (fd < 0)
		return;

	memset(&addr, 0, sizeof(addr));
	addr.sun_family = AF_UNIX;
	addr.sun_path[0] = '\0';
	memcpy(addr.sun_path + 1, RETROARCH_UDS_ABSTRACT_NAME,
	       strlen(RETROARCH_UDS_ABSTRACT_NAME));
	addrlen = (socklen_t)(offsetof(struct sockaddr_un, sun_path) + 1
			       + strlen(RETROARCH_UDS_ABSTRACT_NAME));

	if (connect(fd, (struct sockaddr *)&addr, addrlen) < 0) {
		debug_log("RetroArch UDS not reachable (not running?)");
		close(fd);
		return;
	}

	len = snprintf(buf, sizeof(buf), "SHOW_MSG %s\n", message);
	if (len > 0)
		send(fd, buf, (size_t)len, 0);

	close(fd);
}

/*
 * variant_iter must point at a DBUS_TYPE_VARIANT wrapping the value of
 * a service's "IPv4" property, i.e. an a{sv} dict containing Method/
 * Address/Netmask/Gateway. Returns whether "Address" is present and
 * non-empty.
 */
static bool ipv4_variant_has_address(DBusMessageIter *variant_iter)
{
	DBusMessageIter array_iter, entry_iter;

	if (dbus_message_iter_get_arg_type(variant_iter) != DBUS_TYPE_VARIANT)
		return false;

	dbus_message_iter_recurse(variant_iter, &array_iter);

	if (dbus_message_iter_get_arg_type(&array_iter) != DBUS_TYPE_ARRAY)
		return false;

	for (dbus_message_iter_recurse(&array_iter, &entry_iter);
	     dbus_message_iter_get_arg_type(&entry_iter) == DBUS_TYPE_DICT_ENTRY;
	     dbus_message_iter_next(&entry_iter)) {

		DBusMessageIter kv, val_variant;
		char *key, *addr = NULL;

		dbus_message_iter_recurse(&entry_iter, &kv);

		if (dbus_message_iter_get_arg_type(&kv) != DBUS_TYPE_STRING)
			continue;

		dbus_message_iter_get_basic(&kv, &key);

		if (strcmp(key, "Address"))
			continue;

		dbus_message_iter_next(&kv);

		if (dbus_message_iter_get_arg_type(&kv) != DBUS_TYPE_VARIANT)
			return false;

		dbus_message_iter_recurse(&kv, &val_variant);

		if (dbus_message_iter_get_arg_type(&val_variant) != DBUS_TYPE_STRING)
			return false;

		dbus_message_iter_get_basic(&val_variant, &addr);

		return addr && addr[0] != '\0';
	}

	return false;
}

/*
 * dict_array_iter must point at a DBUS_TYPE_ARRAY of a{sv} — a single
 * service's full property dictionary, as returned inline by
 * Manager.GetServices(). Looks for the "IPv4" key and delegates.
 */
static bool properties_dict_ipv4_has_address(DBusMessageIter *dict_array_iter)
{
	DBusMessageIter entry;

	if (dbus_message_iter_get_arg_type(dict_array_iter) != DBUS_TYPE_ARRAY)
		return false;

	for (dbus_message_iter_recurse(dict_array_iter, &entry);
	     dbus_message_iter_get_arg_type(&entry) == DBUS_TYPE_DICT_ENTRY;
	     dbus_message_iter_next(&entry)) {

		DBusMessageIter kv;
		char *key;

		dbus_message_iter_recurse(&entry, &kv);

		if (dbus_message_iter_get_arg_type(&kv) != DBUS_TYPE_STRING)
			continue;

		dbus_message_iter_get_basic(&kv, &key);

		if (strcmp(key, "IPv4"))
			continue;

		dbus_message_iter_next(&kv);

		return ipv4_variant_has_address(&kv);
	}

	return false;
}

/*
 * iter must be initialized on a Manager.GetServices() reply: an array
 * of (object_path, a{sv}) structs. Returns true if any service
 * currently has a configured IPv4 address, regardless of that
 * service's IPv6 state or aggregated State string.
 */
static bool services_array_has_ipv4(DBusMessageIter *iter)
{
	DBusMessageIter array, entry;

	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
		return false;

	for (dbus_message_iter_recurse(iter, &array);
	     dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRUCT;
	     dbus_message_iter_next(&array)) {

		dbus_message_iter_recurse(&array, &entry);

		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_OBJECT_PATH)
			continue;

		dbus_message_iter_next(&entry);

		if (properties_dict_ipv4_has_address(&entry))
			return true;
	}

	return false;
}

static void restart_units(void)
{
	guint i;

	if (!option_units)
		return;

	for (i = 0; option_units[i] != NULL; i++) {
		char cmd[512];
		int ret;

		snprintf(cmd, sizeof(cmd),
			 "systemctl restart --no-block -- %s",
			 option_units[i]);

		g_message("IPv4 available, restarting %s", option_units[i]);

		ret = system(cmd);
		if (ret != 0) {
			g_warning("Failed to enqueue restart for %s (exit %d)",
				  option_units[i], ret);
		} else {
			char msg[256];

			snprintf(msg, sizeof(msg),
				 "NAS mount available: %s", option_units[i]);
			notify_retroarch(msg);
		}
	}
}

static void notify_lost_mounts(void)
{
	guint i;
	char msg[256];

	if (!option_units)
		return;

	for (i = 0; option_units[i] != NULL; i++) {
		snprintf(msg, sizeof(msg),
			 "Network lost, mount may drop: %s", option_units[i]);
		notify_retroarch(msg);
	}
}

/*
 * Reacts only on the false -> true transition ("IPv4 just became
 * available"), so a service that stays connected the whole time never
 * triggers repeated restarts, and a debounce window absorbs bursts of
 * PropertyChanged signals during an unstable handshake. State
 * transitions themselves (lost / debounce skip) are breadcrumbs, not
 * failures, so they only surface with --debug.
 */
static void maybe_restart(bool has_ipv4_now)
{
	gint64 now;

	if (has_ipv4_now == have_ipv4) {
		have_ipv4 = has_ipv4_now;
		return;
	}

	have_ipv4 = has_ipv4_now;

	if (!has_ipv4_now) {
		debug_log("IPv4 no longer available");
		notify_lost_mounts();
		return;
	}

	now = g_get_monotonic_time() / G_USEC_PER_SEC;

	if (last_restart_monotonic != 0 &&
	    now - last_restart_monotonic < DEBOUNCE_SECONDS) {
		debug_log("IPv4 reappeared within debounce window (%ds), skipping",
			   DEBOUNCE_SECONDS);
		return;
	}

	last_restart_monotonic = now;
	restart_units();
}

/*
 * Every failure branch here means "this round's check was silently
 * lost" (ConnMan didn't answer, answered with an error, or the reply
 * was malformed), which is exactly the kind of thing that must not go
 * unlogged even without --debug.
 */
static void manager_get_services_return(DBusPendingCall *call, void *user_data)
{
	DBusMessage *reply;
	DBusMessageIter iter;
	bool has_ipv4 = false;

	reply = dbus_pending_call_steal_reply(call);
	if (!reply) {
		g_warning("GetServices: no reply from ConnMan");
		goto out;
	}

	if (dbus_message_get_type(reply) == DBUS_MESSAGE_TYPE_ERROR) {
		const char *err_name = dbus_message_get_error_name(reply);
		g_warning("GetServices failed: %s",
			  err_name ? err_name : "unknown error");
		goto out_unref;
	}

	if (!dbus_message_iter_init(reply, &iter)) {
		g_warning("GetServices: malformed reply (empty message)");
		goto out_unref;
	}

	has_ipv4 = services_array_has_ipv4(&iter);

out_unref:
	dbus_message_unref(reply);
out:
	dbus_pending_call_unref(call);
	maybe_restart(has_ipv4);
}

static void manager_get_services(void)
{
	DBusMessage *message;
	DBusPendingCall *call;

	message = dbus_message_new_method_call(CONNMAN_SERVICE,
						CONNMAN_MANAGER_PATH,
						CONNMAN_MANAGER_INTERFACE,
						"GetServices");
	if (!message) {
		g_warning("Failed to allocate GetServices message");
		return;
	}

	if (!dbus_connection_send_with_reply(connection, message, &call, -1)) {
		g_warning("Failed to send GetServices (out of memory?)");
		goto out;
	}

	if (!call) {
		g_warning("GetServices call was not queued");
		goto out;
	}

	dbus_pending_call_set_notify(call, manager_get_services_return, NULL, NULL);

out:
	dbus_message_unref(message);
}

/*
 * Manager.PropertyChanged fires for the aggregated State (and other
 * manager-wide properties); a per-service PropertyChanged fires for
 * things like "IPv4" on that service's own object path. Either kind
 * of event is treated as "something about connectivity moved", and
 * the daemon re-derives the real answer via GetServices() rather than
 * trying to parse every signal shape individually.
 */
static DBusHandlerResult signal_filter(DBusConnection *conn,
					DBusMessage *message, void *user_data)
{
	if (dbus_message_is_signal(message, CONNMAN_MANAGER_INTERFACE,
				    "PropertyChanged") ||
	    dbus_message_is_signal(message, CONNMAN_SERVICE_INTERFACE,
				    "PropertyChanged")) {
		manager_get_services();
	}

	return DBUS_HANDLER_RESULT_HANDLED;
}

int main(int argc, char *argv[])
{
	GOptionContext *context;
	GError *g_err = NULL;
	DBusError dbus_err;
	const char *manager_filter =
		"type='signal',interface='" CONNMAN_MANAGER_INTERFACE "'";
	const char *service_filter =
		"type='signal',interface='" CONNMAN_SERVICE_INTERFACE "'";

	context = g_option_context_new(NULL);
	g_option_context_add_main_entries(context, options, NULL);

	if (!g_option_context_parse(context, &argc, &argv, &g_err)) {
		fprintf(stderr, "%s\n", g_err ? g_err->message : "Unknown error");
		return EXIT_FAILURE;
	}
	g_option_context_free(context);

	if (option_version) {
		printf("%s\n", AGENT_VERSION);
		return EXIT_SUCCESS;
	}

	if (!option_units || !option_units[0]) {
		fprintf(stderr, "At least one --unit=<name> is required\n");
		return EXIT_FAILURE;
	}

	dbus_error_init(&dbus_err);
	connection = dbus_bus_get(DBUS_BUS_SYSTEM, &dbus_err);

	if (dbus_error_is_set(&dbus_err)) {
		fprintf(stderr, "D-Bus connection error: %s\n", dbus_err.message);
		dbus_error_free(&dbus_err);
		return EXIT_FAILURE;
	}

	dbus_connection_set_exit_on_disconnect(connection, FALSE);
	dbus_connection_add_filter(connection, signal_filter, NULL, NULL);

	dbus_bus_add_match(connection, manager_filter, &dbus_err);
	dbus_bus_add_match(connection, service_filter, &dbus_err);

	if (dbus_error_is_set(&dbus_err)) {
		fprintf(stderr, "D-Bus match error: %s\n", dbus_err.message);
		dbus_error_free(&dbus_err);
		return EXIT_FAILURE;
	}

	/*
	 * Establish the baseline at startup. If IPv4 is already
	 * configured when the daemon starts (e.g. after Restart=always
	 * brings it back up, or a normal boot where WiFi connected
	 * before this daemon did), this still fires an initial
	 * restart rather than waiting for the next change event.
	 */
	manager_get_services();

	while (dbus_connection_read_write_dispatch(connection, -1))
		;

	return EXIT_SUCCESS;
}

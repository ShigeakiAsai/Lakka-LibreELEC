
// Copyright 2021 David Guillen Fandos <david@davidgf.net>
// Under GPL 2 and 3 licenses

// Service that captures key events from one or several input devices and
// injects relevant events into Retroarch.
// This is mean to be used under Lakka or similar distributions.

#include <unistd.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <dirent.h>
#include <string.h>
#include <fcntl.h>
#include <poll.h>
#include <stdbool.h>
#include <time.h>
#include <sys/un.h>
#include <sys/socket.h>
#include <stddef.h>
#include <linux/input.h>

#define REPRESS_MS    350   // Automatically press the button again after 350ms
#define REPEAT_MS     100   // and then every 100ms while it is held
#define MAX_IDEVS       8

const unsigned event_map[KEY_MAX + 1] = {
  [0 ... KEY_MAX]  = 0,
  [KEY_VOLUMEUP]   = 1,
  [KEY_VOLUMEDOWN] = 2,
  [KEY_MUTE]       = 3,
};

const char *cmd_map[] = {
  NULL,
  "VOLUME_UP\n",
  "VOLUME_DOWN\n",
  "MUTE\n",
};

#define MAX_KEYS (sizeof(cmd_map)/sizeof(cmd_map[0]))

static int dev_looks_valid(const struct dirent *dir) {
  return !memcmp("event", dir->d_name, 5);
}

static bool inlist(char **list, int count, const char *needle) {
  for (int j = 0; j < count; j++)
    if (!strcmp(list[j], needle))
      return true;
  return false;
}

static uint64_t gettimems() {
  struct timespec spec;
  // Monotonic, so that a clock change (NTP) does not affect key repeat
  clock_gettime(CLOCK_MONOTONIC, &spec);
  return ((uint64_t)spec.tv_sec) * 1000 + (spec.tv_nsec / 1000000);
}

static int connectsocket() {
  int fd = socket(PF_UNIX, SOCK_STREAM, 0);
  if (fd < 0)
    return -1;

  const char *rapath = "retroarch/cmd";
  struct sockaddr_un addr;
  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strcpy(&addr.sun_path[1], rapath);
  socklen_t addrsz = offsetof(struct sockaddr_un, sun_path) + strlen(rapath) + 1;
  if (connect(fd, (struct sockaddr *)&addr, addrsz) < 0) {
    close(fd);
    return -1;
  }
  return fd;
}

int main(int argc, char **argv) {
  int devfds[MAX_IDEVS];
  int numdevs = 0;
  signal(SIGPIPE, SIG_IGN);

  while (1) {
    // Scan devices to find relevant devices
    struct dirent **namelist;
    int num = scandir("/dev/input", &namelist, dev_looks_valid, NULL);
    for (int i = 0; i < num; i++) {
      char path[PATH_MAX] = "/dev/input/";
      strcat(path, namelist[i]->d_name);
      int fd = open(path, O_RDONLY);
      if (fd < 0)
        continue;

      // Get the device name
      char devname[512];
      ioctl(fd, EVIOCGNAME(sizeof(devname)), devname);

      if (inlist(&argv[1], argc-1, devname))
        devfds[numdevs++] = fd;
      else
        close(fd);
    }
    if (numdevs)
      break;

    printf("Could not find any device, retrying in 10s ...\n");
    sleep(10);
  }

  // Assume all keys are unpressed by default
  uint64_t keystate[numdevs][MAX_KEYS];
  memset(keystate, 0, sizeof(keystate));

  int clientfd = connectsocket();

  // Loop on events
  while (1) {
    struct pollfd fds[numdevs];
    for (int i = 0; i < numdevs; i++) {
      fds[i].fd = devfds[i];
      fds[i].events = POLLIN;
    }

    // Sleep until the next repeat of a held key, or until an event
    int timeout = -1;
    uint64_t now = gettimems();
    for (int i = 0; i < numdevs; i++) {
      for (int j = 1; j < MAX_KEYS; j++) {
        if (keystate[i][j]) {
          uint64_t due = keystate[i][j] + REPRESS_MS;
          int left = due > now ? (int)(due - now) : 0;
          if (timeout < 0 || left < timeout)
            timeout = left;
        }
      }
    }
    poll(fds, numdevs, timeout);

    for (int i = 0; i < numdevs; i++) {
      if (fds[i].revents & POLLIN) {
        struct input_event ev[8];
        int readb = read(devfds[i], ev, sizeof(ev));
        if (readb < sizeof(struct input_event))
          return -1;    // Device is gone?

        for (unsigned j = 0; j < readb / sizeof(struct input_event); j++) {
          int keycode = ev[j].code;
          if (ev[j].type == EV_KEY && keycode < KEY_MAX) {
            unsigned keyid = event_map[keycode];
            if (keyid) {
              const char *cmd = cmd_map[keyid];
              // Just pressed now (was not pressed before)
              bool pressed = !keystate[i][keyid] && ev[j].value;
              if (pressed) {
                // Send command over the client socket
                int wr = write(clientfd, cmd, strlen(cmd));
                // Reconnect on error!
                if (wr <= 0) {
                  close(clientfd);
                  clientfd = connectsocket();
                }
                // Just track the time it was pressed
                keystate[i][keyid] = gettimems();
              }
              // Key un-press
              if (!ev[j].value)
                keystate[i][keyid] = 0;
            }
          }
        }
      }
    }

    // Keys that are being held
    now = gettimems();
    for (int i = 0; i < numdevs; i++) {
      for (int j = 1; j < MAX_KEYS; j++) {
        if (keystate[i][j]) {
          // Has been pressed for more than some time
          bool longpressed = (now - keystate[i][j]) >= REPRESS_MS;
          if (!longpressed)
            continue;
          // Inject the event
          const char *cmd = cmd_map[j];
          write(clientfd, cmd, strlen(cmd));
          // Set the time so that the next repeat comes after REPEAT_MS
          keystate[i][j] = now - REPRESS_MS + REPEAT_MS;
        }
      }
    }
  }
}



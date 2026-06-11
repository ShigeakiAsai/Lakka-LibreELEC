#!/bin/bash

# Configuration Paths
ASOUNDCONF_PATH="/storage/.config/asound.conf"
BACKUP_PATH="/storage/.config/asound.conf.bak"

# Markers to isolate dynamic configurations
START_MARKER="# --- BEGIN AUTOMATIC BLUEZ-ALSA DEVICES ---"
END_MARKER="# --- END AUTOMATIC BLUEZ-ALSA DEVICES ---"

# Bluetooth Audio Sink (A2DP) UUID - Audio Output Devices
AUDIO_SINK_UUID="0000110b-0000-1000-8000-00805f9b34fb"

# Ensure the config directory exists
mkdir -p "$(dirname "$ASOUNDCONF_PATH")"

# --- Functions ---

create_backup() {
    if [ -f "$ASOUNDCONF_PATH" ] && [ ! -f "$BACKUP_PATH" ]; then
        if ! grep -q "$START_MARKER" "$ASOUNDCONF_PATH"; then
            cp "$ASOUNDCONF_PATH" "$BACKUP_PATH"
            echo "[BACKUP] Created backup of original config at $BACKUP_PATH"
        fi
    fi
}

clean_asoundconf() {
    if [ -f "$ASOUNDCONF_PATH" ]; then
        # Remove dynamic block between markers
        sed -i "/$START_MARKER/,/$END_MARKER/d" "$ASOUNDCONF_PATH"
        
        # Read the remaining file content
        local file_content=$(cat "$ASOUNDCONF_PATH" 2>/dev/null)
        
        # Strip all whitespaces, tabs, and newlines to check if it's effectively empty
        # If the file is now empty or only contains whitespace, handle cleanup
        if [ ! -s "$ASOUNDCONF_PATH" ] || [ -z "${file_content//[[:space:]]/}" ]; then
            rm -f "$ASOUNDCONF_PATH"
            echo "[SUCCESS] Removed empty $ASOUNDCONF_PATH"
            if [ -f "$BACKUP_PATH" ]; then
                mv "$BACKUP_PATH" "$ASOUNDCONF_PATH"
                echo "[SUCCESS] Restored original $ASOUNDCONF_PATH from backup."
            fi
        fi
    fi
}

get_device_properties() {
    local path="$1"
    # Format MAC address from D-Bus path (/org/bluez/hci0/dev_XX_XX_XX_...)
    local mac=$(echo "$path" | sed -n 's/.*dev_\([0-9A-F_]\{17\}\).*/\1/p' | tr '_' ':')
    
    # Fetch Name and UUIDs using busctl
    local name=$(busctl get-property org.bluez "$path" org.bluez.Device1 Name 2>/dev/null | awk -F'"' '{print $2}')
    [ -z "$name" ] && name="Unknown Device"
    
    local uuids=$(busctl get-property org.bluez "$path" org.bluez.Device1 UUIDs 2>/dev/null)
    
    # Check if this device contains the corrected Audio Sink UUID (Case-insensitive check)
    if echo "$uuids" | grep -qi "$AUDIO_SINK_UUID"; then
        add_device "$mac" "$name"
    fi
}

add_device() {
    local mac="$1"
    local name="$2"
    local safe_name=$(echo "$name" | tr ' ' '_' | tr -cd '_a-zA-Z0-9' | tr 'A-Z' 'a-z')
    [ -z "$safe_name" ] && safe_name="unknown"
    local logical_name="bluealsa-$safe_name"

    create_backup

    # Clean existing block to avoid duplicate entries when rewriting
    if [ -f "$ASOUNDCONF_PATH" ]; then
        sed -i "/$START_MARKER/,/$END_MARKER/d" "$ASOUNDCONF_PATH"
    fi

    # Append new device block
    cat << EOF >> "$ASOUNDCONF_PATH"
$START_MARKER
# Device: $name
pcm.$logical_name {
    type plug
    slave.pcm {
        type bluealsa
        device "$mac"
        profile "a2dp"
    }
    hint {
        show on
        description "Bluetooth Audio: ${name}"
    }
}
$END_MARKER
EOF
    echo "========================================"
    echo "[CONNECTED] Bluetooth Audio Output Device Detected!"
    echo "Device Name: $name"
    echo "Logical Name: $logical_name"
    echo "========================================"
    echo "[SUCCESS] Updated $ASOUNDCONF_PATH"
}

remove_device() {
    local path="$1"
    echo "========================================"
    echo "[DEVICE_DISCONNECTED] Bluetooth Device Disconnected! (Path: $path)"
    echo "========================================"
    clean_asoundconf
}

shutdown_handler() {
    echo -e "\n[SHUTDOWN] Received signal. Cleaning up ALSA configs before exit..."
    clean_asoundconf
    exit 0
}

# Register traps for clean shutdown (Ctrl+C, systemd stop)
trap shutdown_handler SIGINT SIGTERM

# --- Main Execution ---

# 1. Startup Scan (Check currently connected devices)
echo "[INFO] Scanning for already connected Bluetooth audio devices..."
for dev_path in $(busctl tree org.bluez 2>/dev/null | grep -o '/org/bluez/hci0/dev_[0-9A-F_]\{17\}' | sort -u); do
    connected=$(busctl get-property org.bluez "$dev_path" org.bluez.Device1 Connected 2>/dev/null | awk '{print $2}')
    if [ "$connected" = "true" ]; then
        get_device_properties "$dev_path"
    fi
done

echo "Monitoring Bluetooth audio device connections... (Press Ctrl+C to exit)"

# 2. Live Monitoring via dbus-monitor
# We listen to PropertiesChanged signals from BlueZ devices
dbus-monitor --system "type='signal',sender='org.bluez',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',arg0='org.bluez.Device1'" 2>/dev/null | \
while read -r line; do
    # Catch the object path from dbus-monitor context
    if echo "$line" | grep -q "path="; then
        current_path=$(echo "$line" | sed -n 's/.*path=\([^;]*\);.*/\1/p' | tr -d '"')
    fi
    
    # Catch when "Connected" property flips
    if echo "$line" | grep -q "string \"Connected\""; then
        read -r next_line
        if echo "$next_line" | grep -q "boolean true"; then
            # Small delay to ensure BlueZ updates all properties before we query
            sleep 0.5
            get_device_properties "$current_path"
        elif echo "$next_line" | grep -q "boolean false"; then
            remove_device "$current_path"
        fi
    fi
done

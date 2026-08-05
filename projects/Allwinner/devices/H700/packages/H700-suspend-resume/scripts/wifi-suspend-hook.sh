#!/bin/sh
DRIVER=$(readlink -f /sys/class/net/wlan0/device/driver 2>/dev/null | xargs basename 2>/dev/null)

logger -t wifi-suspend-hook "mode=$1 driver=${DRIVER:-none}"

case "$DRIVER" in
  rtw88_*)
    case "$1" in
      down)
        ip link set wlan0 down
        logger -t wifi-suspend-hook "wlan0 down executed"
        ;;
      up)
        ip link set wlan0 up
        systemctl restart connman # re-negotiate wifi to avoid stale auth state after down/up
        logger -t wifi-suspend-hook "wlan0 up executed"
        ;;
    esac
    ;;
esac
exit 0

#!/bin/sh
if [[ $(lsusb -d 1a40:0101 |wc -l) -gt 1 ]]; then
	echo 'video_monitor_index = "2"' >/tmp/retroarch-gpicase2-monitor.cfg
else
	echo 'video_monitor_index = "0"' >/tmp/retroarch-gpicase2-monitor.cfg
fi

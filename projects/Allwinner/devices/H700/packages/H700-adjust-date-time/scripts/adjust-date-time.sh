#!/bin/bash

# Resule code
# 0 Success : No "/flash/adjust-date-time.cfg" file. No need to adjust.
#             Network is enabled. NTP will be used for system/RTC time.
#             Succeed to adjust.
# 1 Fail : Wrong number of parameter shell script.
# 2 Fail : No RTC device.
# 3 Fail : Can't set system date and time. date command is failed.
# 4 Fail : Can't set RTC date and time. hwclock command is failed.
# 5 Fail : Wrong parameter function call.


function rename_adjust-date-time_cfg () {
  case $1 in
    Success)
      ;;
    Fail)
      ;;
    *)
      # Wrong parameter function call.
      exit 5
  esac

  # Rename /flash/adjust-date-time.cfg file
  mount -o remount rw /flash/ > /dev/null 2>&1
  mv /flash/adjust-date-time.cfg /flash/adjust-date-time.cfg."$1" > /dev/null 2>&1
  mount -o remount r /flash/ > /dev/null 2>&1
}


# Check number of parameter.
if [ "$#" -ne 0 ]; then
{
  # Wrong number of parameter shell script.
  exit 1
}
fi

# Check /flash/adjust-date-time.cfg file is exist or not.
if [ ! -f "/flash/adjust-date-time.cfg" ]; then
{
  # 1st, if there is no "/flash/adjust-date-time.cfg" file,
  # no need to adjust system date and time manually.
  # But, it might be needed to adjust system date and time (localtime) from RTC (localtime).

  if [ -f "/flash/adjust-date-time.cfg.Fail" ]; then
  {
    # 2nd, if there is "/flash/adjust-date-time.cfg.Fail" file,
    # system date and time does not adjust from RTC
    # because manually set is failed already.
    :
  }
  elif [ -f "/flash/adjust-date-time.cfg.Success" ]; then
  {
    # 3rd, if there is "/flash/adjust-date-time.cfg.Success" file,
    # system date and time (localtime) adjusts from RTC (localtime).
    /usr/sbin/hwclock -l -s > /dev/null 2>&1
  }
  fi
  exit 0
}
fi

# Check RTC device exist or not.
ls /dev/rtc*  > /dev/null 2>&1
if [ $? -ne 0 ]; then
{
  # No RTC device
  rename_adjust-date-time_cfg Fail
  exit 2
}
fi

# Check network is enabled or not.
/usr/bin/nslookup www.lakka.tv > /dev/null 2>&1
if [ $? -eq 0 ]; then
{
  # Network is enabled.
  # NTP will be used for system/RTC time adjustment.
  exit 0
}
fi

# Start to adjust date and time.

# Try to adjust system's date and time (localtime).
val_adjust_date_time=$(cat /flash/adjust-date-time.cfg)
/usr/bin/date -s "${val_adjust_date_time}" > /dev/null 2>&1
if [ $? -ne 0 ]; then
{
  # "date" command is failed.
  # Can't adjust system date and time.
  rename_adjust-date-time_cfg Fail
  exit 3
}
fi

# Try to adjust RTC's date and time (localtime).
/usr/sbin/hwclock -w -l > /dev/null 2>&1
if [ $? -ne 0 ]; then
{
  # "hwclock" command is failed.
  # Can't adjust RTC date and time.
  rename_adjust-date-time_cfg Fail
  exit 4
}
fi

# Success - end
rename_adjust-date-time_cfg Success
exit 0

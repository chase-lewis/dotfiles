#!/usr/bin/env sh

export DISPLAY=:0

battery=`cat /sys/class/power_supply/BAT0/capacity | grep -P -o '[0-9]+'`
charging=`cat /sys/class/power_supply/ADP1/online | grep -P -o '[0-9]'`
if [ $battery -le 15 ] && [ $charging -eq 0 ]; then
  notify-send -u critical "LOW BATTERY" "${battery}% remaining"
fi
exit 0

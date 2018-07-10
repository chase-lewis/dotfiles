#!/bin/sh

if pgrep xautolock >/dev/null; then
  pkill xautolock
else
  xautolock -detectsleep -time 5 -locker blanklock -corners 000- -notify 30 -notifier "notify-send -u normal 'TIMOUT' 'System will lock in 30 seconds'" &
fi

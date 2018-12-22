#!/bin/sh

if [ ! -z "$BLOCK_BUTTON" ]; then
    if pgrep xautolock >/dev/null; then
      pkill xautolock
    else
      xautolock -detectsleep -time 5 -locker blurlock -corners 000- -notify 30 -notifier "notify-send -u normal 'TIMEOUT' 'System will lock in 30 seconds'" &
    fi
fi

if pgrep xautolock >/dev/null; then
  echo ""
else
  echo ""
fi


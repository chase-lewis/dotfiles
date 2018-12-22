#!/bin/sh

set -e

/usr/bin/setxkbmap -option caps:escape 

if xrandr | grep -q "HDMI1 disconnected"; then
  /usr/bin/xrandr --output HDMI1 --off --output eDP1 --primary
else
  /usr/bin/xrandr --output eDP1 --mode 1366x768 --pos 0x528 --output HDMI1 --mode 1920x1080 --pos 1366x0 --primary
  /usr/bin/sleep 0.1
  for i in {1..10}; do
      rem=$(($i % 2))
    if [ "$rem" -ne "0" ]; then
      /usr/bin/i3-msg "workspace --no-auto-back-and-forth $i"
      /usr/bin/i3-msg move workspace to output primary
    fi
  done
  /usr/bin/i3-msg workspace back_and_forth
fi

/home/chase/bin/wallpaper.sh

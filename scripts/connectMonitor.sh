#!/bin/sh

set -e

/usr/bin/setxkbmap -option caps:escape 

if xrandr | grep -q "HDMI1 disconnected"; then
  /usr/bin/xrandr --output HDMI1 --off --output eDP1 --primary
# light -S 30
else
  /usr/bin/xrandr --output eDP1 --mode 1366x768 --pos 0x528 --output HDMI1 --mode 1920x1080 --pos 1366x0 --primary
  /usr/bin/sleep 0.1
# light -S 100
fi

/home/chase/.bin/wallpaper.sh

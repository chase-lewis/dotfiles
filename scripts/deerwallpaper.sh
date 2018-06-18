#!/bin/sh

export DISPLAY=:0.0
export XAUTHORITY=/home/chase/.Xauthority

num=$((10#`date +"%H"` / 2))
wallpaper="deer$num.jpg"
feh --bg-fill "/home/chase/Pictures/deer/$wallpaper"

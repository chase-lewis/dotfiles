#! /usr/bin/env bash

if [ ! -z "$BLOCK_BUTTON" ]; then
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause > /dev/null 2>&1
fi

sleep .4

stat=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' 2> /dev/null |egrep -A 1 "string"|cut -b 26-|cut -d '"' -f 1|egrep -v ^$)
if [ "$stat" = "Playing" ]; then
  echo ""
else
  echo ""
fi


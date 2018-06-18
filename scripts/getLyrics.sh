#! /usr/bin/env bash

song=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata 2>/dev/null | sed -n '/title/{n;p}' | cut -d '"' -f 2 | sed 's/ /%20/g')
artist=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata 2>/dev/null | sed -n '/artist/{n;n;p}' | cut -d '"' -f 2 | sed 's/ /%20/g')
url="http://lyric-api.herokuapp.com/api/find/$artist/$song"
lyrics=$(curl -s $url | jq -r ".lyric")
printf "%s"  "$(curl -s $url | jq -r ".lyric")"

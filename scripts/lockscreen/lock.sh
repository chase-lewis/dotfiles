#!/bin/sh

# Colors
B='#00000000'  # blank
C='#00000000'  # blank
#C='#1d1f26ca'  # clear ish
D='#bbbfcaff'  # default
T='#bbbfcaff'  # text
W='#c35c66dd'  # wrong (red)
V='#5294e2dd'  # verifying (blue)

image="/tmp/lockscreen.png"
rectangles=" "
		SR=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
		for RES in $SR; do
			SRA=(${RES//[x+]/ })
			CX=$((${SRA[2]} + 25))
			CY=$((${SRA[1]} - 30))
			rectangles+="rectangle $CX,$CY $((CX+300)),$((CY-80)) "
done

scrot $image
ffmpeg -loglevel quiet -y -i $image -filter_complex "boxblur=3" -vframes 1 $image
convert $image -draw "fill rgba(0, 0, 0, 0.6) $rectangles" $image

i3lock \
	-t -i $image \
	--timepos="x+110:h-70" \
	--datepos="x+135:h-45" \
	--clock --datestr "Type password to unlock..." \
	--insidecolor=$C --ringcolor=$T --line-uses-inside \
	--keyhlcolor=$V --bshlcolor=$W --separatorcolor=$C \
	--insidevercolor=$B --insidewrongcolor=$W \
	--ringvercolor=$V --ringwrongcolor=$W --indpos="x+280:h-70" \
	--radius=20 --ring-width=4 --veriftext="" --wrongtext="" \
	--verifcolor="$T" --timecolor="$T" --datecolor="$T" \
--noinputtext="" --force-clock $lockargs \
> /dev/null 2>&1

exit 0

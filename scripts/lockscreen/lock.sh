#!/bin/sh

# Colors
B='#00000000'  # blank
C='#4b5162bb'  # clear ish
D='#bbbfcaff'  # default
T='#bbbfcaff'  # text
W='#c35c66dd'  # wrong (red)
V='#5294e2dd'  # verifying (blue)

# Lock screen
i3lock \
--insidevercolor=$C   \
--ringvercolor=$V     \
\
--insidewrongcolor=$C \
--ringwrongcolor=$W   \
\
--insidecolor=$C      \
--ringcolor=$D        \
--linecolor=$B        \
--separatorcolor=$D   \
\
--textcolor=$T        \
--textsize=18         \
--keyhlcolor=$V       \
--bshlcolor=$W        \
\
--wrongtext="incorrect" \
\
--screen=0            \
--blur=5              \
--clock               \
--indicator           \
--timecolor=$T        \
--datecolor=$T        \
--timesize=18        \
--timestr="%H:%M:%S"  \
--datestr="%m-%d-%Y" \
--composite         \
> /dev/null 2>&1

exit 0

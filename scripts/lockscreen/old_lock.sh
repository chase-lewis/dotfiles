#!/bin/sh

B='#00000000'  # blank
C='#4b5162ee'  # clear ish
D='#bbbfcaff'  # default
T='#bbbfcaff'  # text
W='#c35c66ee'  # typing
V='#5294e2ee'  # verifying

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
--verifcolor=$T        \
--wrongcolor=$T        \
--timecolor=$T        \
--datecolor=$T        \
--layoutcolor=$T      \
--keyhlcolor=$W       \
--bshlcolor=$W        \
\
--screen 1            \
--blur 1              \
--clock               \
--indicator           \
--timestr="%H:%M:%S"  \
--datestr="%m-%d-%Y" \
--keylayout 2         \


# --veriftext="Drinking verification can..."
# --wrongtext="Nope!"
# --textsize=20
# --modsize=10
# --timefont=comic-sans
# --datefont=monofur
# etc

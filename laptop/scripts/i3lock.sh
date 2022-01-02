#!/usr/bin/env bash

B='#00000000'
C='#ffffff11'
D='#ffffffff'
W='#ffffffff'
E='#ff0000ff'
G='#040404ff'
F='#444444ff'

i3lock \
--insidever-color=$B \
--ringver-color=$D \
--insidewrong-color=$B \
--ringwrong-color=$G \
--inside-color=$B \
--ring-color=$B \
--line-color=$B \
--separator-color=$B \
--verif-color=$W \
--wrong-color=$E \
--time-color=$W \
--date-color=$W \
--layout-color=$W \
--keyhl-color=$W \
--bshl-color=$G \
\
--image=/home/$USER/Documents/Wallpapers/lockscreen.png \
--fill \
--clock \
--time-str="%H:%M:%S" \
--date-str="%d.%m.%Y" \

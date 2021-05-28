#!/usr/bin/env bash

B='#00000000'
C='#ffffff11'
D='#4444ffff'
W='#ffffffff'
E='#ff0000ff'

i3lock \
--insidever-color=$C \
--ringver-color=$D \
\
--insidewrong-color=$C \
--ringwrong-color=$E \
\
--inside-color=$B \
--ring-color=$D \
--line-color=$B \
--separator-color=$D \
\
--verif-color=$W \
--wrong-color=$W \
--time-color=$W \
--date-color=$W \
--layout-color=$W \
--keyhl-color=$E \
--bshl-color=$E \
\
--blur 8 \
--clock \
--indicator \
--time-str="%H:%M:%S" \
--date-str="%A, %m %Y" \

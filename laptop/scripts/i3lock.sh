#!/usr/bin/env bash

B='#00000000'
C='#ffffff11'
D='#ffffffff'
W='#ffffffff'
E='#ff0000ff'
G='#040404ff'
F='#444444ff'

i3lock \
--color=$G \
--ring-width 4.0 \
--insidever-color=$B \
--ringver-color=$B \
--insidewrong-color=$B \
--ringwrong-color=$B \
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
--clock \
--time-str="%H:%M:%S" \
--date-str="%d.%m.%Y" \
--ignore-empty-password \
--show-failed-attempts \
--noinput-text="</>" \
--wrong-text="<!>" \
--verif-text="<..>" \
--lock-text="<..>" \
--lockfailed-text="<!>" \

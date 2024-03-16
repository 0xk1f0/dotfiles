#!/bin/bash

# dunst
killall -9 -q dunst
cat "/home/$USER/.config/dunst/configrc" \
"/home/$USER/.config/dunst/lib/dunstrc" \
| dunst --startup_notification -conf - &

# eww
killall -9 -q eww
eww daemon &
eww open topbar

# swayidle
killall -9 -q swayidle
LOCKER="hyprlock"
swayidle -w \
timeout 600 $LOCKER \
timeout 30 'if pgrep -x hyprlock; then hyprctl dispatch dpms off; fi' \
timeout 630 'hyprctl dispatch dpms off' \
resume 'hyprctl dispatch dpms on' &

# wallpaper
killall -9 -q rwpspread
rwpspread -b swaybg --hyprlock -pdi "/home/$USER/.wallpaper" &

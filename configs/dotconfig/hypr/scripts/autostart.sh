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
LOCKER="/home/$USER/.config/scripts/wayland/swaylock.sh"
swayidle -w \
timeout 600 $LOCKER \
timeout 60 'if pgrep -x swaylock; then hyprctl dispatch dpms off; fi' \
timeout 660 'hyprctl dispatch dpms off' \
resume 'hyprctl dispatch dpms on' &

# wallpaper
killall -9 -q rwpspread
rwpspread -b swaybg -spdi "/home/$USER/.wallpaper" &

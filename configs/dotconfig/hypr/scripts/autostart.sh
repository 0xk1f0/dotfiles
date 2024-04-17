#!/bin/bash

# dunst
killall -9q dunst
cat "/home/$USER/.config/dunst/configrc" \
"/home/$USER/.config/dunst/lib/dunstrc" \
| dunst -conf - &

# eww
killall -9q eww
eww daemon &
eww open topbar

# swayidle
killall -9q swayidle
swayidle \
timeout 30 'if pgrep -x hyprlock; then hyprctl dispatch dpms off; fi' \
timeout 600 'if ! pgrep -x hyprlock; then hyprlock; fi' \
timeout 630 'hyprctl dispatch dpms off' \
resume 'hyprctl dispatch dpms on' &

# wallpaper
killall -9q rwpspread
rwpspread -b hyprpaper --hyprlock -pdi "/home/$USER/.wallpaper" &

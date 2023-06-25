#!/bin/bash

# refresh pywal
rm -rf /home/$USER/.cache/wal/schemes/
wal -nest -i /home/$USER/.wallpaper

# dunst
killall -q dunst -9
cat "/home/$USER/.config/dunst/configrc" \
"/home/$USER/.config/dunst/lib/dunstrc" \
| dunst --startup_notification -conf - &

# eww
killall -q eww -9
eww daemon &

# eww bar
eww open topbar &

# swayidle
killall -q swayidle -9
LOCKER="/home/$USER/.config/scripts/wayland/swaylock.sh"
swayidle -w \
timeout 600 $LOCKER \
timeout 60 'if pgrep -x swaylock; then hyprctl dispatch dpms off; fi' \
timeout 660 'hyprctl dispatch dpms off' \
resume 'hyprctl dispatch dpms on' &

# wallpaper
rwpspread -wi "/home/$USER/.wallpaper" &

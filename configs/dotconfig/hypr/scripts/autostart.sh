#!/bin/bash

# dunst
killall -q dunst -9
dunst --startup_notification &

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

# swaybg
killall -q swaybg -9
swaybg -m fill -i /home/$USER/.wallpaper &

# refresh pywal
rm -rf /home/$USER/.cache/wal/schemes/
wal -nest -i /home/$USER/.wallpaper

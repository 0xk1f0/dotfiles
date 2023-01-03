#!/bin/bash

# GTK
gsettings set org.gnome.desktop.interface gtk-theme 'Orchis-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Neutral'
gsettings set org.gnome.desktop.interface font-name 'Open Sans 11'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# dunst
killall -q dunst -9
dunst --startup_notification &

# eww
killall -q eww -9
eww daemon &

# waybar
killall -q waybar -9
waybar &

# swayidle
killall -q swayidle -9
LOCKER="/home/$USER/.config/scripts/wayland/swaylock.sh"
swayidle -w \
timeout 600 $LOCKER \
timeout 30 'if pgrep -x swaylock; then hyprctl dispatch dpms off; fi' \
timeout 660 'hyprctl dispatch dpms off' \
resume 'hyprctl dispatch dpms on' &

# swaybg
killall -q swaybg -9
swaybg -m fill -i /home/$USER/.wallpaper &

# refresh pywal
rm -rf /home/$USER/.cache/wal/schemes/
wal -nest -i /home/$USER/.wallpaper

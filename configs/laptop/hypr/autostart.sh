#!/usr/bin/bash

# GTK
gsettings set org.gnome.desktop.interface gtk-theme 'AdG-Dark'
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
LOCKER="/home/$USER/.config/scripts/swaylock.sh"
swayidle -w timeout 900 $LOCKER &

# swaybg
killall -q swaybg -9
swaybg -m fill -i /home/$USER/.wallpaper &

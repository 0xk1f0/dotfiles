#!/usr/bin/bash

killall -q dunst -9
dunst --startup_notification &

# eww
killall -q eww -9
eww daemon &

# GTK
gsettings set org.gnome.desktop.interface gtk-theme 'AdG-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Neutral'
gsettings set org.gnome.desktop.interface font-name 'Open Sans 11'

# waybar
killall -q waybar -9
waybar &

# swaybg
killall -q swaybg -9
swaybg -m fill -i /home/$USER/.wallpaper &

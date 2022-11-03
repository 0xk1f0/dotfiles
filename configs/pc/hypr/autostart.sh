#!/usr/bin/bash
#     __  ___________        __                     __                __
#    / /_<  / __/ __ \      / /_  __  ______  _____/ /___ _____  ____/ /
#   / //_/ / /_/ / / /_____/ __ \/ / / / __ \/ ___/ / __ `/ __ \/ __  /
#  / ,< / / __/ /_/ /_____/ / / / /_/ / /_/ / /  / / /_/ / / / / /_/ /
# /_/|_/_/_/  \____/     /_/ /_/\__, / .___/_/  /_/\__,_/_/ /_/\__,_/
#                              /____/_/

# GTK
gsettings set org.gnome.desktop.interface gtk-theme 'Nordic-v40'
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
timeout 900 $LOCKER \
timeout 960 'hyprctl dispatch dpms off' \
resume 'hyprctl dispatch dpms on' &

# swaybg
killall -q swaybg -9
swaybg -m fill -i /home/$USER/.wallpaper &

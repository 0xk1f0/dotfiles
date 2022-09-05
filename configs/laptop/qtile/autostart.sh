#!/usr/bin/bash

killall -q picom
picom --experimental-backends &

killall -q dunst
dunst --startup_notification &

# eww
killall -q eww
eww daemon &

# feh
feh --bg-fill --no-fehbg /home/$USER/.wallpaper

# numlock
numlockx &

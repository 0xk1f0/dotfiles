#!/usr/bin/bash

# dunst
killall -q dunst
dunst &

# picom
killall -q picom
picom --experimental-backends &
if [ "$(echo $?)" -eq 0 ]; then
    notify-send "Picom Success" "Started Successfully!" -h string:x-canonical-private-synchronous:picom
fi

# nitrogen
nitrogen --restore &
if [ "$(echo $?)" -eq 0 ]; then
    notify-send "Nitrogen Success" "Wallpaper Resored!" -h string:x-canonical-private-synchronous:nitrogen
fi

# numlock
numlockx &

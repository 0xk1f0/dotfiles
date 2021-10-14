#!/usr/bin/bash

# picom
killall -q picom
picom --experimental-backends &

# polybar
killall -q polybar
~/.config/polybar/startbars.sh &

# dunst
killall -q dunst
dunst &

# nitrogen
nitrogen --restore &

# numlock
numlockx &

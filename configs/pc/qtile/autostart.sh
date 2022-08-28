#!/usr/bin/env bash

# picom
killall -q picom
picom --experimental-backends &

# dunst
killall -q dunst
dunst --startup_notification &

# eww
killall -q eww
eww daemon &

# nitrogen
nitrogen --restore &

# numlock
numlockx &

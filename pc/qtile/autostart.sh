#!/usr/bin/env bash

# picom
killall -q picom
picom --experimental-backends &

# dunst
killall -q dunst
dunst --startup_notification &

# nitrogen
nitrogen --restore &

# numlock
numlockx &

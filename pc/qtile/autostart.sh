#!/usr/bin/bash

# picom
picom --experimental-backends &

# dunst
dunst --startup_notification &

# nitrogen
nitrogen --restore &

# numlock
numlockx &

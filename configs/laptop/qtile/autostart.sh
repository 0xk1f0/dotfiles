#!/usr/bin/bash

killall -q picom
picom --experimental-backends &

killall -q dunst
dunst --startup_notification &

nitrogen --restore &

# numlock
numlockx &

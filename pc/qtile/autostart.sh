#!/usr/bin/bash

# picom
picom --experimental-backends &
if [ "$(echo $?)" -eq 0 ]; then
    notify-send "Picom Success" "Started Successfully!" -h string:x-canonical-private-synchronous:picom
fi

# numlock
numlockx &

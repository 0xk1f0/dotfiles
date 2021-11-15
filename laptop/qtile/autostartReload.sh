#!/usr/bin/bash

# wait
sleep 1

# dunst
killall -q dunst
dunst --startup_notification &

# nitrogen
nitrogen --restore &
if [ "$(echo $?)" -eq 0 ]; then
    notify-send "Nitrogen Success" "Wallpaper Resored!" -h string:x-canonical-private-synchronous:ni
trogen
fi


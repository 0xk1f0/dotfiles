#Down Volume
pamixer -d 5

#alert user
notify-send "Volume Decrease" "$(pamixer --get-volume)" -h string:x-canonical-private-synchronous:volume

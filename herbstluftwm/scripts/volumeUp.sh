#Up Volume
pamixer -i 5

#alert user
notify-send "Volume Increase" "$(pamixer --get-volume)" -h string:x-canonical-private-synchronous:volume

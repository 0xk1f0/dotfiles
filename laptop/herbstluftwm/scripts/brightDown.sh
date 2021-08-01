#Down Brightness
brightnessctl s 10-

#alert user
notify-send "Brightness Decrease" "$(brightnessctl g)" -h string:x-canonical-private-synchronous:bright

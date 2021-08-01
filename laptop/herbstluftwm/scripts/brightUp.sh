#Up Brightness
brightnessctl s +10

#alert user
notify-send "Brightness Increase" "$(brightnessctl g)" -h string:x-canonical-private-synchronous:bright

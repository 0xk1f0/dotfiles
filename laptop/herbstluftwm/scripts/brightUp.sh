#Up Brightness
brightnessctl s +5%

#alert user
notify-send "Brightness Increase" "$(echo "(($(brightnessctl g)/255)*100)" | bc -l | awk '{print int($0)}'
)%" -h string:x-canonical-private-synchronous:bright

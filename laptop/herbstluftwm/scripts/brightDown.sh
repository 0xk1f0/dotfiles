#Down Brightness
brightnessctl s 5-%

#alert user
notify-send "Brightness Decrease" "$(echo "(($(brightnessctl g)/255)*100)" | bc -l | awk '{print ($0-int($0)>0)?int($0)+1:int($0)}'
)%" -h string:x-canonical-private-synchronous:bright

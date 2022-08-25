#!/usr/bin/env bash

#Up Volume
pamixer -i 5

#alert user
#notify-send "Volume Increase" "$(pamixer --get-volume)" -h string:x-canonical-private-synchronous:volume
dunstify -h string:x-dunst-stack-tag:volume "Volume Increase" "$(pamixer --get-volume)"

# play test sound
aplay volume.wav

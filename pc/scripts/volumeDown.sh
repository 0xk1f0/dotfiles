#!/usr/bin/env bash

#Down Volume
pamixer -d 5

#alert user
#notify-send "Volume Decrease" "$(pamixer --get-volume)" -h string:x-canonical-private-synchronous:volume
dunstify -h string:x-dunst-stack-tag:volume "Volume Decrease" "$(pamixer --get-volume)"

# play test sound
aplay volume.wav

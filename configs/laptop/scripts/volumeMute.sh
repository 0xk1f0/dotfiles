#!/usr/bin/env bash

#Mute
pamixer -t

if [ $(pamixer --get-mute) == false ]; then

	#alert user
	#notify-send "Volume Unmuted:" "$(pamixer --get-volume)" -h string:x-canonical-private-synchronous:volume
	dunstify -h string:x-dunst-stack-tag:volume "Volume Unmuted:" "$(pamixer --get-volume)"

else

	#alert user
	#notify-send "Volume Muted" -h string:x-canonical-private-synchronous:volume
	dunstify -h string:x-dunst-stack-tag:volume "Volume Muted"

fi

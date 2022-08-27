#!/usr/bin/env bash

#Mute
pamixer -t

if [ $(pamixer --get-mute) == false ]; then

	#alert user
	notify-send "Volume Unmuted:" "$(pamixer --get-volume)" -h string:x-canonical-private-synchronous:volume

else

	#alert user
	notify-send "Volume Muted" -h string:x-canonical-private-synchronous:volume

fi


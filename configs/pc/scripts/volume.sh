#!/usr/bin/env bash

# bash strict
set -uo pipefail

# what the fuck
getVol() {
    STATUS="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f 2)"
    if echo $STATUS | grep -E '^0\.[0-9][0-9]$' >> /dev/null; then
        STATUS="$(echo $STATUS \
        | cut -d '.' -f 2 \
        | sed 's/^0[0-9]/'"$(echo $STATUS | cut -c 4-)"'/')"
    else
        STATUS="$(echo $STATUS | tr -d '.')"
    fi
	echo "$STATUS"
}

alert() {
	# alert user
	dunstify \
	-a "chgVol" \
	-r 66199 \
	-u low \
	-i "$ICON" \
	-h int:value:$STATUS \
	"Volume:" "$STATUS\%"
}

# match keys
case $1 in
    up)
        # up Volume
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        getVol
        ICON="audio-volume-high"
        alert
        ;;
    down)
        # down Volume
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        getVol
        ICON="audio-volume-low"
        alert
        ;;
    mute)
        # mute
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep "MUTE" >> /dev/null
        if [ $? -eq 0 ]; then 
            STATUS="Muted"
            ICON="audio-volume-muted"
        else 
            STATUS="Unmuted"
            ICON="audio-volume-high"
        fi
        alert
        ;;
	getVolume)
    	getVol
        ;;
esac

#!/usr/bin/env bash

# bash strict
set -uo pipefail

case $1 in
    up)
        # up Volume
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        STATUS="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d '.' -f 2)%"
        ICON="audio-volume-high"
        ;;
    down)
        # down Volume
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        STATUS="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d '.' -f 2)%"
        ICON="audio-volume-low"
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
        ;;
esac

# alert user
dunstify -a "chgVol" -r 66199 -u low -i "$ICON" "Volume:" "$STATUS"

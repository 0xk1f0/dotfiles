#!/usr/bin/env bash

# bash strict
set -uo pipefail

case $1 in
    prev)
        # play prev
        playerctl previous
        STATUS="Previous"
        ICON="media-skip-backward"
        ;;
    next)
        # play next
        playerctl next
        STATUS="Next"
        ICON="media-skip-forward"
        ;;
    pp)
        # playPause media
        playerctl play-pause
        STATUS=$(playerctl status)
        if [ $STATUS != "Playing" ]; then
            STATUS="Play"
            ICON="media-play"
        else
            STATUS="Pause"
            ICON="media-pause"
        fi

        # alert user
        dunstify -a "chgMed" -r 33166 -u low -i "$ICON" "Media:" "$STATUS"
        ;;
esac

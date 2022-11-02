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
        playerctl play-pause && STATUS=
        STATUS="$(playerctl status)"
        ICON="media-play"
        ;;
esac

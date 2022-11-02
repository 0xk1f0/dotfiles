#!/usr/bin/env bash

# bash strict
set -uo pipefail

case $1 in
    up)
        # up Volume
        brightnessctl s 5+
        STATUS="$(brightnessctl g)"
        ICON="xfpm-brightness-lcd"
        ;;
    down)
        # down Volume
        brightnessctl s 5-
        STATUS="$(brightnessctl g)"
        ICON="xfpm-brightness-lcd"
        ;;
esac

# alert user
dunstify -a "chgBrt" -r 55177 -u low -i "$ICON" "Brightness:" "$STATUS"

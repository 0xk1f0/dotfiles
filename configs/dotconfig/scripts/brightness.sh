#!/usr/bin/env bash

# bash strict
set -uo pipefail

case $1 in
    up)
        # up Volume
        brightnessctl s 5%+
        ICON="xfpm-brightness-lcd"
        ;;
    down)
        # down Volume
        brightnessctl s 5%-
        ICON="xfpm-brightness-lcd"
        ;;
esac

# calc percent value
PERCENT_BRIGHTNESS=$(brightnessctl i | grep "Current" | cut -d "(" -f 2 | tr -d ")")

# alert user
dunstify \
-a "chgBrt" \
-r 55177 \
-u low \
-i "$ICON" "Brightness:" "$PERCENT_BRIGHTNESS" \
-h int:value:$PERCENT_BRIGHTNESS

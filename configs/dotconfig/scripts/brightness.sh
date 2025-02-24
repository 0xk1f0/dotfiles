#!/usr/bin/env bash

# bash strict
set -uo pipefail

# check if brightnessctl is available
if ! command -v brightnessctl >> /dev/null; then
    exit 1
fi

# match options
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
    *)
        exit 1
        ;;
esac

# calc percent value
PERCENT_BRIGHTNESS=$(brightnessctl i | grep "Current" | cut -d "(" -f 2 | tr -d ")")

# alert user
if command -v notify-send >> /dev/null; then
    notify-send \
    -a "chgBrt" \
    -r 55177 \
    -u low \
    -i "$ICON" "Brightness" "$PERCENT_BRIGHTNESS" \
    -h int:value:"$PERCENT_BRIGHTNESS"
fi

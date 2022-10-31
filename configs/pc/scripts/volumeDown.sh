#!/usr/bin/env bash

#Down Volume
wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

#alert user
dunstify -h string:x-dunst-stack-tag:volume "Volume Decrease" \
"$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d '.' -f 2)"

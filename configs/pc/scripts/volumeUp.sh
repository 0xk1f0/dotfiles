#!/usr/bin/env bash

#Up Volume
wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+

#alert user
dunstify -h string:x-dunst-stack-tag:volume "Volume Increase" \
"$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d '.' -f 2)"

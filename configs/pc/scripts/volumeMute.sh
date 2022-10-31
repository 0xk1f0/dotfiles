#!/usr/bin/env bash

#Mute
wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

#alert user
dunstify -h string:x-dunst-stack-tag:volume "Volume Muted:" "$(pamixer --get-mute)"

#!/usr/bin/env bash

LOCKER="/home/$USER/.config/scripts/swaylock.sh"

swayidle -w \
timeout 120 'hyprctl dispatch dpms off' \
timeout 150 $LOCKER \
resume 'hyprctl dispatch dpms on' \

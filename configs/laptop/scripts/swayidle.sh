#!/usr/bin/env bash

LOCKER="/home/$USER/.config/scripts/swaylock.sh"

swayidle -w \
timeout 600 'hyprctl dispatch dpms off' \
timeout 720 $LOCKER \
resume 'hyprctl dispatch dpms on' \

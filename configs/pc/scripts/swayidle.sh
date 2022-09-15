#!/usr/bin/env bash

LOCKER="/home/$USER/.config/scripts/swaylock.sh"

swayidle -w \
timeout 600 $LOCKER \

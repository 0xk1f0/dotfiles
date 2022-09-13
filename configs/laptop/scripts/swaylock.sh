#!/usr/bin/env bash

B='#00000000'
G='#040404ff'

swaylock -f \
--color=$G \
--image /home/$USER/.wallpaper \
--scaling fill \
--indicator-radius 80 \
--inside-color=$B \
--ring-color=$B \
--line-color=$B \
--separator-color=$B \
--ignore-empty-password \
--show-failed-attempts \

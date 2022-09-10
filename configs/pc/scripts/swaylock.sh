#!/usr/bin/env bash

B='#00000000'
C='#ffffff11'
D='#ffffffff'
W='#ffffffff'
E='#ff0000ff'
G='#040404ff'
F='#444444ff'

swaylock \
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

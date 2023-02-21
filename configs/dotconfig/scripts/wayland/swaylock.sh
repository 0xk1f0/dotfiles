#!/usr/bin/env bash

T='#00000000'
G='#040404ff'
R='#ff0404ff'
W='#ffffffff'
B='#000000ff'

swaylock -f \
--color=$G \
--image /home/$USER/.lockpaper \
--scaling fill \
--indicator-radius 80 \
--indicator-thickness 8 \
--inside-color=$T \
--inside-clear-color=$T \
--inside-caps-lock-color=$T \
--inside-ver-color=$T \
--inside-wrong-color=$T \
--key-hl-color=$W \
--layout-bg-color=$T \
--layout-border-color=$T \
--layout-text-color=$T \
--ring-color=$T \
--ring-clear-color=$T \
--ring-caps-lock-color=$T \
--ring-ver-color=$T \
--ring-wrong-color=$R \
--bs-hl-color=$W \
--caps-lock-bs-hl-color=$W \
--caps-lock-key-hl-color=$W \
--line-color=$T \
--line-caps-lock-color=$T \
--line-clear-color=$T \
--line-ver-color=$T \
--line-wrong-color=$T \
--separator-color=$T \
--font="Open Sans SemiBold" \
--text-color=$W \
--text-clear-color=$W \
--text-caps-lock-color=$W \
--text-ver-color=$W \
--text-wrong-color=$R \
--ignore-empty-password \
--show-failed-attempts \

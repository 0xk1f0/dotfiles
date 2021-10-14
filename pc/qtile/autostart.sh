#!/usr/bin/bash

#polybar
killall -q polybar
~/.config/polybar/startbars-qtile.sh

# dunst
killall -q dunst
dunst &

# nitrogen
nitrogen --restore &

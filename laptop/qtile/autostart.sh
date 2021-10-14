#!/usr/bin/bash

# dunst
killall -q dunst
dunst &

# nitrogen
nitrogen --restore &

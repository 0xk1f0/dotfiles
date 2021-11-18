#!/bin/sh
xrandr --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-1 --primary --mode 2560x1440 --pos 1080x152 --rotate normal --output DisplayPort-2 --mode 1920x1080 --pos 0x0 --rotate left
xrandr --output DisplayPort-1 --mode 2560x1440 --rate 165
xrandr --output DisplayPort-2 --set TearFree on
xrandr --output DisplayPort-1 --set TearFree off

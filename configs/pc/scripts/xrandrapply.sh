#!/bin/sh
xrandr --output DisplayPort-0 --primary --mode 2560x1440 --pos 1080x144 --rotate normal --output DisplayPort-1 --mode 1920x1080 --pos 0x0 --rotate left --output DisplayPort-2 --off --output HDMI-A-0 --off
xrandr --output DisplayPort-0 --mode 2560x1440 --rate 165
xrandr --output DisplayPort-1 --mode 1920x1080 --rate 144
xrandr --output DisplayPort-0 --set TearFree off
xrandr --output DisplayPort-1 --set TearFree on

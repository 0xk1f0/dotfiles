#!/bin/sh
xrandr --output DisplayPort-1 --off --output DisplayPort-2 --off --output DisplayPort-0 --primary --mode 2560x1440 --pos 1080x152 --rotate normal --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate left
xrandr --output DisplayPort-0 --mode 2560x1440 --rate 165
xrandr --output HDMI-A-0 --set TearFree on
xrandr --output DisplayPort-0 --set TearFree off

#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch bar1 and bar2
polybar main-hlwm & disown
polybar sec-hlwm & disown

#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch bar
#polybar main-hlwm & disown
polybar main-leftwm & disown

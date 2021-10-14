#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch bar1 and bar2
polybar main-qtile & disown
polybar sec-qtile & disown

#!/usr/bin/env bash

# bash strict
set -uo pipefail

# set paths
BAT_PATH="/sys/class/power_supply/BAT0"
ADP_PATH="/sys/class/power_supply/ADP1"
ALT_ADP_PATH="/sys/class/power_supply/AC"

# check for battery
if [ ! -e "$BAT_PATH" ]; then
    exit 1
fi

# check for adapter
if [ ! -e "$ADP_PATH" ]; then
    if [ ! -e "$ALT_ADP_PATH" ]; then
        exit 1
    else
        ADP_PATH=$ALT_ADP_PATH
    fi
fi

# match options
case $1 in
    level)
        cat "$BAT_PATH/capacity"
    ;;
    plugged)
        cat "$ADP_PATH/online"
    ;;
    percent)
        echo "$(cat $BAT_PATH/capacity)%"
    ;;
esac

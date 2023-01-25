#!/bin/bash

# bash strict
set -uo pipefail

# set paths
BATPATH="/sys/class/power_supply/BAT0"
ADPPATH="/sys/class/power_supply/ADP1"

# check for battery
if [ ! -e "$BATPATH" ]; then
  exit 0
fi

# check for adapter
if [ ! -e "$ADPPATH" ]; then
  exit 0
fi

# match options
case $1 in
    level)
        echo "$(cat $BATPATH/capacity)"
        ;;
    plugged)
        echo "$(cat $ADPPATH/online)"
        ;;
esac


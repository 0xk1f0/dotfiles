#!/bin/bash

# bash strict
set -uo pipefail

# convert the wpctl output
doConvert() {
    if echo $STATUS | grep -E '^0\.[0-9][0-9]$' >> /dev/null; then
        STATUS="$(echo $STATUS \
        | cut -d '.' -f 2 \
        | sed 's/^0[0-9]/'"$(echo $STATUS | cut -c 4-)"'/')"
    else
        STATUS="$(echo $STATUS | tr -d '.')"
    fi
    echo "$STATUS"
}

# match options
case $1 in
    sink)
        STATUS="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f 2)"
        doConvert
        ;;
    source)
        STATUS="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | cut -d ' ' -f 2)"
        doConvert
        ;;
    sink-set)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ "$2%"
        ;;
    source-set)
        wpctl set-volume @DEFAULT_AUDIO_SOURCE@ "$2%"
        ;;
esac

#!/usr/bin/env bash

# bash strict
set -uo pipefail

# convert the wpctl output
doConvert() {
    STATUS=$(awk "BEGIN {print $STATUS * 100}")
    LEVEL=$STATUS
    printf "%s\n" "$STATUS"
}

# alert user
alert() {
    dunstify \
    -a "chgVol" \
    -r 66199 \
    -u low \
    -i "$ICON" \
    -h int:value:"$LEVEL" \
    "Volume:" "$STATUS"
}

# match keys
case $1 in
    sink)
        STATUS="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')"
        doConvert
    ;;
    source)
        STATUS="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2}')"
        doConvert
    ;;
    sink-set)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ "$2%"
        STATUS="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')"
        doConvert
        ICON="audio-volume-high"
        alert
    ;;
    source-set)
        wpctl set-volume @DEFAULT_AUDIO_SOURCE@ "$2%"
        STATUS="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2}')"
        doConvert
        ICON="audio-volume-high"
        alert
    ;;
    sink-incr)
        STATUS="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')"
        doConvert
        if [[ $STATUS -lt 100 ]] && [[ "$2" == "+" ]]; then
            wpctl set-volume @DEFAULT_AUDIO_SINK@ "$3%$2"
            STATUS="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')"
            doConvert
        elif [[ $STATUS -gt 0 ]] && [[ "$2" == "-" ]]; then
            wpctl set-volume @DEFAULT_AUDIO_SINK@ "$3%$2"
            STATUS="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')"
            doConvert
        fi
        ICON="audio-volume-high"
        alert
    ;;
    sink-mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep "MUTE" >> /dev/null; then
            STATUS="Muted"
            LEVEL=0
            ICON="audio-volume-muted"
        else
            LEVEL="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')"
            LEVEL=$(awk "BEGIN {print $LEVEL * 100}")
            STATUS="Unmuted: $LEVEL"
            ICON="audio-volume-high"
        fi
        alert
    ;;
    source-mute)
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep "MUTE" >> /dev/null; then
            STATUS="Muted"
            LEVEL=0
            ICON="audio-volume-muted"
        else
            LEVEL="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2}')"
            LEVEL=$(awk "BEGIN {print $LEVEL * 100}")
            STATUS="Unmuted: $LEVEL"
            ICON="audio-volume-high"
        fi
        alert
    ;;
esac

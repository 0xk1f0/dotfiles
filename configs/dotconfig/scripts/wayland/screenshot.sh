#!/usr/bin/env bash

# bash strict
set -uo pipefail

# check for running instance
if ! pgrep -x slurp && ! pgrep -x grim; then
    # take screenshot
    if grim -g "$(slurp -d -w 0 -b '#000000cc' -c '#ffffffff' -B '#ffffffff')" - | wl-copy; then
        #taken screenshot, inform user
        SCREEN_STATUS="Copied to Clipboard!"
    else
        #exitcode is non zero, screenshot aborted
        SCREEN_STATUS="Nothing Captured!"
    fi
    dunstify \
    -a "tkScr" \
    -r 44188 \
    -u low \
    -i "window_fullscreen" "Screenshot" "$SCREEN_STATUS"
fi

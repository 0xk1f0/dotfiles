#!/usr/bin/env bash

# bash strict
set -uo pipefail

# check for running instance
if not pgrep -x slurp && not pgrep -x grim; then
    # take screenshot
    grim -g "$(slurp -d -w 0 -b '#000000cc' -c '#ffffffff' -B '#ffffffff')" - | wl-copy
    #notify user depending on exit code
    if [ "$?" -eq 0 ]; then
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
    -i "window_fullscreen" "Screenshot:" "$SCREEN_STATUS"
fi

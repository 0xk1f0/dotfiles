#!/usr/bin/env bash

# bash strict
set -uo pipefail

# check if slurp, grim and wl-copy are available
if ! command -v slurp >> /dev/null && command -v grim >> /dev/null && command -v wl-copy >> /dev/null; then
    exit 1
fi

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
    # notify user
    if command -v notify-send >> /dev/null; then
        notify-send \
        -a "tkScr" \
        -r 44188 \
        -u low \
        -i "window_fullscreen" "Screenshot" "$SCREEN_STATUS"
    fi
fi

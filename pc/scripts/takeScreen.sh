#!/usr/bin/env bash

TIMESTAMP=$(date +%H_%M_%S)

#take screenshot and copy it to clipboard
if [ $1 == "sel" ]; then
    maim -su /tmp/screenshot_$TIMESTAMP.png && xclip -selection clipboard -t image/png -i /tmp/screenshot_$TIMESTAMP.png
else
    x=3
    while [ $x -gt 0 ]; do
    dunstify -h string:x-dunst-stack-tag:screenshot "Taking Screenshot in..." "$x"
    x=$[$x-1]
    sleep 1
    done
    maim -u /tmp/screenshot_$TIMESTAMP.png && xclip -selection clipboard -t image/png -i /tmp/screenshot_$TIMESTAMP.png
fi

exitCode=$(echo $?)

#notify user depending on exit code
if [ "$exitCode" -eq 0 ]; then
    #taken screenshot, inform user
    dunstify -h string:x-dunst-stack-tag:screenshot "Screenshot Captured" "Copied to Clipboard!"
else
    #exitcode is non zero, screenshot aborted, alert user
    dunstify -h string:x-dunst-stack-tag:screenshot "Screenshot Aborted" "Nothing Captured!"
fi

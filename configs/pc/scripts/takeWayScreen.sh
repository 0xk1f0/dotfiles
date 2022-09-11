#!/usr/bin/env bash

TIMESTAMP=$(date +%H_%M_%S)

grim -g "$(slurp)" - | wl-copy

exitCode=$(echo $?)

#notify user depending on exit code
if [ "$exitCode" -eq 0 ]; then
    #taken screenshot, inform user
    dunstify -h string:x-dunst-stack-tag:screenshot "Screenshot Captured" "Copied to Clipboard!"
else
    #exitcode is non zero, screenshot aborted, alert user
    dunstify -h string:x-dunst-stack-tag:screenshot "Screenshot Aborted" "Nothing Captured!"
fi

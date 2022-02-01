#!/usr/bin/env bash

TIMESTAMP=$(date +%H_%M_%S)

#take screenshot and copy it to clipboard
maim -su /tmp/screenshot_$TIMESTAMP.png && xclip -selection clipboard -t image/png -i /tmp/screenshot_$TIMESTAMP.png

exitCode=$(echo $?)

#notify user depending on exit code
if [ "$exitCode" -eq 0 ]; then

#taken screenshot, inform user
notify-send "Screenshot Captured" "Copied to Clipboard!" -h string:x-canonical-private-synchronous:screenshot

else

#exitcode is non zero, screenshot aborted, alert user
notify-send "Screenshot Aborted" "Nothing Captured!" -h string:x-canonical-private-synchronous:screenshot

fi

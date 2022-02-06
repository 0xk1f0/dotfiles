#!/usr/bin/env bash

TIMESTAMP=$(date +%H_%M_%S)
x=5

while [ $x -gt 0 ]; do

#notify-send "Taking Screenshot in..." "$x" -h string:x-canonical-private-synchronous:screenshot
dunstify -h string:x-dunst-stack-tag:screenshot "Taking Screenshot in..." "$x"
x=$[$x-1]
sleep 1

done

#take screenshot and copy it to clipboard
maim -u /tmp/screenshot_$TIMESTAMP.png && xclip -selection clipboard -t image/png -i /tmp/screenshot_$TIMESTAMP.png

exitCode=$(echo $?)

#notify user depending on exit code
if [ "$exitCode" -eq 0 ]; then

#taken screenshot, inform user
#notify-send "Screenshot Captured" "Copied to Clipboard!" -h string:x-canonical-private-synchronous:screenshot
dunstify -h string:x-dunst-stack-tag:screenshot "Screenshot Captured" "Copied to Clipboard!"

else

#exitcode is non zero, screenshot aborted, alert user
#notify-send "Screenshot Aborted" "Nothing Captured!" -h string:x-canonical-private-synchronous:screenshot
dunstify -h string:x-dunst-stack-tag:screenshot "Screenshot Aborted" "Nothing Captured!"

fi

#take screenshot and copy it to clipboard
maim -s /tmp/screenshot.png && xclip -selection clipboard -t image/png -i /tmp/screenshot.png

#notify user
notify-send "Screenshot Captured" "Copied to Clipboard!" -h string:x-canonical-private-synchronous:screenshot

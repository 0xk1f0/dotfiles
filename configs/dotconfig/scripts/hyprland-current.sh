#!/usr/bin/env bash

/bin/hyprctl monitors -j | /bin/jq '.[] | select(.focused) | .activeWorkspace.id'

/bin/socat -u UNIX-CONNECT:${XDG_RUNTIME_DIR}/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
    /bin/stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}'

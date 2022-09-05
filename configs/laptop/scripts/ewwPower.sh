#!/usr/bin/env bash

# open powermenu
eww open-many --toggle powermenu-exit powermenu && \
# wait 3 seconds
sleep 3 && \
# close it again
eww close powermenu-exit powermenu

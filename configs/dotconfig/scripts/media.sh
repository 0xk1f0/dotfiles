#!/usr/bin/env bash

# bash strict
set -uo pipefail

# check if playerctl is available
if ! command -v playerctl >> /dev/null; then
    exit 1
fi

# match options
case $1 in
    prev)
        # play prev
        playerctl previous
        ;;
    next)
        # play next
        playerctl next
        ;;
    pp)
        # playPause media
        playerctl play-pause
        ;;
    *)
        exit 1
        ;;
esac

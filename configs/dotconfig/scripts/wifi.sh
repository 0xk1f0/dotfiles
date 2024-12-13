#!/usr/bin/env bash

# bash strict
set -uo pipefail

# check if nmcli is available
if ! command -v nmcli >> /dev/null; then
    exit 1
fi

# match options
case $1 in
    name)
        nmcli d | grep -e "^wlan0.*$" | awk '{print $4}'
        ;;
    state)
        nmcli d | grep -e "^wlan0.*$" | awk '{print $3}'
        ;;
    *)
        exit 1
        ;;
esac

#!/usr/bin/env bash

# bash strict
set -uo pipefail

# match options
case $1 in
    name)
        nmcli d | grep -e "^wlan0.*$" | awk '{print $4}'
        ;;
    state)
        nmcli d | grep -e "^wlan0.*$" | awk '{print $3}'
        ;;
esac

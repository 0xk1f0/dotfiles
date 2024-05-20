#!/usr/bin/env bash

# bash strict
set -uo pipefail

# match options
case $1 in
    name)
        nmcli d | grep "wifi" | awk '{print $4}'
        ;;
    state)
        nmcli d | grep "wifi" | awk '{print $3}'
        ;;
esac

#!/bin/bash

# bash strict
set -uo pipefail

# match options
case $1 in
    name)
        echo $(nmcli d | grep "wifi" | awk '{print $4}')
        ;;
    state)
        echo $(nmcli d | grep "wifi" | awk '{print $3}')
        ;;
esac

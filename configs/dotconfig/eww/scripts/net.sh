#!/bin/bash

# bash strict
set -uo pipefail

# match options
case $1 in
    type)
        if [[ $(cat /sys/class/net/w*/operstate 2> /dev/null) == "up" ]]; then
            echo ""
        elif [[ $(cat /sys/class/net/eth*/operstate 2> /dev/null) == "up" ]]; then
            echo ""
        fi
        ;;
    status)
        echo "$(nmcli g | tail -n 1 | awk '{print $1}')"
        ;;
esac

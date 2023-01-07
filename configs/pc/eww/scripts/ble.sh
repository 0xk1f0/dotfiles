#!/bin/bash

# bash strict
set -uo pipefail

# match options
case $1 in
    toggle)
        STATUS=$(bluetoothctl show | grep "Powered" | awk '{print $2}')
        if [[ $STATUS == "no" ]]; then
            bluetoothctl power on > /dev/null
        else
            bluetoothctl power off > /dev/null
        fi
        ;;
    status)
        echo $(bluetoothctl show | grep "Powered" | awk '{print $2}')
        ;;
esac

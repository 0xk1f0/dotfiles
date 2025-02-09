#!/usr/bin/env bash

# bash strict
set -uo pipefail

# check if nmcli is available
if ! command -v nmcli >> /dev/null; then
    exit 1
fi

# match options
case $1 in
    connectivity)
        nmcli --fields CONNECTIVITY g \
        | tail -n 1 \
        | tr -d ' '
        ;;
    wifi-name)
        if [ "$(nmcli --fields WIFI-HW r | tail -n1 | tr -d ' ')" != "missing" ]; then
            WIFI_DEVICE=$(nmcli --fields TYPE,DEVICE d \
            | /bin/grep -m 1 'wifi' \
            | tr -s ' ' ' ' \
            | awk '{print $2}')
            WIFI_NAME=$(nmcli d show ${WIFI_DEVICE} \
            | /bin/grep -m 1 'GENERAL.CONNECTION' \
            | tr -d ' ' \
            | cut -d ':' -f2)
            if [[ $WIFI_NAME != '' ]]; then
                echo ${WIFI_NAME}
            else
                echo '--'
            fi
        else
            echo 'none'
        fi
        ;;
    wifi-state)
        if [ "$(nmcli --fields WIFI-HW r | tail -n1 | tr -d ' ')" != "missing" ]; then
            WIFI_DEVICE=$(nmcli --fields TYPE,DEVICE d \
            | /bin/grep -m 1 'wifi' \
            | tr -s ' ' ' ' \
            | awk '{print $2}')
            WIFI_STATE=$(nmcli d show ${WIFI_DEVICE} \
            | /bin/grep -m 1 'GENERAL.STATE' \
            | tr -d ' ' \
            | cut -d ':' -f2)
            if [[ $WIFI_STATE == *'connected'* ]]; then
                echo 'connected'
            else
                echo 'disconnected'
            fi
        else
            echo 'none'
        fi
        ;;
    ether-state)
        ETHERNET_DEVICE=$(nmcli --fields TYPE,DEVICE d \
        | /bin/grep -m 1 'ethernet' \
        | tr -s ' ' ' ' \
        | awk '{print $2}')
        ETHERNET_STATE=$(nmcli d show ${ETHERNET_DEVICE} \
        | /bin/grep -m 1 'GENERAL.STATE' \
        | tr -d ' ' \
        | cut -d ':' -f2)
        if [[ $ETHERNET_STATE == *'connected'* ]]; then
            echo 'connected'
        else
            echo 'disconnected'
        fi
        ;;
    *)
        exit 1
        ;;
esac

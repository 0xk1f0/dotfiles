#!/usr/bin/env bash

# bash strict
set -uo pipefail

# check if polychromatic is available
if ! command -v polychromatic-cli >> /dev/null; then
    exit 1
fi

# match options
case $1 in
    level)
        /usr/bin/razer-cli -l \
        | /bin/grep 'charge' \
        | /bin/cut -d ':' -f 2 \
        | /bin/tr -d ' '
        ;;
    charging)
        if $(/usr/bin/razer-cli -l \
        | /bin/grep 'charging: True' > /dev/null); then
            echo 1
        else
            echo 0
        fi
        ;;
    *)
        exit 1
        ;;
esac

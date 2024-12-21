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
        /bin/polychromatic-cli -k \
        | /bin/grep 'Battery' \
        | /bin/cut -d 'y' -f 2 \
        | /bin/cut -d '%' -f 1
        ;;
    charging)
        if $(/bin/polychromatic-cli -k \
        | /bin/grep 'charging' > /dev/null); then
            echo 1
        else
            echo 0
        fi
        ;;
    *)
        exit 1
        ;;
esac

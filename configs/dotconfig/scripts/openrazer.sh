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
        | grep 'Battery' \
        | cut -d 'y' -f 2 \
        | cut -d '%' -f 1
        ;;
    *)
        exit 1
        ;;
esac

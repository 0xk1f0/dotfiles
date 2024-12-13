#!/usr/bin/env bash

# bash strict
set -uo pipefail

# notify alert user
alert() {
    if command -v dunstify >> /dev/null; then
        dunstify \
        -a "bootHi" \
        -u low \
        "Welcome ${USER}!" "Running: $(uname -r)"
    fi
}

# audible boot sound
audioGreet() {
    if command -v sox >> /dev/null; then
        play "/home/${USER}/.config/scripts/assets/boot.mp3"
    fi
}

# wait a bit, then greet
sleep 2
alert && audioGreet

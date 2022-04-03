#!/bin/bash

# "bash strict mode"
set -uo pipefail

# give user feedback
scriptFeedback() {
    case $1 in
        prompt)
            printf "[\e[1m\e[9%sm%s\e[0m]%s\n" "3" "?" " $2" 
            ;;
        error)
            printf "[\e[1m\e[9%sm%s\e[0m]%s\n" "1" "✗" " $2" 
            ;;
        success)
            printf "[\e[1m\e[9%sm%s\e[0m]%s\n" "2" "✓" " $2" 
            ;;
        proc)
            printf "[\e[1m\e[9%sm%s\e[0m]%s\n" "3" ".." " $2" 
            ;;
        normExit)
            printf "[\e[1m\e[9%sm%s\e[0m]%s\n" "1" "/" " $2" 
            ;;
    esac
}

binExt="./other/bin"
combExt="./combined"

combinedLIST=(
    "$combExt/kitty"
    "$combExt/ncspot"
    "$combExt/pacwall"
    "$combExt/nano"
    "$combExt/picom"
    "$combExt/zathura"
    "$combExt/pcmanfm"
    "$combExt/libfm"
    "$combExt/paru"
    "$combExt/easyeffects"
    "$combExt/starship.toml"
    "$combExt/electron-flags.conf"
    "$combExt/electron16-flags.conf"
)

binLIST=(
    "$binExt/mntExt"
    "$binExt/mntSMB"
    "$binExt/sharePwnagotchy"
    "$binExt/barrierLayout"
    "$binExt/rsyncToShare"
)

scriptFeedback proc "Syncing combined configs"
rsync -aq --delete $(echo "${combinedLIST[@]}") /home/$USER/.config/
rsync -aq --delete ./combined/.bashrc /home/$USER/
scriptFeedback success "Done"

scriptFeedback proc "Syncing ~/.local/bin/ scripts"
rsync -aq --delete $(echo "${binLIST[@]}") /home/$USER/.local/bin/
scriptFeedback success "Done"

exit 0

#!/bin/bash

# "bash strict mode"
set -uo pipefail

# give user feedback
scriptFeedback() {
    case $1 in
        success)
            printf "[\e[1m\e[9%sm%s\e[0m]%s\n" "2" "✓" " $2" 
            ;;
        proc)
            printf "[\e[1m\e[9%sm%s\e[0m]%s\n" "3" ".." " $2" 
            ;;
    esac
}

binExt="./configs/bin"
combExt="./configs/combined"

combinedLIST=(
    "$combExt/kitty"
    "$combExt/ncspot"
    "$combExt/nano"
    "$combExt/picom"
    "$combExt/zathura"
    "$combExt/mpv"
    "$combExt/btop"
    "$combExt/paru"
    "$combExt/easyeffects"
    "$combExt/starship.toml"
    "$combExt/electron-flags.conf"
    "$combExt/Thunar"
    "$combExt/pipewire"
)

binLIST=(
    "$binExt/mntExt"
    "$binExt/mntSMB"
    "$binExt/sharePwnagotchy"
    "$binExt/rsyncToShare"
    "$binExt/clnJnk"
    "$binExt/setWall"
)

scriptFeedback proc "Syncing combined configs"
/bin/rsync -aq --delete $(echo "${combinedLIST[@]}") /home/$USER/.config/
/bin/rsync -aq --delete ./configs/combined/.bashrc /home/$USER/
scriptFeedback success "Done"

scriptFeedback proc "Syncing ~/.local/bin/ scripts"
/bin/rsync -aq --delete $(echo "${binLIST[@]}") /home/$USER/.local/bin/
scriptFeedback success "Done"

exit 0

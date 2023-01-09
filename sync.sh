#!/bin/bash

# bash strict
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

binExt="./scripts"
dotExt="./configs/dotconfig"

dotLIST=(
    "$dotExt/dunst"
    "$dotExt/qtile"
    "$dotExt/rofi"
    "$dotExt/eww"
    "$dotExt/hypr"
    "$dotExt/waybar"
    "$dotExt/scripts"
    "$dotExt/kitty"
    "$dotExt/ncspot"
    "$dotExt/nano"
    "$dotExt/picom"
    "$dotExt/zathura"
    "$dotExt/mpv"
    "$dotExt/btop"
    "$dotExt/paru"
    "$dotExt/easyeffects"
    "$dotExt/starship.toml"
    "$dotExt/electron-flags.conf"
    "$dotExt/code-flags.conf"
    "$dotExt/Thunar"
    "$dotExt/pipewire"
    "$dotExt/wireplumber"
    "$dotExt/Code"
)

binLIST=(
    "$binExt/mntExt"
    "$binExt/mntSMB"
    "$binExt/sharePwnagotchy"
    "$binExt/rsyncToShare"
    "$binExt/clnJnk"
    "$binExt/setWall"
    "$binExt/setTheme"
    "$binExt/xtkotlinc"
)

scriptFeedback proc "Syncing combined configs"

/bin/rsync -aq \
--delete \
$(echo "${dotLIST[@]}") /home/$USER/.config/

/bin/rsync -aq \
--delete \
"$dotExt"/.bashrc "$dotExt"/.inputrc "$dotExt"/.wayinitrc \
/home/$USER/

scriptFeedback success "Done"

scriptFeedback proc "Syncing ~/.local/bin/ scripts"

/bin/rsync -aq \
--delete \
$(echo "${binLIST[@]}") /home/$USER/.local/bin/

scriptFeedback success "Done"

exit 0

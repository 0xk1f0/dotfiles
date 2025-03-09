#!/usr/bin/env bash

# bash strict
set -uo pipefail

# tweaked fzf chooser
fzf_choose() {
    local _CHOICE=$(echo -e "no\nyes" | fzf --prompt="${1}")
    if [ "${_CHOICE}" == "yes" ]; then
        return 0
    else
        return 1
    fi
}

# shortcuts
BASH_EXT="/home/${USER}/.local/bin"
SYSTEMD_EXT="/home/${USER}/.config/systemd/user/"
HOME_EXT="/home/${USER}"
HOME_DOTFILES_EXT="/home/${USER}/.config"
DOTFILES_EXT="./configs/dotconfig"

DOTFILES_LIST=(
    "${HOME_DOTFILES_EXT}/dunst"
    "${HOME_DOTFILES_EXT}/rofi"
    "${HOME_DOTFILES_EXT}/eww"
    "${HOME_DOTFILES_EXT}/hypr"
    "${HOME_DOTFILES_EXT}/scripts"
    "${HOME_DOTFILES_EXT}/kitty"
    "${HOME_DOTFILES_EXT}/ncspot"
    "${HOME_DOTFILES_EXT}/nano"
    "${HOME_DOTFILES_EXT}/helix"
    "${HOME_DOTFILES_EXT}/zed"
    "${HOME_DOTFILES_EXT}/zathura"
    "${HOME_DOTFILES_EXT}/mpv"
    "${HOME_DOTFILES_EXT}/paru"
    "${HOME_DOTFILES_EXT}/easyeffects"
    "${HOME_DOTFILES_EXT}/starship.toml"
    "${HOME_DOTFILES_EXT}/electron-flags.conf"
    "${HOME_DOTFILES_EXT}/code-flags.conf"
    "${HOME_DOTFILES_EXT}/pipewire"
    "${HOME_DOTFILES_EXT}/wireplumber"
    "${HOME_EXT}/.bashrc"
    "${HOME_EXT}/.inputrc"
    "${HOME_EXT}/.wayinitrc"
)

BASH_LIST=(
    "${BASH_EXT}/mntExt"
    "${BASH_EXT}/mntSMB"
    "${BASH_EXT}/clnJnk"
    "${BASH_EXT}/setWall"
    "${BASH_EXT}/setTheme"
    "${BASH_EXT}/symlinkElectron"
    "${BASH_EXT}/rmWineAssocs"
    "${BASH_EXT}/syncThemes"
    "${BASH_EXT}/spicetifyRefresh"
)

SYSTEMD_LIST=(
    "${SYSTEMD_EXT}/gamescope.service"
)

# dont run as root
if [ $EUID -eq 0 ]; then
    printf "[\e[1m\e[91m✗\e[0m]%s\n" " Run as user"
fi

if fzf_choose "Include dotconfigs?"; then
    printf "[\e[1m\e[93m⧗\e[0m]%s\n" " Syncing configs.."
    /bin/rsync -aq \
    --delete \
    --exclude '*.cbor' \
    --exclude 'cheatsheets' \
    --exclude 'bookmarks' \
    --exclude 'user.conf' \
    --exclude 'user.yuck' \
    --exclude 'user.scss' \
    --exclude 'user.rasi' \
    "${DOTFILES_LIST[@]}" "${DOTFILES_EXT}"/
fi

if fzf_choose "Include bash scripts?"; then
    printf "[\e[1m\e[93m⧗\e[0m]%s\n" " Syncing bash scripts.."
    /bin/rsync -aq \
    --delete \
    "${BASH_LIST[@]}" "./scripts/bash/"
fi

if fzf_choose "Include systemd user units?"; then
    printf "[\e[1m\e[93m⧗\e[0m]%s\n" " Syncing systemd units.."
    /bin/rsync -aq \
    --delete \
    "${SYSTEMD_LIST[@]}" "./scripts/systemd/"
fi

printf "[\e[1m\e[92m✓\e[0m]%s\n" " Done"
exit 0

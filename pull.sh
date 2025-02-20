#!/usr/bin/env bash

# bash strict
set -uo pipefail

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
    "${BASH_EXT}/sharePwnagotchy"
    "${BASH_EXT}/clnJnk"
    "${BASH_EXT}/setWall"
    "${BASH_EXT}/setTheme"
    "${BASH_EXT}/symlinkElectron"
    "${BASH_EXT}/rmWineAssocs"
    "${BASH_EXT}/syncThemes"
)

SYSTEMD_LIST=(
    "${SYSTEMD_EXT}/gamescope.service"
)

# give user feedback
p_echo() {
    case $1 in
        prompt)
            printf "[\e[1m\e[9%sm%s\e[0m]%s\n" "3" "?" " $2"
        ;;
        success)
            printf "[\e[1m\e[9%sm%s\e[0m]%s\n" "2" "✓" " $2"
        ;;
        proc)
            printf "[\e[1m\e[9%sm%s\e[0m]%s\n" "3" ".." " $2"
        ;;
        error)
            printf "[\e[1m\e[9%sm%s\e[0m]%s\n" "1" "✗" " $2"
            exit 1
        ;;
    esac
}

choice_menu() {
    CHOICE=$(echo -e "no\nyes" | fzf --prompt="${1}")
    if [ "${CHOICE}" == "yes" ]; then
        return 0
    else
        return 1
    fi
}

# dont run as root
if [ $EUID -eq 0 ]; then
    p_echo error "run as user!"
fi

# check if fzf is available
if ! command -v fzf >> /dev/null; then
    p_echo error "needs 'fzf' installed!"
fi

if choice_menu "Include dotconfigs?"; then
    p_echo proc "Syncing configs"
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
    p_echo success "Done"
fi

if choice_menu "Include bash scripts?"; then
    p_echo proc "Syncing bash scripts"
    /bin/rsync -aq \
    --delete \
    "${BASH_LIST[@]}" "./scripts/bash/"
    p_echo success "Done"
fi

if choice_menu "Include systemd user units?"; then
    p_echo proc "Syncing systemd units"
    /bin/rsync -aq \
    --delete \
    "${SYSTEMD_LIST[@]}" "./scripts/systemd/"
    p_echo success "Done"
fi

exit 0

#!/usr/bin/env bash

# bash strict
set -uo pipefail

# shortcuts
BASH_EXT="./scripts/bash"
SYSTEMD_EXT="./scripts/systemd"
DOTFILES_EXT="./configs/dotconfig"

DOTFILES_LIST=(
    "${DOTFILES_EXT}/dunst"
    "${DOTFILES_EXT}/rofi"
    "${DOTFILES_EXT}/eww"
    "${DOTFILES_EXT}/hypr"
    "${DOTFILES_EXT}/scripts"
    "${DOTFILES_EXT}/kitty"
    "${DOTFILES_EXT}/ncspot"
    "${DOTFILES_EXT}/nano"
    "${DOTFILES_EXT}/helix"
    "${DOTFILES_EXT}/zed"
    "${DOTFILES_EXT}/zathura"
    "${DOTFILES_EXT}/mpv"
    "${DOTFILES_EXT}/paru"
    "${DOTFILES_EXT}/easyeffects"
    "${DOTFILES_EXT}/starship.toml"
    "${DOTFILES_EXT}/electron-flags.conf"
    "${DOTFILES_EXT}/code-flags.conf"
    "${DOTFILES_EXT}/pipewire"
    "${DOTFILES_EXT}/wireplumber"
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

if choice_menu "Perform Sync?" && choice_menu "Are you sure?"; then
    p_echo proc "Syncing combined configs"
    /bin/rsync -aq \
    "${DOTFILES_LIST[@]}" "/home/${USER}/.config/"
    /bin/rsync -aq \
    "${DOTFILES_EXT}"/.bashrc "${DOTFILES_EXT}"/.inputrc \
    "${DOTFILES_EXT}"/.wayinitrc \
    "/home/${USER}/"
    p_echo proc "Syncing bash scripts"
    /bin/rsync -aq \
    "${BASH_LIST[@]}" "/home/${USER}/.local/bin/"
    p_echo proc "Syncing systemd units"
    /bin/rsync -aq \
    "${SYSTEMD_LIST[@]}" "/home/${USER}/.config/systemd/user/"
    p_echo success "Done"
else
    p_echo error "Aborted"
fi

exit 0

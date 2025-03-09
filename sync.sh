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

if fzf_choose "Perform Sync?" && fzf_choose "Are you sure?"; then
    printf "[\e[1m\e[93m⧗\e[0m]%s\n" " Syncing combined configs.."
    /bin/rsync -aq \
    "${DOTFILES_LIST[@]}" "/home/${USER}/.config/"
    /bin/rsync -aq \
    "${DOTFILES_EXT}"/.bashrc "${DOTFILES_EXT}"/.inputrc \
    "${DOTFILES_EXT}"/.wayinitrc \
    "/home/${USER}/"
    printf "[\e[1m\e[93m⧗\e[0m]%s\n" " Syncing bash scripts.."
    /bin/rsync -aq \
    "${BASH_LIST[@]}" "/home/${USER}/.local/bin/"
    printf "[\e[1m\e[93m⧗\e[0m]%s\n" " Syncing systemd units.."
    /bin/rsync -aq \
    "${SYSTEMD_LIST[@]}" "/home/${USER}/.config/systemd/user/"
else
    printf "[\e[1m\e[91m✗\e[0m]%s\n" " Aborted"
fi

printf "[\e[1m\e[92m✓\e[0m]%s\n" " Done"
exit 0

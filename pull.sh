#!/bin/bash

# bash strict
set -uo pipefail

# modified version of https://askubuntu.com/a/1386907
chooseMenu() {
    local prompt="$1" outvar="$2"
    shift
    shift
    local options=("$@") cur=0 count=${#options[@]} index=0
    local esc=$(echo -en "\e")
    scriptFeedback prompt "$prompt"
    while true
    do
        index=0
        for o in "${options[@]}"
        do
            if [ "$index" == "$cur" ]
            then echo -e "> \e[1m\e[92m$o\e[0m"
            else echo -e "  \e[90m$o\e[0m"
            fi
            index=$(( $index + 1 ))
        done
        read -s -n3 key
        if [[ $key == "$esc[A" ]]
        then cur=$(( $cur - 1 ))
            [ "$cur" -lt 0 ] && cur=0
        elif [[ $key == "$esc[B" ]]
        then cur=$(( $cur + 1 ))
            [ "$cur" -ge $count ] && cur=$(( $count - 1 ))
        elif [[ $key == "" ]]
        then break
        fi
        echo -en "\e[${count}A"
    done
    printf -v $outvar "${options[$cur]}"
}

# give user feedback
scriptFeedback() {
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
    esac
}

handleYesNo() {
    selections=(
        "no"
        "yes"
    )
    chooseMenu "$1" selected_choice "${selections[@]}"
    if [ "$selected_choice" == "yes" ]; then
        return 0
    else
        return 1
    fi
}

bashExt="/home/$USER/.local/bin"
sysdExt="/home/$USER/.config/systemd/user/"
homeCfgExt="/home/$USER/.config"
homeExt="/home/$USER"
dotExt="./configs/dotconfig"

dotLIST=(
    "$homeCfgExt/dunst"
    "$homeCfgExt/rofi"
    "$homeCfgExt/eww"
    "$homeCfgExt/hypr"
    "$homeCfgExt/scripts"
    "$homeCfgExt/kitty"
    "$homeCfgExt/alacritty"
    "$homeCfgExt/ncspot"
    "$homeCfgExt/nano"
    "$homeCfgExt/helix"
    "$homeCfgExt/zathura"
    "$homeCfgExt/mpv"
    "$homeCfgExt/cheat"
    "$homeCfgExt/paru"
    "$homeCfgExt/easyeffects"
    "$homeCfgExt/starship.toml"
    "$homeCfgExt/electron-flags.conf"
    "$homeCfgExt/code-flags.conf"
    "$homeCfgExt/pipewire"
    "$homeCfgExt/wireplumber"
    "$homeExt/.bashrc"
    "$homeExt/.inputrc"
    "$homeExt/.wayinitrc"
)

bashLIST=(
    "$bashExt/mntExt"
    "$bashExt/mntSMB"
    "$bashExt/sharePwnagotchy"
    "$bashExt/clnJnk"
    "$bashExt/setWall"
    "$bashExt/setTheme"
    "$bashExt/symlinkElectron"
    "$bashExt/rmWineAssocs"
    "$bashExt/syncThemes"
)

sysdLIST=(
    "$sysdExt/gamescope.service"
)

clear

if handleYesNo "Include dotconfigs?"; then
    scriptFeedback proc "Syncing configs"

    /bin/rsync -aq \
    --delete \
    --exclude '*.cbor' \
    --exclude 'cheatsheets' \
    --exclude 'bookmarks' \
    --exclude 'configrc' \
    --exclude 'eww.yuck' \
    --exclude 'eww.scss' \
    --exclude 'hyprland.conf' \
    --exclude 'config.rasi' \
    --exclude 'kitty-colors.conf' \
    --exclude 'alacritty-colors.toml' \
    $(echo "${dotLIST[@]}") "$dotExt"/

    scriptFeedback success "Done"
fi

if handleYesNo "Include bash scripts?"; then
    scriptFeedback proc "Syncing bash scripts"

    /bin/rsync -aq \
    --delete \
    $(echo "${bashLIST[@]}") ./scripts/bash/

    scriptFeedback success "Done"
fi

if handleYesNo "Include systemd user units?"; then
    scriptFeedback proc "Syncing systemd units"

    /bin/rsync -aq \
    --delete \
    $(echo "${sysdLIST[@]}") ./scripts/systemd/

    scriptFeedback success "Done"
fi

exit 0

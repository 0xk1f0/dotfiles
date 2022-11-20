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
        if [[ $key == $esc[A ]]
        then cur=$(( $cur - 1 ))
            [ "$cur" -lt 0 ] && cur=0
        elif [[ $key == $esc[B ]]
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

binExt="/home/$USER/.local/bin"
homeCfgExt="/home/$USER/.config"
homeExt="/home/$USER"

combinedLIST=(
    "$homeCfgExt/kitty"
    "$homeCfgExt/ncspot"
    "$homeCfgExt/nano"
    "$homeCfgExt/picom"
    "$homeCfgExt/zathura"
    "$homeCfgExt/mpv"
    "$homeCfgExt/btop"
    "$homeCfgExt/cheat"
    "$homeCfgExt/paru"
    "$homeCfgExt/easyeffects"
    "$homeExt/.bashrc"
    "$homeCfgExt/starship.toml"
    "$homeCfgExt/electron-flags.conf"
    "$homeCfgExt/code-flags.conf"
    "$homeCfgExt/Thunar"
    "$homeCfgExt/pipewire"
    "$homeCfgExt/wireplumber"
)

normalLIST=(
    "$homeCfgExt/dunst"
    "$homeCfgExt/qtile"
    "$homeCfgExt/rofi"
    "$homeCfgExt/eww"
    "$homeCfgExt/hypr"
    "$homeCfgExt/waybar"
    "$homeCfgExt/scripts"
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

selections=(
    "pc"
    "laptop"
)

clear
chooseMenu "What device are you on?" selected_choice "${selections[@]}"
platform="$selected_choice"

if handleYesNo "Include normal?"; then
    scriptFeedback proc "Syncing configs for $platform"
    /bin/rsync -aq \
    --delete \
    $(echo "${normalLIST[@]}") ./configs/$platform/
    scriptFeedback success "Done"
fi

if handleYesNo "Include combined?"; then
    scriptFeedback proc "Syncing combined configs"
    /bin/rsync -aq \
    --delete \
    --exclude '*.cbor' \
    --exclude 'cheatsheets' \
    $(echo "${combinedLIST[@]}") ./configs/combined/
    scriptFeedback success "Done"
fi

if handleYesNo "Include ~/.local/bin/ scripts?"; then
    scriptFeedback proc "Syncing ~/.local/bin/ scripts"
    /bin/rsync -aq \
    --delete \
    $(echo "${binLIST[@]}") ./scripts/
    scriptFeedback success "Done"
fi

exit 0

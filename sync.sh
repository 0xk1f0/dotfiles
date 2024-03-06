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

bashExt="./scripts/bash"
sysdExt="./scripts/systemd"
dotExt="./configs/dotconfig"

dotLIST=(
    "$dotExt/dunst"
    "$dotExt/rofi"
    "$dotExt/eww"
    "$dotExt/hypr"
    "$dotExt/scripts"
    "$dotExt/kitty"
    "$dotExt/ncspot"
    "$dotExt/nano"
    "$dotExt/helix"
    "$dotExt/zathura"
    "$dotExt/mpv"
    "$dotExt/paru"
    "$dotExt/cheat"
    "$dotExt/easyeffects"
    "$dotExt/starship.toml"
    "$dotExt/electron-flags.conf"
    "$dotExt/code-flags.conf"
    "$dotExt/pipewire"
    "$dotExt/wireplumber"
)

bashLIST=(
    "$bashExt/mntExt"
    "$bashExt/mntSMB"
    "$bashExt/sharePwnagotchy"
    "$bashExt/rsyncToShare"
    "$bashExt/clnJnk"
    "$bashExt/setWall"
    "$bashExt/setTheme"
    "$bashExt/xtkotlinc"
    "$bashExt/symlinkElectron"
    "$bashExt/rmWineAssocs"
)

sysdLIST=(
    "$sysdExt/gamescope.service"
)

if handleYesNo "Perform Sync?"; then
    scriptFeedback proc "Syncing combined configs"

    /bin/rsync -aq \
    $(echo "${dotLIST[@]}") /home/$USER/.config/

    /bin/rsync -aq \
    "$dotExt"/.bashrc "$dotExt"/.inputrc \
    "$dotExt"/.wayinitrc \
    /home/$USER/

    scriptFeedback success "Done"

    scriptFeedback proc "Syncing bash scripts"

    /bin/rsync -aq \
    $(echo "${bashLIST[@]}") /home/$USER/.local/bin/

    scriptFeedback proc "Syncing systemd units"

    /bin/rsync -aq \
    $(echo "${sysdLIST[@]}") /home/$USER/.config/systemd/user/

    scriptFeedback success "Done"
fi

exit 0

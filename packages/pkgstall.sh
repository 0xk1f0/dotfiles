#!/usr/bin/env bash

# "bash strict mode"
set -uo pipefail

# detect su system
if command -v /bin/sudo >> /dev/null; then
    SU_SYS="/bin/sudo"
else
    SU_SYS="/bin/doas"
fi

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
            if [ "$index" == "$cur" ]; then
                echo -e "> \e[1m\e[92m$o\e[0m\e[3m\e[0m"
            else
                echo -e "  \e[90m$o\e[3m\e[0m"
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
        error)
            printf "[\e[1m\e[9%sm%s\e[0m]%s\n" "1" "✗" " $2"
            exit 1
            ;;
        success)
            printf "[\e[1m\e[9%sm%s\e[0m]%s\n" "2" "✓" " $2" 
            ;;
        proc)
            printf "[\e[1m\e[9%sm%s\e[0m]%s\n" "3" ":" " $2"
            ;;
    esac
}

# check for paru
if ! command -v /bin/paru >> /dev/null; then
    scriptFeedback proc "WARNING: paru not found, options limited!"
    INSTALL_SELECT=(
        "INITIAL"
        "PARU"
    )
else
    INSTALL_SELECT=(
        "INITIAL"
        "BASE"
        "EXTRA"
    )
fi

# check if config files exist read, else exit
if [ -e "./packages.conf" ]; then
    scriptFeedback success "Config file found!"
    . packages.conf
else
    scriptFeedback error "No Config file found!"
fi

# start here
chooseMenu "What to install?" selected_choice ${INSTALL_SELECT[@]}

case $selected_choice in
    "INITAL")
        scriptFeedback proc "Installing Initial Packages (pacman)"
        pacman -S --needed ${FUNC_VIDEO[@]} ${FUNC_AUDIO[@]} ${FUNC_DRIVERS[@]} ${FUNC_MISC[@]}
        ;;
    "BASE")
        FV_LIST=("X11" "WAYLAND")
        chooseMenu "X11 or Wayland?" selected_choice ${FV_LIST[@]}
        case $selected_choice in
            "X11")
                scriptFeedback proc "Installing DE ($selected_choice)"
                $SU_SYS pacman -S --needed ${DE_X[@]}
                paru -S --needed ${DE_X_AUR[@]}
                ;;
            "WAYLAND")
                scriptFeedback proc "Installing DE ($selected_choice)"
                $SU_SYS pacman -S --needed ${DE_WAY[@]}
                paru -S --needed ${DE_WAY_AUR[@]}
                ;;
        esac
        scriptFeedback proc "Installing Base Packages (pacman)"
        $SU_SYS pacman -S --needed ${BSC_DE[@]} ${BSC_FONTSTHEMES[@]} ${BSC_MISC[@]}
        scriptFeedback proc "Installing Base Packages (paru)"
        paru -S --needed ${BSC_DE_AUR[@]} ${BSC_FONTSTHEMES_AUR[@]} ${BSC_MISC_AUR[@]}
        ;;
    "EXTRA")
        scriptFeedback proc "Installing Extra Packages (pacman)"
        $SU_SYS pacman -S --needed ${EXT_DE[@]} ${EXT_MISC[@]}
        scriptFeedback proc "Installing Extra Packages (paru)"
        paru -S --needed ${EXT_DE_AUR[@]} ${EXT_MISC_AUR[@]}
        ;;
    "VIRT")
        scriptFeedback proc "Installing Virtualization Packages (pacman)"
        $SU_SYS pacman -S --needed ${EXT_VIRT[@]}
        ;;
    "PARU")
        git clone https://aur.archlinux.org/paru-bin
        cd paru-bin/
        makepkg -si
        # edit config if we use doas
        if [ $SU_SYS == "/bin/doas" ]; then
            mkdir -p /home/$USER/.config/paru
            echo -e "[options]\nSkipReview\n\n[bin]\nSudo = /bin/doas" > /home/$USER/.config/paru/paru.conf
        fi
        ;;
esac

scriptFeedback success "Done!"
exit 0

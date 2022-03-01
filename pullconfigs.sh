#!/bin/bash

# i yoinked this from here
# https://askubuntu.com/a/1386907
# and modified it slightly
choose_from_menu() {
    local prompt="$1" outvar="$2"
    shift
    shift
    local options=("$@") cur=0 count=${#options[@]} index=0
    local esc=$(echo -en "\e")
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "2" ":: " "$prompt"
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

exiting() {
    clear
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "1" ":: " "Exiting..."
    exit 0
}

deleteConfigs() {
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "1" ":: " "Deleting old configs for $2"
    sleep 1
    rm -rf  $1/dunst/
    rm -rf  $1p/herbstluftwm/
    rm -rf  $1/qtile/
    rm -rf  $1/polybar/
    rm -rf  $1/rofi/
    rm -rf  $1/leftwm/
    rm -rf  $1/scripts/
}

copyConfigs() {
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "3" ":: " "Pulling new configs for $2"
    sleep 1
    cp -r   ~/.config/herbstluftwm 	    $1/
    cp -r   ~/.config/qtile		        $1/
    cp -r   ~/.config/dunst 		    $1/
    cp -r   ~/.config/polybar 		    $1/
    cp -r   ~/.config/rofi 		        $1/
    cp -r   ~/.config/leftwm            $1/
    cp -r   ~/.config/scripts           $1/
}

delConfigsCombined() {
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "1" ":: " "Deleting old combined configs"
    sleep 1
    rm -rf  combined/kitty/
    rm -rf  combined/pacwall/
    rm -f   combined/.bashrc
    rm -rf  combined/nano/
    rm -rf  combined/picom/
    rm -f   combined/ncspot/config.toml
    rm -rf  combined/zathura/
}

copyConfigsCombined() {
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "3" ":: " "Pulling new combined configs"
    sleep 1
    cp -r   ~/.config/kitty                     combined/
    cp -r   ~/.config/pacwall                   combined/
    cp -r   ~/.bashrc                           combined/
    cp -r   ~/.config/nano                      combined/
    cp -r   ~/.config/picom                     combined/
    cp -r   ~/.config/ncspot/config.toml        combined/ncspot/config.toml
    cp -r   ~/.config/zathura/		            combined/
}

delScripts() {
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "1" ":: " "Deleting old ~/.local/bin/ scripts"
    sleep 1
    rm -f other/bin/gitMergeRebase
    rm -f other/bin/mntExt
    rm -f other/bin/sharePwnagotchy
}

copyScripts() {
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "3" ":: " "Pulling new ~/.local/bin/ scripts"
    sleep 1
    cp  ~/.local/bin/gitMergeRebase         other/bin/
    cp  ~/.local/bin/mntExt                 other/bin/
    cp  ~/.local/bin/sharePwnagotchy        other/bin/
}

handleCombined() {
    selections=(
        "no"
        "yes"
    )
    choose_from_menu "Include combined?" selected_choice "${selections[@]}"
    if [ "$selected_choice" == "yes" ]; then
        answerCombined="y"
    else
        answerCombined="n"
    fi
}

handleScripts() {
    selections=(
        "no"
        "yes"
    )
    choose_from_menu "Include ~/.local/bin/ scripts?" selected_choice "${selections[@]}"
    if [ "$selected_choice" == "yes" ]; then
        answerScripts="y"
    else
        answerScripts="n"
    fi
}

confirmActions() {
    selections=(
        "no"
        "yes"
    )
    choose_from_menu "Are all options correct?" selected_choice "${selections[@]}"
    if [ "$selected_choice" == "yes" ]; then
        clear
        printf "\e[3m\e[1m%s\e[0m\n" "pullconfigs.sh"
    else
        exiting
    fi
}

clear
selections=(
    "PC"
    "Laptop"
)
choose_from_menu "What device are you on?" selected_choice "${selections[@]}"

if [ "$selected_choice" == "Laptop" ]; then 
    platform="Laptop"
    handleCombined
    handleScripts
    confirmActions
    deleteConfigs "laptop" $platform

    if [ "$answerCombined" == 'y' ]; then
        delConfigsCombined
    fi

    if [ "$answerScripts" == 'y' ]; then
        delScripts
    fi

    copyConfigs "laptop" $platform

    if [ "$answerCombined" == 'y' ]; then
        copyConfigsCombined
    fi

    if [ "$answerScripts" == 'y' ]; then
        copyScripts
    fi
elif [ "$selected_choice" == "PC" ]; then
    platform="PC"
    handleCombined
    handleScripts
    confirmActions
    deleteConfigs "pc" $platform

    if [ "$answerCombined" == 'y' ]; then
        delConfigsCombined
    fi

    if [ "$answerScripts" == 'y' ]; then
        delScripts
    fi

    copyConfigs "pc" $platform

    if [ "$answerCombined" == 'y' ]; then
        copyConfigsCombined
    fi

    if [ "$answerScripts" == 'y' ]; then
        copyScripts
    fi
else
    exiting
fi

exiting

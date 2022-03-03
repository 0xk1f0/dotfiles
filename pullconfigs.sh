#!/bin/bash

# "bash strict mode"
set -uo pipefail

# modified version of https://askubuntu.com/a/1386907
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
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "1" ":: " "Exiting..."
    exit 0
}


## TODO: redo using rsync, more efficient ##


deleteConfigs() {
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "1" ":: " "Deleting old configs for $1"
    sleep 1
    for i in ${normalList[@]}; do
        rm -rf $1/$i
    done
}

copyConfigs() {
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "3" ":: " "Pulling new configs for $1"
    sleep 1
    for i in ${normalList[@]}; do
        cp -r ~/.config/$i    $1/
    done
}

delConfigsCombined() {
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "1" ":: " "Deleting old combined configs"
    sleep 1
    for i in ${combinedList[@]}; do
        rm -rf combined/$i
    done
    rm -f combined/ncspot/config.toml
    rm -f combined/.bashrc
}

copyConfigsCombined() {
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "3" ":: " "Pulling new combined configs"
    sleep 1
    for i in ${combinedList[@]}; do
        cp -r  ~/.config/$i    combined/
    done
    cp ~/.config/ncspot/config.toml     combined/ncspot/
    cp ~/.bashrc                        combined/.bashrc
}

delScripts() {
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "1" ":: " "Deleting old ~/.local/bin/ scripts"
    sleep 1
    for i in ${binList[@]}; do
        rm -f other/bin/$i
    done
}

copyScripts() {
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "3" ":: " "Pulling new ~/.local/bin/ scripts"
    sleep 1
    for i in ${binList[@]}; do
        cp -r ~/.local/bin/$i    other/bin/
    done
}


## ... ##


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

combinedList=(
    "kitty/"
    "pacwall/"
    "nano/"
    "picom/"
    "zathura/"
)

normalList=(
    "dunst/"
    "herbstluftwm/"
    "qtile/"
    "polybar/"
    "rofi/"
    "leftwm/"
    "scripts/"
)

binList=(
    "mntExt"
    "sharePwnagotchy"
)

selections=(
    "pc"
    "laptop"
)

clear
choose_from_menu "What device are you on?" selected_choice "${selections[@]}"

platform="$selected_choice"
handleCombined
handleScripts
confirmActions

deleteConfigs $platform
copyConfigs $platform

if [ "$answerCombined" == 'y' ]; then
    delConfigsCombined
    copyConfigsCombined
fi

if [ "$answerScripts" == 'y' ]; then
    delScripts
    copyScripts
fi

exiting

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

combinedList=(
    "kitty/"
    "pacwall/"
    "nano/"
    "picom/"
    "zathura/"
)

binList=(
    "mntExt"
    "sharePwnagotchy"
)

selections=(
    "no"
    "yes"
)

clear
choose_from_menu "Proceed?" selected_choice "${selections[@]}"

if [ "$selected_choice" == "yes" ]; then
    clear
    printf "\e[3m\e[1m%s\e[0m\n" "sync.sh"
else
    exiting
fi


## TODO: redo using rsync, more efficient ##


printf "\e[1m\e[9%sm%s\e[0m%s\n" "1" ":: " "Deleting old combined configs"
sleep 1
for i in ${combinedList[@]}; do
    rm -rf ~/.config/$i
done
rm -f ~/.bashrc
rm -f ~/.config/ncspot/config.toml

printf "\e[1m\e[9%sm%s\e[0m%s\n" "3" ":: " "Copying new combined configs"
sleep 1
for i in ${combinedList[@]}; do
    cp -r combined/$i    ~/.config/
done
cp -r combined/ncspot/config.toml       ~/.config/ncspot/
cp -r combined/.bashrc            	    ~/

printf "\e[1m\e[9%sm%s\e[0m%s\n" "1" ":: " "Deleting old ~/.local/bin/ scripts"
sleep 1
for i in ${binList[@]}; do
    rm -f ~/.local/bin/$i
done

printf "\e[1m\e[9%sm%s\e[0m%s\n" "3" ":: " "Copying ~/.local/bin/ scripts"
sleep 1
for i in ${binList[@]}; do
    cp -r other/bin/$i    ~/.local/bin/
done


## ... ##


exiting

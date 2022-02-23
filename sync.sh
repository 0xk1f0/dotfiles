#!/bin/bash

##############################################################################
### I take NO responsibility for any deleted configs or destroyed systems! ###
##############################################################################

# i yoinked this from here
# https://askubuntu.com/a/1386907
# and modified it slightly
choose_from_menu() {
    local prompt="$1" outvar="$2"
    shift
    shift
    local options=("$@") cur=0 count=${#options[@]} index=0
    local esc=$(echo -en "\e")
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "2" "::" "$prompt"
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
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "1" "::" "Exiting..."
    exit 0
}

selections=(
    "no"
    "yes"
)
choose_from_menu "Proceed?" selected_choice "${selections[@]}"

if [ "$selected_choice" == "yes" ]; then
    clear
    printf "\e[3m\e[1m%s\e[0m\n" "sync.sh"
else
    exiting
fi

printf "\e[1m\e[9%sm%s\e[0m%s\n" "1" "::" "Deleting old combined configs"
sleep 1

rm -rf  ~/.config/kitty/
rm -f   ~/.bashrc
rm -rf  ~/.config/nano/
rm -rf  ~/.config/picom/
rm -f   ~/.config/ncspot/config.toml
rm -rf  ~/.config/zathura/

printf "\e[1m\e[9%sm%s\e[0m%s\n" "3" "::" "Copying new combined configs"
sleep 1

cp -r   combined/kitty/                 ~/.config/
cp -r   combined/nano/                  ~/.config/
cp -r   combined/picom/                 ~/.config/
cp -r   combined/ncspot/config.toml     ~/.config/ncspot/
cp -r   combined/.bashrc            	~/
cp -r   combined/zathura/		        ~/.config/

exiting

#!/usr/bin/env bash

#This is a script to pull all dotfiles to this repo

#functions

timeout () {
    echo $1
    sleep 1
    echo "3..."
    sleep 1
    echo "2..."
    sleep 1
    echo "1..."
    sleep 1
}

success () {
    echo "Done!"
    sleep 2
    clear
}

#clear terminal window
clear

#Ask for confirmation to run
echo "This script will pull the newest configs from the .config/ directory"
echo "This script is to be used by the maintainer of this dotfile repo!"
sleep 2
read -p "Proceed? (y|n) " answer

if [ $answer = 'y' ]; then
    clear
elif [ $answer = 'n' ]; then
    clear
    echo "Exiting..."
    exit
elif [ $answer = ]; then
    clear
    echo "No answer was given, exiting..."
    exit
else 
    clear
    echo "Unsure, Exiting..."
    exit
fi

read -p "Are you on a Laptop? (y|n) " answer2

if [ $answer2 = 'y' ]; then
    echo "On Laptop"
    sleep 2
    timeout "Deleting old configs in..."

    #device specific configs
    rm -rf laptop/dunst/
    rm -rf laptop/herbstluftwm/
    rm -rf laptop/polybar/

    #combined configs
    rm -rf combined/kitty/
    rm -rf combined/pacwall/
    rm -rf combined/bash/bashrc
    rm -rf combined/nano/
    rm -rf combined/picom/

    success
    
    timeout "Pulling new configs in..."

    #device specific configs
    cp -r ~/.config/herbstluftwm laptop/
    cp -r ~/.config/dunst laptop/
    cp -r ~/.config/polybar laptop/

    #combined configs
    cp -r ~/.config/kitty combined/
    cp -r ~/.config/pacwall combined/
    cp -r ~/.bashrc combined/bash/
    cp -r ~/.config/nano combined/
    cp -r ~/.config/picom combined/
    mv combined/bash/.bashrc combined/bash/bashrc 

    success

elif [ $answer2 = 'n' ]; then
    echo "On PC"
    sleep 2
    timeout "Deleting old configs in..."

    #device specific configs
    rm -rf pc/dunst/
    rm -rf pc/herbstluftwm/
    rm -rf pc/polybar/

    #combined configs
    rm -rf combined/kitty/
    rm -rf combined/pacwall/
    rm -rf combined/bash/bashrc
    rm -rf combined/nano/
    rm -rf combined/picom/

    success

    timeout "Pulling new configs in..."

    #device specific configs
    cp -r ~/.config/herbstluftwm pc/
    cp -r ~/.config/dunst pc/
    cp -r ~/.config/polybar pc/

    #combined configs
    cp -r ~/.config/kitty combined/
    cp -r ~/.config/pacwall combined/
    cp -r ~/.bashrc combined/bash/
    cp -r ~/.config/nano combined/
    cp -r ~/.config/picom combined/
    mv combined/bash/.bashrc combined/bash/bashrc 

    success

elif [ $answer2 = ]; then
    clear
    echo "No answer was given, exiting..."
    exit
else
    clear
    echo "Unsure, Exiting..."
    exit
fi

#exit
echo "Exiting..."
exit
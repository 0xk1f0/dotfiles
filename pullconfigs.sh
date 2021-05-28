#!/usr/bin/bash

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

    #delete all configs first
    rm -rf laptop/dunst/
    rm -rf laptop/herbstluftwm/
    rm -rf laptop/kitty/
    rm -rf laptop/pacwall/
    rm -rf laptop/polybar/
    rm -rf laptop/bash/bashrc
    rm -rf laptop/nano/
    rm -rf laptop/picom/

    success
    timeout "Pulling new configs in..."

    #copying / renaming
    cp -r ~/.config/herbstluftwm laptop/
    cp -r ~/.config/dunst laptop/
    cp -r ~/.config/polybar laptop/
    cp -r ~/.config/kitty laptop/
    cp -r ~/.config/pacwall laptop/
    cp -r ~/.bashrc laptop/bash/
    cp -r ~/.config/nano laptop/
    cp -r ~/.config/picom laptop/
    mv laptop/bash/.bashrc laptop/bash/bashrc 

    success
elif [ $answer2 = 'n' ]; then
    echo "On PC"
    sleep 2
    timeout "Deleting old configs in..."

    #delete all configs first
    rm -rf pc/dunst/
    rm -rf pc/herbstluftwm/
    rm -rf pc/kitty/
    rm -rf pc/pacwall/
    rm -rf pc/polybar/
    rm -rf pc/bash/bashrc
    rm -rf pc/nano/
    rm -rf pc/picom/

    success
    timeout "Pulling new configs in..."

    #copying / renaming
    cp -r ~/.config/herbstluftwm pc/
    cp -r ~/.config/dunst pc/
    cp -r ~/.config/polybar pc/
    cp -r ~/.config/kitty pc/
    cp -r ~/.config/pacwall pc/
    cp -r ~/.bashrc pc/bash/
    cp -r ~/.config/nano pc/
    cp -r ~/.config/picom pc/
    mv bash/.bashrc pc/bash/bashrc 

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
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
echo -e 'This script will pull the newest configs from the .config/ directory.
This script is to be used by the maintainer of this dotfile repo!\n'
sleep 2
read -p "Proceed? (y|n) " answerProceed

if [ $answerProceed = 'y' ]; then
    clear
elif [ $answerProceed = 'n' ]; then
    clear
    echo "Exiting..."
    exit
else 
    clear
    echo "Unsure, Exiting..."
    exit
fi

read -p "Are you on a Laptop? (y|n) " answerLaptop

if [ $answerLaptop = 'y' ]; then
    clear
    echo "On Laptop"
    sleep 2
    clear

    read -p "Would you like to pull combined too? (y|n) " answerCombined
    clear
    if [ $answerCombined = 'y' ]; then
    echo "Including combined in pull"
    else
    echo "NOT including combined in pull"
    fi
    sleep 2
    clear

    timeout "Deleting old configs in..."

    #device specific configs
    rm -rf  laptop/dunst/
    rm -rf  laptop/herbstluftwm/
    rm -rf  laptop/polybar/

    if [ $answerCombined = 'y' ]; then
    #combined configs
    rm -rf  combined/kitty/
    rm -rf  combined/pacwall/
    rm -rf  combined/bash/bashrc
    rm -rf  combined/nano/
    rm -rf  combined/picom/
    rm -f   combined/ncspot/config.toml
    fi

    success

    timeout "Pulling new configs in..."

    #device specific configs
    cp -r   ~/.config/herbstluftwm laptop/
    cp -r   ~/.config/dunst laptop/
    cp -r   ~/.config/polybar laptop/

    if [ $answerCombined = 'y' ]; then
    #combined configs
    cp -r   ~/.config/kitty                     combined/
    cp -r   ~/.config/pacwall                   combined/
    cp -r   ~/.bashrc                           combined/bash/
    cp -r   ~/.config/nano                      combined/
    cp -r   ~/.config/picom                     combined/
    cp -r   ~/.config/ncspot/config.toml        combined/ncspot/config.toml
    mv      combined/bash/.bashrc               combined/bash/bashrc 
    fi

    success

elif [ $answerLaptop = 'n' ]; then
    clear
    echo "On PC"
    sleep 2
    clear

    read -p "Would you like to pull combined too? (y|n) " answerCombined
    clear
    if [ $answerCombined = 'y' ]; then
    echo "Including combined in pull"
    else
    echo "NOT including combined in pull"
    fi
    sleep 2
    clear

    timeout "Deleting old configs in..."

    #device specific configs
    rm -rf pc/dunst/
    rm -rf pc/herbstluftwm/
    rm -rf pc/polybar/

    if [ $answerCombined = 'y' ]; then
    #combined configs
    rm -rf  combined/kitty/
    rm -rf  combined/pacwall/
    rm -rf  combined/bash/bashrc
    rm -rf  combined/nano/
    rm -rf  combined/picom/
    rm -f   combined/ncspot/config.toml
    fi

    success

    timeout "Pulling new configs in..."

    #device specific configs
    cp -r   ~/.config/herbstluftwm pc/
    cp -r   ~/.config/dunst pc/
    cp -r   ~/.config/polybar pc/

    if [ $answerCombined = 'y' ]; then
    #combined configs
    cp -r   ~/.config/kitty                     combined/
    cp -r   ~/.config/pacwall                   combined/
    cp -r   ~/.bashrc                           combined/bash/
    cp -r   ~/.config/nano                      combined/
    cp -r   ~/.config/picom                     combined/
    cp -r   ~/.config/ncspot/config.toml        combined/ncspot/config.toml
    mv      combined/bash/.bashrc               combined/bash/bashrc 
    fi

    success

else
    clear
    echo "Unsure, Exiting..."
    exit
fi

#exit
echo "Exiting..."
exit

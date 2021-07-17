#!/usr/bin/env bash

#This is a script to pull all dotfiles to this repo

##############################################################################
### I take NO responsibility for any deleted configs or destroyed systems! ###
##############################################################################

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
    sleep 1
    clear
}

clear

echo -e 'This script will pull the newest configs from the .config/ directory.'
sleep 1
read -p "Proceed? (Y|n) " answerProceed

if [ $answerProceed == 'y' ] || [ -z $answerProceed ]; then
    clear
elif [ $answerProceed == 'n' ]; then
    clear
    echo "Exiting..."
    exit 0
else
    clear
    echo "Unsure, Exiting..."
    exit 0
fi

read -p "Are you on a Laptop? (y|N) " answerLaptop

if [ $answerLaptop == 'y' ]; then
    clear
    echo "On Laptop"
    sleep 1
    clear

    read -p "Would you like to pull combined too? (y|N) " answerCombined
    clear

    if [ "$answerCombined" == 'y' ]; then
        echo "Including combined in pull"
    else
        echo "NOT including combined in pull"
    fi

    sleep 1
    clear

    timeout "Deleting old configs in..."

    rm -rf  laptop/dunst/
    rm -rf  laptop/herbstluftwm/
    rm -rf  laptop/polybar/

    if [ "$answerCombined" == 'y' ]; then
        rm -rf  combined/kitty/
        rm -rf  combined/pacwall/
        rm -f   combined/.bashrc
        rm -rf  combined/nano/
        rm -rf  combined/picom/
        rm -rf  combined/rofi/
        rm -f   combined/ncspot/config.toml
    fi

    success

    timeout "Pulling new configs in..."

    cp -r   ~/.config/herbstluftwm laptop/
    cp -r   ~/.config/dunst laptop/
    cp -r   ~/.config/polybar laptop/

    if [ "$answerCombined" == 'y' ]; then
        cp -r   ~/.config/kitty                     combined/
        cp -r   ~/.config/pacwall                   combined/
        cp -r   ~/.bashrc                           combined/
        cp -r   ~/.config/nano                      combined/
        cp -r   ~/.config/picom                     combined/
        cp -r   ~/.config/rofi                      combined/
        cp -r   ~/.config/ncspot/config.toml        combined/ncspot/config.toml
    fi

    success
elif [ $answerLaptop == 'n' ] || [ -z $answerLaptop ]; then
    clear
    echo "On PC"
    sleep 1
    clear

    read -p "Would you like to pull combined too? (y|N) " answerCombined
    clear

    if [ "$answerCombined" == 'y' ]; then
        echo "Including combined in pull"
    else
        echo "NOT including combined in pull"
    fi

    sleep 1
    clear

    timeout "Deleting old configs in..."

    rm -rf pc/dunst/
    rm -rf pc/herbstluftwm/
    rm -rf pc/polybar/

    if [ "$answerCombined" == 'y' ]; then
        rm -rf  combined/kitty/
        rm -rf  combined/pacwall/
        rm -r   combined/.bashrc
        rm -rf  combined/nano/
        rm -rf  combined/picom/
        rm -rf  combined/rofi/
        rm -f   combined/ncspot/config.toml
    fi

    success

    timeout "Pulling new configs in..."

    cp -r   ~/.config/herbstluftwm pc/
    cp -r   ~/.config/dunst pc/
    cp -r   ~/.config/polybar pc/

    if [ "$answerCombined" == 'y' ]; then
        cp -r   ~/.config/kitty                     combined/
        cp -r   ~/.config/pacwall                   combined/
        cp -r   ~/.bashrc                           combined/
        cp -r   ~/.config/nano                      combined/
        cp -r   ~/.config/picom                     combined/
        cp -r   ~/.config/rofi                      combined/
        cp -r   ~/.config/ncspot/config.toml        combined/ncspot/config.toml
    fi

    success
else
    clear
    echo "Unsure, Exiting..."
    exit 0
fi

echo "Exiting..."
exit 0

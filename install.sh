#!/usr/bin/env bash

#This is a script to install my dotfiles

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

#WARNINGS
echo "This script will install k1f0's dotfiles to your .config/ directory"
echo ""
echo "#############"
echo "# !WARNING! #"
echo "#############"
echo ""
sleep 1
echo "1. Always examine a bash script before you execute it to understand what it does!"
echo ""
echo "2. This script deletes, moves and copies files in the process!"
echo ""
echo "##############################################################################"
echo "### I take NO responsibility for any deleted configs or destroyed systems! ###"
echo "##############################################################################"
echo ""
echo "YOU HAVE BEEN WARNED!"
echo ""
sleep 1

#ask for confirmation to run
read -p "Do you want to proceed? (y|n) " answer1
clear
read -p "Are you on a Laptop? (y|n) " answer3

if [ $answer1 = 'y' ]; then
    if [ $answer3 = 'y' ]; then
        echo "On Laptop"
        sleep 1
    else
        echo "On PC"
        sleep 1
    fi
    clear
    read -p "Do you want to back up your present configs? (y|n) " answer2
elif [ $answer1 = 'n' ]; then
    clear
    echo "Exiting..."
    exit
elif [ $answer1 = ]; then
    clear
    echo "No answer was given, exiting..."
    exit
else 
    clear
    echo "Unsure, Exiting..."
    exit
fi

#ask for backup
if [ $answer2 = 'y' ]; then
    clear
    timeout "Backing up present configs to .old in..."

    #backup configs if present
    mv ~/.config/herbstluftwm ~/.config/herbstluftwm.old
    mv ~/.config/dunst ~/.config/dunst.old
    mv ~/.config/polybar ~/.config/polybar.old
    mv ~/.config/kitty ~/.config/kitty.old
    mv ~/.config/pacwall ~/.config/pacwall.old
    mv ~/.bashrc ~/.bashrc.old
    mv ~/.config/nano ~/.config/nano.old
    mv ~/.config/picom ~/.config/picom.old

    success
elif [ $answer2 = 'n' ]; then
    clear
    echo ""
    echo "#############"
    echo "# !WARNING! #"
    echo "#############"
    echo ""
    echo "NO BACKUP OF YOUR OLD CONFIGS WILL BE CREATED!"
    echo ""
    sleep 2

    timeout "Deleting old configs (if present) in..."

    #delete old configs
    rm -rf ~/.config/herbstluftwm/
    rm -rf ~/.config/dunst/
    rm -rf ~/.config/polybar/
    rm -rf ~/.config/kitty/
    rm -rf ~/.config/pacwall/
    rm -f ~/.bashrc
    rm -rf ~/.config/nano/
    rm -rf ~/.config/picom/

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

if [ $answer3 = 'y' ]; then
    timeout "Copying new configs in..."
    #device specific
    cp -r laptop/herbstluftwm/ ~/.config/
    cp -r laptop/dunst/ ~/.config/
    cp -r laptop/polybar/ ~/.config/
elif [ $answer3 = 'n' ]; then
    timeout "Copying new configs in..."
    #device specific
    cp -r pc/herbstluftwm/ ~/.config/
    cp -r pc/dunst/ ~/.config/
    cp -r pc/polybar/ ~/.config/
else
    clear
    echo "Device not specified!"
    sleep 2
    echo "Exiting..."
    exit
fi

#combined configs
cp -r combined/kitty/ ~/.config/
cp -r combined/pacwall/ ~/.config/
cp -r combined/nano/ ~/.config/
cp -r combined/picom/ ~/.config/
cp -r combined/bash/bashrc ~/
mv ~/bashrc ~/.bashrc

success

echo "Enjoy your new configs!"
sleep 2
echo "Exiting..."
exit
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

timeout "Deleting old configs in..."

#delete all configs first
rm -rf dunst/
rm -rf herbstluftwm/
rm -rf kitty/
rm -rf pacwall/
rm -rf polybar/
rm -rf bash/bashrc
rm -rf nano/

success
timeout "Pulling new configs in..."

#copying / renaming
cp -r ~/.config/herbstluftwm .
cp -r ~/.config/dunst .
cp -r ~/.config/polybar .
cp -r ~/.config/kitty .
cp -r ~/.config/pacwall .
cp -r ~/.bashrc bash/
cp -r ~/.config/nano .
mv bash/.bashrc bash/bashrc 

success

#exit
echo "Exiting..."
exit
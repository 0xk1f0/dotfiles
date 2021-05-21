#!/usr/bin/bash

#This is a script to pull all dotfiles to this repo

#clear terminal window
clear

#Ask for confirmation to run
echo "This script will pull the newest configs from the .config/ directory"
echo "This script is to be used by the maintainer of this dotfile repo!"
sleep 2
read -p "Proceed? (y|n) " answer

if [ $answer = 'y' ]; then
    clear
    echo "Deleting old configs in..."
elif [ $answer = 'Y' ]; then
    clear
    echo "Deleting old configs in..."
elif [ $answer = 'n' ]; then
    clear
    echo "Exiting..."
    exit
elif [ $answer = 'N' ]; then
    clear
    echo "Exiting..."
    exit
elif [ $answer = ]; then
    clear
    echo "No answer was given, exiting..."
    exit
else 
    clear
    echo "Exiting..."
    exit
fi

echo "3..."
sleep 1
echo "2..."
sleep 1
echo "1..."
sleep 1

#delete all configs first
rm -rf dunst/
rm -rf herbstluftwm/
rm -rf kitty/
rm -rf pacwall/
rm -rf polybar/
rm -rf bash/bashrc
rm -rf nano/

echo "Done!"
sleep 2
clear

#pull new configs
echo "Pulling new configs in..."

echo "3..."
sleep 1
echo "2..."
sleep 1
echo "1..."
sleep 1

#copying
cp -r ~/.config/herbstluftwm .
cp -r ~/.config/dunst .
cp -r ~/.config/polybar .
cp -r ~/.config/kitty .
cp -r ~/.config/pacwall .
cp -r ~/.bashrc bash/
cp -r ~/.config/nano .

#renaming if necessary
mv bash/.bashrc bash/bashrc 

echo "Done!"
sleep 2

#exit
clear
echo "Exiting..."
exit


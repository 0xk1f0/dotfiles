#!/usr/bin/env bash

#This is a script to install my dotfiles

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

echo -e 'This script will install dotfiles from combined/'
sleep 1
read -p "Proceed? (Y|n) " answerProceed
clear

if [ $answerProceed = 'y' ] || [ -z $answerProceed ]; then
    echo "combined excluded"; then
    clear
elif [ $answerProceed = 'n' ]; then
    clear
    echo "Exiting..."
    exit 0
else 
    clear
    echo "Unsure, Exiting..."
    exit 0
fi

timeout "Deleting old configs (if present) in..."

rm -rf  ~/.config/kitty/
rm -rf  ~/.config/pacwall/
rm -f   ~/.bashrc
rm -rf  ~/.config/nano/
rm -rf  ~/.config/picom/
rm -rf  ~/.config/rofi/
rm -f   ~/.config/ncspot/config.toml

success

timeout "Copying new configs in..."

#copy new configs
cp -r   combined/kitty/                 ~/.config/
cp -r   combined/pacwall/               ~/.config/
cp -r   combined/nano/                  ~/.config/
cp -r   combined/picom/                 ~/.config/
cp -r   combined/rofi/                  ~/.config/
cp -r   combined/ncspot/config.toml     ~/.config/ncspot/
cp -r   combined/.bashrc            	~/

success

echo "Exiting..."
exit 0

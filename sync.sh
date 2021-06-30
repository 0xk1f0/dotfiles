#!/usr/bin/env bash

#This is a script to install my dotfiles

##############################################################################
### I take NO responsibility for any deleted configs or destroyed systems! ###
##############################################################################

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
    sleep 1
    clear
}

#clear terminal window
clear

#WARNINGS
echo -e 'This script will install dotfiles from combined/'
sleep 1
#ask for confirmation to run
read -p "Proceed? (y|n) " answerProceed
clear

if [ $answerProceed = 'y' ]; then
    clear
    read -p "Back up present configs? (y|n) " answerBackup
elif [ $answerProceed = 'n' ]; then
    clear
    echo "Exiting..."
    exit 0
else 
    clear
    echo "Unsure, Exiting..."
    exit 0
fi

#ask for backup
if [ $answerBackup = 'y' ]; then
    clear
    echo "Chose Backup"
    sleep 1
    clear

    timeout "Backing up present configs to .old in..."

    mv  ~/.config/kitty                     ~/.config/kitty.old
    mv  ~/.config/pacwall                   ~/.config/pacwall.old
    mv  ~/.bashrc                           ~/.bashrc.old
    mv  ~/.config/nano                      ~/.config/nano.old
    mv  ~/.config/picom                     ~/.config/picom.old
    mv  ~/.config/rofi                      ~/.config/rofi.old
    mv  ~/.config/ncspot/config.toml        ~/.config/ncspot/config.toml.old

    success

elif [ $answerBackup = 'n' ]; then
    clear
    echo "NO Backup present configs will be created"
    sleep 1
    clear

    timeout "Deleting old configs (if present) in..."

    rm -rf  ~/.config/kitty/
    rm -rf  ~/.config/pacwall/
    rm -f   ~/.bashrc
    rm -rf  ~/.config/nano/
    rm -rf  ~/.config/picom/
    rm -rf  ~/.config/rofi/
    rm -f   ~/.config/ncspot/config.toml

    success

else
    clear
    echo "Unsure, Exiting..."
    exit 0
fi

if [ $answerLaptop = 'y' ]; then
    timeout "Copying new configs in..."
    #device specific
elif [ $answerLaptop = 'n' ]; then
    timeout "Copying new configs in..."
    #device specific
else
    clear
    echo "Device not specified!"
    sleep 2
    echo "Exiting..."
    exit 0
fi

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
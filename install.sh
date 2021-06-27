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
echo -e 'This script will install dotfiles from combined/ to your .config/ directory\n'
sleep 1
echo -e 'This script deletes, moves and copies files in the process!\n
##############################################################################
### I take NO responsibility for any deleted configs or destroyed systems! ###
##############################################################################\n'
sleep 1

#ask for confirmation to run
read -p "Do you want to proceed? (y|n) " answerProceed
clear
read -p "Are you on a Laptop? (y|n) " answerLaptop
clear

if [ $answerProceed = 'y' ]; then
    if [ $answerLaptop = 'y' ]; then
        clear
        echo "On Laptop"
        sleep 2
    else
        clear
        echo "On PC"
        sleep 2
    fi
    clear
    read -p "Do you want to back up your present configs? (y|n) " answerBackup
elif [ $answerProceed = 'n' ]; then
    clear
    echo "Exiting..."
    exit
else 
    clear
    echo "Unsure, Exiting..."
    exit
fi

#ask for backup
if [ $answerBackup = 'y' ]; then
    clear
    echo "Chose Backup"
    sleep 2
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
    echo ""
    echo "#############"
    echo "# !WARNING! #"
    echo "#############"
    echo ""
    echo "NO BACKUP OF YOUR OLD CONFIGS WILL BE CREATED!"
    echo ""
    sleep 2
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
    exit
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
    exit
fi

#combined configs
cp -r   combined/kitty/                 ~/.config/
cp -r   combined/pacwall/               ~/.config/
cp -r   combined/nano/                  ~/.config/
cp -r   combined/picom/                 ~/.config/
cp -r   combined/rofi/                  ~/.config/
cp -r   combined/ncspot/config.toml     ~/.config/ncspot/
cp -r   combined/.bashrc            	~/

success

echo "Enjoy your new configs!"
sleep 2
echo "Exiting..."
exit

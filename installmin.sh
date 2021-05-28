#!/usr/bin/bash

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
echo "Minimal Install Script"
echo ""
echo "This script will install k1f0's dotfiles (excluding polybar and hlwm) to your .config/ directory"
echo ""
echo "#############"
echo "# !WARNING! #"
echo "#############"
echo ""
sleep 1
echo "1. Always examine a bash script before you execute it to understand what it does!"
echo ""
echo "2. If you find any errors in this script, please inform the maintainer ASAP!"
echo ""
echo "3. This script deletes, moves and copies files in the process!"
echo ""
echo "4. Follow the installer prompts CAREFULLY as you will be asked for a backup!"
echo ""
echo "5. This script is only made to work on Arch based Distributions of GNU/Linux!"
echo ""
echo "#########################################################################################"
echo "### I take ABSOLUTELY NO responsibility for any deleted configs or destroyed systems! ###"
echo "#########################################################################################"
echo ""
echo "YOU HAVE BEEN WARNED!"
echo ""
sleep 1

#ask for confirmation to run
read -p "Do you want to proceed? (y|n) " answer1
clear
read -p "Are you on a Laptop? (y|n) " answer3

if [ $answer1 = 'y' ]; then
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

timeout "Copying new configs in..."

if [ $answer3 = 'y' ]; then
    #copying new files
    cp -r laptop/kitty/ ~/.config/
    cp -r laptop/pacwall/ ~/.config/
    cp -r laptop/bash/bashrc ~/
    mv ~/bashrc ~/.bashrc
    cp -r laptop/nano/ ~/.config/
    cp -r laptop/picom/ ~/.config/
elif [ $answer3 = 'n' ]; then
    #copying new files
    cp -r pc/kitty/ ~/.config/
    cp -r pc/pacwall/ ~/.config/
    cp -r pc/bash/bashrc ~/
    mv ~/bashrc ~/.bashrc
    cp -r pc/nano/ ~/.config/
    cp -r pc/picom/ ~/.config/
else
    clear
    echo "Device not specified!"
    sleep 2
    echo "Exiting..."
    exit
fi

success

echo "Enjoy your new configs!"
sleep 2
echo "Exiting..."
exit
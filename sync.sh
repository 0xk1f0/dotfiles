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

exiting() {
    clear
    echo "Exiting..."
    exit 0
}

menuwidth=10
menuheight=60

whiptail --defaultno --title "Sync Script" --yesno "Proceed?" $menuwidth $menuheight

if [ $(echo $?) -eq 0 ]; then
    clear
else
    exiting
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

echo "Done!"
exit 0

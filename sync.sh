#!/usr/bin/env bash

#This is a script to install my dotfiles

##############################################################################
### I take NO responsibility for any deleted configs or destroyed systems! ###
##############################################################################

timeout () {
    echo $1
    sleep 1
    echo "Now!"
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
rm -f   ~/.bashrc
rm -rf  ~/.config/nano/
rm -rf  ~/.config/picom/
rm -rf  ~/.config/nvim/
rm -f   ~/.config/ncspot/config.toml
rm -rf  ~/.config/zathura/

success

timeout "Copying new configs in..."

#copy new configs
cp -r   combined/kitty/                 ~/.config/
cp -r   combined/nano/                  ~/.config/
cp -r   combined/picom/                 ~/.config/
cp -r   combined/nvim/                  ~/.config/
cp -r   combined/ncspot/config.toml     ~/.config/ncspot/
cp -r   combined/.bashrc            	~/
cp -r   combined/zathura/		~/.config/
success

exit 0

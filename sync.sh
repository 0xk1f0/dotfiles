#!/bin/bash

##############################################################################
### I take NO responsibility for any deleted configs or destroyed systems! ###
##############################################################################

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

whiptail --defaultno --title "Sync Script" --yesno "Proceed?" 10 60

if [ $(echo $?) -eq 0 ]; then
    clear
else
    exiting
fi

echo "Deleting old combined configs"
sleep 1

rm -rf  ~/.config/kitty/
rm -f   ~/.bashrc
rm -rf  ~/.config/nano/
rm -rf  ~/.config/picom/
rm -f   ~/.config/ncspot/config.toml
rm -rf  ~/.config/zathura/

success

echo "Copying new combined configs"
sleep 1

cp -r   combined/kitty/                 ~/.config/
cp -r   combined/nano/                  ~/.config/
cp -r   combined/picom/                 ~/.config/
cp -r   combined/ncspot/config.toml     ~/.config/ncspot/
cp -r   combined/.bashrc            	~/
cp -r   combined/zathura/		        ~/.config/

success

exit 0

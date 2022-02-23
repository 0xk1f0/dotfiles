#!/bin/bash

##############################################################################
### I take NO responsibility for any deleted configs or destroyed systems! ###
##############################################################################

exiting() {
    clear
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "2" "::" "Exiting..."
    exit 0
}

whiptail --defaultno --title "Combined configs sync script" --yesno "Proceed?" 10 60

if [ $(echo $?) -eq 0 ]; then
    printf "\e[3m\e[1m%s\e[0m\n" "sync.sh"
fi

printf "\e[1m\e[9%sm%s\e[0m%s\n" "1" "::" "Deleting old combined configs"
sleep 1

rm -rf  ~/.config/kitty/
rm -f   ~/.bashrc
rm -rf  ~/.config/nano/
rm -rf  ~/.config/picom/
rm -f   ~/.config/ncspot/config.toml
rm -rf  ~/.config/zathura/

printf "\e[1m\e[9%sm%s\e[0m%s\n" "3" "::" "Copying new combined configs"
sleep 1

cp -r   combined/kitty/                 ~/.config/
cp -r   combined/nano/                  ~/.config/
cp -r   combined/picom/                 ~/.config/
cp -r   combined/ncspot/config.toml     ~/.config/ncspot/
cp -r   combined/.bashrc            	~/
cp -r   combined/zathura/		        ~/.config/

exit 0

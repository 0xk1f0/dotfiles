#!/usr/bin/env bash

#This is a script to install my dotfiles

#functions

success () {
    echo "Done!"
    sleep 2
    clear
}

#clear terminal window
clear

if [ $(id -u) != 0 ]; then
    echo "Script must be run with sudo!"
    exit 1
fi

echo -e 'This script will install my most used packages\n'
sleep 2

#ask for confirmation to run
read -p "Do you want to proceed? (y|n) " answerProceed

if [ $answerProceed = 'y' ]; then
    echo "Installing packages ..."
    sleep 1
    echo "WM + stuff ..."
    pacman -S herbstluftwm picom nitrogen dunst dzen2 dmenu --noconfirm
    echo "Audio"
    pacman -S pamixer playerctl pipewire pipewire-pulse pipewirejack pipewire-alsa --noconfirm
    echo "Terminal + File Manager"
    pacman -S kitty nemo nemo-fileroller nemo-preview gzip --noconfirm
    echo "Image ..."
    pacman -S feh flameshot gimp
    echo "Messaging ..."
    pacman -S signal-desktop discord telegram-desktop --noconfirm
    echo "Networking ..."
    pacman -S wireshark-qt reflector pacman-mirrorlist traceroute ipcalc nm-connection-editor --noconfirm

    success

    echo -e '\033[31mMIssing AUR-Packages:\033[37m\npolybar\nncspot\nfirefox-nightly'
    echo -e '\nInstall them with paru, yay or any other AUR helper!'
    exit
else
    clear
    echo "Exiting..."
    exit
fi

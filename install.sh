#!/usr/bin/bash

#This is a script to install my dotfiles

#clear terminal window
clear

#WARNINGS
echo "This script will install k1f0's dotfiles to your .config/ directory"
echo ""
echo "#############"
echo "# !WARNING! #"
echo "#############"
echo ""
sleep 1
echo "1. Always examine a bash script before you execute it to understand what it does!"
echo ""
sleep 1
echo "2. If you find any errors in this script, please inform the maintainer ASAP!"
echo ""
sleep 1
echo "3. This script deletes, moves and copies files in the process!"
echo ""
sleep 1
echo "4. Follow the installer prompts CAREFULLY as you will be asked for a backup!"
sleep 1
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

if [ $answer1 = 'y' ]; then
    clear
    read -p "Do you want to back up your present configs? (y|n) " answer2
elif [ $answer1 = 'Y' ]; then
    clear
    read -p "Do you want to back up your present configs? (y|n) " answer2
elif [ $answer1 = 'n' ]; then
    clear
    echo "Exiting..."
    exit
elif [ $answer1 = 'N' ]; then
    clear
    echo "Exiting..."
    exit
elif [ $answer1 = ]; then
    clear
    echo "No answer was given, exiting..."
    exit
else 
    clear
    echo "Exiting..."
    exit
fi

#ask for backup
if [ $answer2 = 'y' ]; then
    clear
    echo "Backing up present configs to .old in..."
    echo "3..."
    sleep 1
    echo "2..."
    sleep 1
    echo "1..."
    sleep 1

    #backup configs if present
    mv ~/.config/herbstluftwm ~/.config/herbstluftwm.old
    mv ~/.config/dunst ~/.config/dunst.old
    mv ~/.config/polybar ~/.config/polybar.old
    mv ~/.config/kitty ~/.config/kitty.old
    mv ~/.config/pacwall ~/.config/pacwall.old
    mv ~/.bashrc ~/.bashrc.old

    echo "Done!"
    sleep 1
    clear
    echo "Proceeding in..."
elif [ $answer2 = 'Y' ]; then
    clear
    echo "Backing up present configs to .old in..."
    echo "3..."
    sleep 1
    echo "2..."
    sleep 1
    echo "1..."
    sleep 1

    #backup configs if present
    mv ~/.config/herbstluftwm ~/.config/herbstluftwm.old
    mv ~/.config/dunst ~/.config/dunst.old
    mv ~/.config/polybar ~/.config/polybar.old
    mv ~/.config/kitty ~/.config/kitty.old
    mv ~/.config/pacwall ~/.config/pacwall.old
    mv ~/.bashrc ~/.bashrc.old

    echo "Done!"
    sleep 1
    clear
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
    echo "Deleting old configs (if present) in..."
    echo "3..."
    sleep 1
    echo "2..."
    sleep 1
    echo "1..."
    sleep 1

    #delete old configs
    rm -rf ~/.config/herbstluftwm/
    rm -rf ~/.config/dunst/
    rm -rf ~/.config/polybar/
    rm -rf ~/.config/kitty/
    rm -rf ~/.config/pacwall/
    rm -f ~/.bashrc

    echo "Done!"
    sleep 1
    clear
elif [ $answer2 = 'N' ]; then
    clear
    echo ""
    echo "#############"
    echo "# !WARNING! #"
    echo "#############"
    echo ""
    echo "NO BACKUP OF YOUR OLD CONFIGS WILL BE CREATED!"
    echo ""
    sleep 2
    echo "Deleting old configs (if present) in..."
    echo "3..."
    sleep 1
    echo "2..."
    sleep 1
    echo "1..."
    sleep 1

    #delete old configs
    rm -rf ~/.config/herbstluftwm/
    rm -rf ~/.config/dunst/
    rm -rf ~/.config/polybar/
    rm -rf ~/.config/kitty/
    rm -rf ~/.config/pacwall/
    rm -f ~/.bashrc

    echo "Done!"
    sleep 1
    clear
elif [ $answer2 = ]; then
    clear
    echo "No answer was given, exiting..."
    exit
else 
    clear
    echo "Exiting..."
    exit
fi

echo "Copying new configs in..."
echo "3..."
sleep 1
echo "2..."
sleep 1
echo "1..."
sleep 1

#copying new files
cp -r herbstluftwm/ ~/.config/
cp -r dunst/ ~/.config/
cp -r polybar/ ~/.config/
cp -r kitty/ ~/.config/
cp -r pacwall/ ~/.config/
cp -r bash/bashrc ~/
mv ~/bashrc ~/.bashrc

echo "Done!"
sleep 1
clear

#check if user created backups
if [ $answer2 = 'y' ]; then
    clear
    read -p "Do you wish to delete the created .old Backups? (y|n) " answer3
elif [ $answer2 = 'Y' ]; then
    clear
    read -p "Do you wish to delete the created .old Backups? (y|n) " answer3
elif [ $answer2 = 'N' ]; then
    clear
    echo "Enjoy your new configs!"
    sleep 2
    echo "Exiting..."
    exit
elif [ $answer2 = 'n' ]; then
    clear
    echo "Enjoy your new configs!"
    sleep 2
    echo "Exiting..."
    exit
fi

if [ $answer3 = 'y' ]; then
    echo "Deleting Backups in..."
    echo "3..."
    sleep 1
    echo "2..."
    sleep 1
    echo "1..."
    sleep 1
    #delete backups
    rm -rf ~/.config/herbstluftwm.old
    rm -rf ~/.config/dunst.old
    rm -rf ~/.config/polybar.old
    rm -rf ~/.config/kitty.old
    rm -rf ~/.config/pacwall.old
    rm -rf ~/.bashrc.old
    echo "Done!"
    sleep 1
    clear
elif [ $answer3 = 'Y' ]; then
    echo "Deleting Backups in..."
    echo "3..."
    sleep 1
    echo "2..."
    sleep 1
    echo "1..."
    sleep 1
    #delete backups
    rm -rf ~/.config/herbstluftwm.old
    rm -rf ~/.config/dunst.old
    rm -rf ~/.config/polybar.old
    rm -rf ~/.config/kitty.old
    rm -rf ~/.config/pacwall.old
    rm -rf ~/.bashrc.old
    echo "Done!"
    sleep 1
    clear
elif [ $answer3 = 'n' ]; then
    clear
    echo "Enjoy your new configs!"
    sleep 2
    echo "Exiting..."
    exit
elif [ $answer3 = 'N' ]; then
    clear
    echo "Enjoy your new configs!"
    sleep 2
    echo "Exiting..."
    exit
elif [ $answer3 = ]; then
    clear
    echo "Enjoy your new configs!"
    sleep 2
    echo "No answer was given, exiting..."
    exit
else
    clear
    echo "Enjoy your new configs!"
    sleep 2
    echo "Exiting..."
    exit
fi

echo "Enjoy your new configs!"
sleep 2
echo "Exiting..."
exit
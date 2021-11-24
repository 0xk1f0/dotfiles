#!/usr/bin/env bash

#This is a script to pull all dotfiles to this repo

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
optionwidth=2

whiptail --defaultno --title "Installer Script" --yesno "Proceed?" $menuwidth $menuheight

if [ $(echo $?) -eq 0 ]; then
    CHOICE=$(whiptail --title "Choose Device" --menu "What Device are you on?" $menuwidth $menuheight $optionwidth \
	"1)" "PC"   \
	"2)" "Laptop"  3>&2 2>&1 1>&3
    )
else
    exiting
fi

if [ $CHOICE == '2)' ]; then
    platform="Laptop"
    whiptail --defaultno --clear --title "Pulling from $platform" --yesno "Include combined in Pull?" $menuwidth $menuheight

    if [ $(echo $?) -eq 0 ]; then
        answerCombined="y"
        echo "Including combined in pull"
    else
        answerCombined="n"
        echo "NOT including combined in pull"
    fi

    sleep 1
    clear

    timeout "Deleting old configs in..."

    rm -rf  laptop/dunst/
    rm -rf  laptop/herbstluftwm/
    rm -rf  laptop/qtile/
    rm -rf  laptop/polybar/
    rm -rf  laptop/rofi/
    rm -rf  laptop/leftwm/
    rm -rf  laptop/scripts/

    if [ "$answerCombined" == 'y' ]; then
        rm -rf  combined/kitty/
        rm -rf  combined/pacwall/
        rm -f   combined/.bashrc
        rm -rf  combined/nano/
        rm -rf  combined/picom/
	    rm -rf  combined/nvim/
        rm -f   combined/ncspot/config.toml
	    rm -rf  combined/zathura/
    fi

    success
    timeout "Pulling new configs in..."

    cp -r   ~/.config/herbstluftwm 	    laptop/
    cp -r   ~/.config/qtile		        laptop/
    cp -r   ~/.config/dunst 		    laptop/
    cp -r   ~/.config/polybar 		    laptop/
    cp -r   ~/.config/rofi 		        laptop/
    cp -r   ~/.config/leftwm            laptop/
    cp -r   ~/.config/scripts           laptop/

    if [ "$answerCombined" == 'y' ]; then
        cp -r   ~/.config/kitty                     combined/
        cp -r   ~/.config/pacwall                   combined/
        cp -r   ~/.bashrc                           combined/
        cp -r   ~/.config/nano                      combined/
        cp -r   ~/.config/picom                     combined/
        cp -r   ~/.config/ncspot/config.toml        combined/ncspot/config.toml
        cp -r   ~/.config/nvim/        		        combined/
	    cp -r   ~/.config/zathura/		            combined/
    fi

    success

elif [ $CHOICE == '1)' ]; then
    platform="PC"
    whiptail --defaultno --clear --title "Pulling from $platform" --yesno "Include combined in Pull?" $menuwidth $menuheight

    if [ $(echo $?) -eq 0 ]; then
        answerCombined="y"
        echo "Including combined in pull"
    else
        answerCombined="n"
        echo "NOT including combined in pull"
    fi

    sleep 1
    clear

    timeout "Deleting old configs in..."

    rm -rf pc/dunst/
    rm -rf pc/herbstluftwm/
    rm -rf pc/qtile/
    rm -rf pc/polybar/
    rm -rf pc/rofi/
    rm -rf pc/leftwm/
    rm -rf pc/scripts/

    if [ "$answerCombined" == 'y' ]; then
        rm -rf  combined/kitty/
        rm -rf  combined/pacwall/
        rm -r   combined/.bashrc
        rm -rf  combined/nano/
        rm -rf  combined/picom/
        rm -rf  combined/nvim/
	    rm -f   combined/ncspot/config.toml
	    rm -rf  combined/zathura/
    fi

    success
    timeout "Pulling new configs in..."

    cp -r   ~/.config/herbstluftwm 	    pc/
    cp -r   ~/.config/qtile		        pc/
    cp -r   ~/.config/dunst 		    pc/
    cp -r   ~/.config/polybar   	    pc/
    cp -r   ~/.config/rofi 		        pc/
    cp -r   ~/.config/leftwm            pc/
    cp -r   ~/.config/scripts           pc/

    if [ "$answerCombined" == 'y' ]; then
        cp -r   ~/.config/kitty                     combined/
        cp -r   ~/.config/pacwall                   combined/
        cp -r   ~/.bashrc                           combined/
        cp -r   ~/.config/nano                      combined/
        cp -r   ~/.config/picom                     combined/
        cp -r   ~/.config/ncspot/config.toml        combined/ncspot/config.toml
	    cp -r   ~/.config/nvim/        		        combined/
	    cp -r   ~/.config/zathura/		            combined/
    fi

    success

else

    exiting

fi

exit 0

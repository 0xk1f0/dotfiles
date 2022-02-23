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

deleteConfigs() {
    echo "Deleting old configs for $2"
    sleep 1
    rm -rf  $1/dunst/
    rm -rf  $1p/herbstluftwm/
    rm -rf  $1/qtile/
    rm -rf  $1/polybar/
    rm -rf  $1/rofi/
    rm -rf  $1/leftwm/
    rm -rf  $1/scripts/
}

copyConfigs() {
    echo "Pulling new configs for $2"
    sleep 1
    cp -r   ~/.config/herbstluftwm 	    $1/
    cp -r   ~/.config/qtile		        $1/
    cp -r   ~/.config/dunst 		    $1/
    cp -r   ~/.config/polybar 		    $1/
    cp -r   ~/.config/rofi 		        $1/
    cp -r   ~/.config/leftwm            $1/
    cp -r   ~/.config/scripts           $1/
}

delConfigsCombined() {
    echo "Deleting old combined configs"
    sleep 1
    rm -rf  combined/kitty/
    rm -rf  combined/pacwall/
    rm -f   combined/.bashrc
    rm -rf  combined/nano/
    rm -rf  combined/picom/
    rm -f   combined/ncspot/config.toml
    rm -rf  combined/zathura/
}

copyConfigsCombined() {
    echo "Pulling new combined configs"
    sleep 1
    cp -r   ~/.config/kitty                     combined/
    cp -r   ~/.config/pacwall                   combined/
    cp -r   ~/.bashrc                           combined/
    cp -r   ~/.config/nano                      combined/
    cp -r   ~/.config/picom                     combined/
    cp -r   ~/.config/ncspot/config.toml        combined/ncspot/config.toml
    cp -r   ~/.config/zathura/		            combined/
}

menuwidth=10
menuheight=60
optionwidth=2

whiptail --defaultno --title "Configs Puller Script" --yesno "Proceed?" $menuwidth $menuheight

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
        sleep 1
    else
        answerCombined="n"
        echo "NOT including combined in pull"
        sleep 1
    fi

    clear

    deleteConfigs "laptop" $platform

    if [ "$answerCombined" == 'y' ]; then
        delConfigsCombined
    fi

    copyConfigs "laptop" $platform

    if [ "$answerCombined" == 'y' ]; then
        copyConfigsCombined
    fi

    success

elif [ $CHOICE == '1)' ]; then
    platform="PC"
    whiptail --defaultno --clear --title "Pulling from $platform" --yesno "Include combined in Pull?" $menuwidth $menuheight

    if [ $(echo $?) -eq 0 ]; then
        answerCombined="y"
        echo "Including combined in pull"
        sleep 1
    else
        answerCombined="n"
        echo "NOT including combined in pull"
        sleep 1
    fi

    clear

    deleteConfigs "pc" $platform

    if [ "$answerCombined" == 'y' ]; then
        delConfigsCombined
    fi

    copyConfigs "pc" $platform

    if [ "$answerCombined" == 'y' ]; then
        copyConfigsCombined
    fi

    success

else
    exiting
fi

exit 0

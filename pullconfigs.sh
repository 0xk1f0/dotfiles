#!/bin/bash

##############################################################################
### I take NO responsibility for any deleted configs or destroyed systems! ###
##############################################################################

menuwidth=10
menuheight=60
optionwidth=2

exiting() {
    clear
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "2" "::" "Exiting..."
    exit 0
}

deleteConfigs() {
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "1" "::" "Deleting old configs for $2"
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
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "3" "::" "Pulling new configs for $2"
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
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "1" "::" "Deleting old combined configs"
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
    printf "\e[1m\e[9%sm%s\e[0m%s\n" "3" "::" "Pulling new combined configs"
    sleep 1
    cp -r   ~/.config/kitty                     combined/
    cp -r   ~/.config/pacwall                   combined/
    cp -r   ~/.bashrc                           combined/
    cp -r   ~/.config/nano                      combined/
    cp -r   ~/.config/picom                     combined/
    cp -r   ~/.config/ncspot/config.toml        combined/ncspot/config.toml
    cp -r   ~/.config/zathura/		            combined/
}

handleCombined() {
    whiptail --defaultno --clear --title "Configs Puller Script" --yesno "Include combined in Pull?" $menuwidth $menuheight

    if [ $(echo $?) -eq 0 ]; then
        answerCombined="y"
    else
        answerCombined="n"
    fi
}

confirmActions() {
    whiptail --defaultno --clear --title "Configs Puller Script" --yesno "Are these Options correct?\n- Platform: $1\n- Combined in Pull: $2" $menuwidth $menuheight

    if [ $(echo $?) -eq 0 ]; then
        printf "\e[3m\e[1m%s\e[0m\n" "pullconfigs.sh"
    fi
}

CHOICE=$(whiptail --title "Configs Puller Script" --menu "What Device are you on?" $menuwidth $menuheight $optionwidth \
"1)" "PC"   \
"2)" "Laptop"  3>&2 2>&1 1>&3
)

if [ $CHOICE == '2)' ]; then 
    platform="Laptop"
    handleCombined
    confirmActions $platform $answerCombined
    deleteConfigs "laptop" $platform

    if [ "$answerCombined" == 'y' ]; then
        delConfigsCombined
    fi

    copyConfigs "laptop" $platform

    if [ "$answerCombined" == 'y' ]; then
        copyConfigsCombined
    fi
elif [ $CHOICE == '1)' ]; then
    platform="PC"
    handleCombined
    confirmActions $platform $answerCombined
    deleteConfigs "pc" $platform

    if [ "$answerCombined" == 'y' ]; then
        delConfigsCombined
    fi

    copyConfigs "pc" $platform

    if [ "$answerCombined" == 'y' ]; then
        copyConfigsCombined
    fi
else
    exiting
fi

exit 0

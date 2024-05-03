#!/bin/bash

# clipboard persist
killall -9q wl-clip-persist
wl-clip-persist --clipboard regular &

# dunst
killall -9q dunst
cat "/home/$USER/.config/dunst/configrc" \
"/home/$USER/.config/dunst/lib/dunstrc" \
| dunst -conf - &

# eww
killall -9q eww
eww daemon &
eww open topbar

# hypridle
killall -9q hypridle
hypridle &

# wallpaper
killall -9q rwpspread
rwpspread -b hyprpaper --hyprlock -pdi "/home/$USER/.wallpaper" &

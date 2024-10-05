#!/bin/bash

# clipboard persist
pidof wl-clip-persist && killall -9q wl-clip-persist
wl-clip-persist --clipboard regular &

# dunst
pidof dunst && killall -9q dunst
dunst &

# eww
pidof eww && killall -9q eww
eww daemon &
eww open topbar &

# hypridle
pidof hypridle && killall -9q hypridle
hypridle &

# wallpaper
pidof rwpspread && killall -9q rwpspread
rwpspread -b hyprpaper -l hyprlock -pdi "/home/$USER/.wallpaper" &

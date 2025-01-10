#!/bin/bash

# clipboard persist
pidof wl-clip-persist && killall -s 15 -q wl-clip-persist
wl-clip-persist --clipboard regular &

# dunst
pidof dunst && killall -s 15 -q dunst
dunst &

# eww
pidof eww && killall -s 15 -q eww
eww daemon &
eww open topbar &

# hypridle
pidof hypridle && killall -s 15 -q hypridle
hypridle &

# wallpaper
pidof rwpspread && killall -s 15 -q rwpspread
rwpspread -b hyprpaper -l hyprlock -c 120 -pdi "/home/$USER/.wallpaper" &

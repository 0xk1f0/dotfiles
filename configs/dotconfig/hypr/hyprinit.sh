#!/usr/bin/env bash

#       __  ___________        __                     _       _ __
#      / /_<  / __/ __ \      / /_  __  ______  _____(_)___  (_) /_
#     / //_/ / /_/ / / /_____/ __ \/ / / / __ \/ ___/ / __ \/ / __/
#    / ,< / / __/ /_/ /_____/ / / / /_/ / /_/ / /  / / / / / / /_
#   /_/|_/_/_/  \____/     /_/ /_/\__, / .___/_/  /_/_/ /_/_/\__/
#                              /____/_/

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
rwpspread -b hyprpaper -l hyprlock --bezel 80 -wpdi "/home/$USER/.wallpaper" &

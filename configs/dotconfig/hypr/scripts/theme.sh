#!/bin/bash

# size var
CURSOR_SIZE=4

# general GTK
gsettings set org.gnome.desktop.interface gtk-theme 'Orchis-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface font-name 'Open Sans 11'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# cursor
gsettings set org.gnome.desktop.interface cursor-theme 'XCursor-Pro-Dark'
gsettings set org.gnome.desktop.interface cursor-size $CURSOR_SIZE
hyprctl setcursor XCursor-Pro-Dark $CURSOR_SIZE

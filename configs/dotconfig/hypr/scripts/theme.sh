#!/bin/bash

# general GTK
gsettings set org.gnome.desktop.interface gtk-theme 'Orchis-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface font-name 'Open Sans 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro 11'
gsettings set org.gnome.desktop.interface document-font-name 'Open Sans 11'
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-color-scheme prefer-dark

# cursor
gsettings set org.gnome.desktop.interface cursor-theme XCursor-Pro-Dark
gsettings set org.gnome.desktop.interface cursor-size 4
hyprctl setcursor XCursor-Pro-Dark 4

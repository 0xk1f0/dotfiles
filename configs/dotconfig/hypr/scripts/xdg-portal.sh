#!/bin/bash

sleep 2
systemctl --user restart xdg-desktop-portal-hyprland
sleep 2
systemctl --user restart xdg-desktop-portal
systemctl --user restart xdg-desktop-portal-gtk

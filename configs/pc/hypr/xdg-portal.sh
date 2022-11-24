#!/bin/bash

sleep 2
systemctl stop --user \
xdg-desktop-portal \
xdg-desktop-portal-wlr \
xdg-desktop-portal-gtk
systemctl start --user xdg-desktop-portal-wlr
sleep 2
systemctl start --user xdg-desktop-portal

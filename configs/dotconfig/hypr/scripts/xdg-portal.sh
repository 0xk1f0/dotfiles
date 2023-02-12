#!/bin/bash

sleep 2
systemctl --user stop xdg-desktop-portal*
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal-gtk
killall xdg-desktop-portal
/usr/lib/xdg-desktop-portal-wlr &
sleep 2
/usr/lib/xdg-desktop-portal-gtk &
/usr/lib/xdg-desktop-portal &

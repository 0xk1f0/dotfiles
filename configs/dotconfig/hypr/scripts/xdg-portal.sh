#!/bin/bash

systemctl stop --user xdg-desktop-portal*
systemctl stop --user xsettingsd
systemctl start --user xdg-desktop-portal-wlr
sleep 1
systemctl start --user xdg-desktop-portal-gtk
systemctl start --user xsettingsd
sleep 1
systemctl start --user xdg-desktop-portal

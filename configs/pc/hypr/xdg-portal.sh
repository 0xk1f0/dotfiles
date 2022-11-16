#!/bin/bash

sleep 2
systemctl stop --user xdg-desktop-portal
systemctl restart --user xdg-desktop-portal-wlr
systemctl restart --user xdg-desktop-portal-gtk
sleep 2
systemctl start --user xdg-desktop-portal

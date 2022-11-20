#!/bin/bash

sleep 2
systemctl restart --user xdg-desktop-portal-wlr
systemctl restart --user xdg-desktop-portal-gtk
systemctl stop --user xdg-desktop-portal
sleep 2
systemctl start --user xdg-desktop-portal

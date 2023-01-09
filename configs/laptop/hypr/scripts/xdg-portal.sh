#!/bin/bash

sleep 1
systemctl stop --user xdg-desktop-portal*
systemctl start --user xdg-desktop-portal-wlr
sleep 2
systemctl start --user xdg-desktop-portal

#!/bin/bash

systemctl stop --user xdg-desktop-portal*
systemctl start --user xdg-desktop-portal-wlr
sleep 1
systemctl start --user xdg-desktop-portal-wlr
sleep 1
systemctl start --user xdg-desktop-portal

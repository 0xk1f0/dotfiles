#!/bin/bash

sleep 2
systemctl stop --user xdg-desktop-portal-wlr
systemctl stop --user xdg-desktop-portal
systemctl start --user xdg-desktop-portal-wlr
sleep 2
systemctl start --user xdg-desktop-portal-wlr

#!/bin/bash

DIRLIST="/home/k1f0/Documents/Imp /home/k1f0/Documents/school /home/k1f0/Documents/wallpapers"

rsync -av --delete $DIRLIST /smb/Fabian/Backups/PC/

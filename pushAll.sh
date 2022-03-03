#!/bin/bash

# Universal git push script

echo "Checking for up to date local repo..."
git pull
sleep 1
git add .
read -ep "Specify a commit message: " commitMsg
git commit -m "$commitMsg"
sleep 1
echo "Pushing commit..."
sleep 1
git push
echo "Exiting..."
exit 0

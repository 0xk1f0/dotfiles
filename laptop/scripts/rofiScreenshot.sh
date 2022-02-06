#!/bin/bash

if [ x"$@" = x"Full" ]
then
    coproc ( ~/.config/scripts/takeFullScreenshot.sh > /dev/null )
    exit 0
fi

if [ x"$@" = x"Selection" ]
then
    coproc ( ~/.config/scripts/takeSelectScreenshot.sh > /dev/null )
    exit 0
fi

echo "Selection"
echo "Full"
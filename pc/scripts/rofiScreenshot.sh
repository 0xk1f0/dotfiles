#!/bin/bash

if [ x"$@" = x"Full" ]
then
    coproc ( ~/.config/scripts/takeScreen.sh full > /dev/null )
    exit 0
fi

if [ x"$@" = x"Selection" ]
then
    coproc ( ~/.config/scripts/takeScreen.sh sel > /dev/null )
    exit 0
fi

echo "Selection"
echo "Full"

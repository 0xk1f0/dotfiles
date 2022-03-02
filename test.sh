#!/bin/bash



loopPkgs() {
    for i in ${packages[@]}; do
        echo "combined/"$i
    done
}

loopPkgs
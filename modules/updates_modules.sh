#!/bin/bash

for i in $(ls -d ./*); do
    if [ -d $i ]; then
        cd $i || exit
        git config pull.rebase false
        git pull origin $(git rev-parse --abbrev-ref HEAD)
        cd ..
    fi
done

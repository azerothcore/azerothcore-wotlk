#!/bin/bash

for i in $(ls -d */); do
    if [ -d $i ]; then
        cd $i
        git config pull.rebase false
        git pull origin master
        cd ..
    fi
done

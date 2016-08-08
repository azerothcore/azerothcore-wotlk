#!/bin/bash

CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PATH_MODULES="$CUR_PATH/modules/"
[ ! -d $PATH_MODULES/udw/joiner ] && git clone https://github.com/udw/joiner $PATH_MODULES/udw/joiner -b master
source "$PATH_MODULES/udw/joiner/joiner.sh"



if [[ $1 == "dev" ]]; then
    git submodule update --init "$CUR_PATH/data/doc"
fi

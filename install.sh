#!/usr/bin/env bash

CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PATH_MODULES="$CUR_PATH/modules/"
[ ! -d $PATH_MODULES/drassil/joiner ] && git clone https://github.com/drassil/joiner $PATH_MODULES/drassil/joiner -b master
source "$PATH_MODULES/drassil/joiner/joiner.sh"


# installing repository dependencies
if [[ $1 == "dev" ]]; then
    git submodule update --init "$CUR_PATH/data/doc"
fi


source "$CUR_PATH/bin/installer/main.sh"

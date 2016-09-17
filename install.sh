#!/usr/bin/env bash

CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PATH_MODULES="$CUR_PATH/modules/"
[ ! -d $PATH_MODULES/uwd/joiner ] && git clone https://github.com/uw-dev/joiner $PATH_MODULES/uwd/joiner -b master
source "$PATH_MODULES/uwd/joiner/joiner.sh"


if [[ $1 == "dev" ]]; then
    git submodule update --init "$CUR_PATH/data/doc"
fi

#!/usr/bin/env bash

## GETS THE CURRENT MODULE ROOT DIRECTORY
MOD_LEVEL_UP_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"

source $MOD_LEVEL_UP_ROOT"/conf/conf.sh.dist"

if [ -f $MOD_LEVEL_UP_ROOT"/conf/conf.sh" ]; then
    source $MOD_LEVEL_UP_ROOT"/conf/conf.sh"
fi

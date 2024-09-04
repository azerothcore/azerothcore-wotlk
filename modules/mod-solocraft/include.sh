#!/usr/bin/env bash

MOD_SOLOCRAFT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"

source $MOD_SOLOCRAFT_ROOT"/conf/conf.sh.dist"

if [ -f $MOD_SOLOCRAFT_ROOT"/conf/conf.sh" ]; then
    source $MOD_SOLOCRAFT_ROOT"/conf/conf.sh"
fi

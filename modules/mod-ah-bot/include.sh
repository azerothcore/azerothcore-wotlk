#!/usr/bin/env bash

MOD_AH_BOT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"

source $MOD_AH_BOT_ROOT"/conf/conf.sh.dist"

if [ -f $MOD_AH_BOT_ROOT"/conf/conf.sh" ]; then
    source $MOD_AH_BOT_ROOT"/conf/conf.sh"
fi

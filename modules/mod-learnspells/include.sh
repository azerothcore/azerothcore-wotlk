#!/usr/bin/env bash
MOD_LEARNSPELLS_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"

source $MOD_LEARNSPELLS_ROOT"/conf/conf.sh.dist"

if [ -f $MOD_LEARNSPELLS_ROOT"/conf/conf.sh" ]; then
    source $MOD_LEARNSPELLS_ROOT"/conf/conf.sh"
fi

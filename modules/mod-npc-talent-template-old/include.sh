#!/usr/bin/env bash

TEMPLATENPC_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"

source $TEMPLATENPC_ROOT"/conf/conf.sh.dist"

if [ -f $TEMPLATENPC_ROOT"/conf/conf.sh" ]; then
    source $TEMPLATENPC_ROOT"/conf/conf.sh"
fi

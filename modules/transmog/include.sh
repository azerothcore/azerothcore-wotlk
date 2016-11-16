#!/bin/bash

TRANSM_PATH_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"

source $TRANSM_PATH_ROOT"/conf/conf.sh.dist"

if [ -f $TRANSM_PATH_ROOT"/conf/conf.sh" ]; then
    source $TRANSM_PATH_ROOT"/conf/conf.sh"
fi

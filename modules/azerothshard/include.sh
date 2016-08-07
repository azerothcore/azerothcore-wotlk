#!/bin/bash

AZTHSD_PATH_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"

source $AZTHSD_PATH_ROOT"/conf/conf.sh.dist"

if [ -f $AZTHSD_PATH_ROOT"/conf/conf.sh" ]; then
    source $AZTHSD_PATH_ROOT"/conf/conf.sh.dist"
fi

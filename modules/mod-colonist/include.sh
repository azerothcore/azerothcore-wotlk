#!/usr/bin/env bash

## GETS THE CURRENT MODULE ROOT DIRECTORY
MOD_COLONIST_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"

source $MOD_COLONIST_ROOT"/conf/conf.sh.dist"

if [ -f $MOD_COLONIST_ROOT"/conf/conf.sh" ]; then
    source $MOD_COLONIST_ROOT"/conf/conf.sh"
fi

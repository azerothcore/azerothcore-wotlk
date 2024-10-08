#!/usr/bin/env bash

## GETS THE CURRENT MODULE ROOT DIRECTORY
MOD_IP_TRACKER="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"

source "$MOD_IP_TRACKER/conf/conf.sh.dist"

if [ -f "$MOD_IP_TRACKER/conf/conf.sh" ]; then
    source "$MOD_IP_TRACKER/conf/conf.sh"
fi

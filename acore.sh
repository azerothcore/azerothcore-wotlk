#!/usr/bin/env bash

[ -z "$WITH_ERRORS" ] && set -e

CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


source "$CUR_PATH/apps/installer/main.sh"

#!/usr/bin/env bash

CURRENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" || exit ; pwd )

# shellcheck source=./config.sh
source "$CURRENT_PATH/config.sh"

acore_dash_config "$@"
 

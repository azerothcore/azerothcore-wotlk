#!/usr/bin/env bash

CURRENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" || exit ; pwd )

source "$CURRENT_PATH/modules.sh"

inst_module "$@"
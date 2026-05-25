#!/bin/bash

set -e

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Start mysql
sudo systemctl start mysql

source "$CURRENT_PATH/ci-gen-server-conf-files.sh" $1 "etc" "bin" "root"

(cd ./env/dist/bin/ && timeout 5m ./$APP_NAME -dry-run)

# Stop mysql
sudo systemctl stop mysql

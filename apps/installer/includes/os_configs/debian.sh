#!/usr/bin/env bash

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if ! command -v lsb_release &>/dev/null ; then
       sudo apt-get install -y lsb-release
fi

DEBIAN_VERSION=$(lsb_release -sr)
DEBIAN_VERSION_MIN="12"

if [[ $DEBIAN_VERSION -lt $DEBIAN_VERSION_MIN ]]; then
  echo "########## ########## ##########"
  echo ""
  echo "    using unsupported Debian version" $DEBIAN_VERSION
  echo "    please update to Debian" $DEBIAN_VERSION_MIN "or later"
  echo ""
  echo "########## ########## ##########"
fi

sudo apt-get update -y

sudo apt-get install -y gdbserver gdb unzip curl \
                     libncurses-dev libreadline-dev clang g++ \
                     gcc git cmake make ccache \
                     libssl-dev libbz2-dev \
                     libboost-all-dev gnupg wget

VAR_PATH="$CURRENT_PATH/../../../../var"

# run noninteractive install for MYSQL 8.4 LTS
wget https://dev.mysql.com/get/mysql-apt-config_0.8.32-1_all.deb -P "$VAR_PATH"
sudo DEBIAN_FRONTEND="noninteractive" dpkg -i "$VAR_PATH/mysql-apt-config_0.8.32-1_all.deb"
sudo apt-get update
sudo DEBIAN_FRONTEND="noninteractive" apt-get install -y mysql-server libmysqlclient-dev

#!/usr/bin/env bash

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set SUDO variable - one liner
SUDO=$([ "$EUID" -ne 0 ] && echo "sudo" || echo "")

if ! command -v lsb_release &>/dev/null ; then
       $SUDO apt-get install -y lsb-release
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

$SUDO apt-get update -y

$SUDO apt-get install -y gdbserver gdb unzip curl \
                     libncurses-dev libreadline-dev clang g++ \
                     gcc git cmake make ccache \
                     libssl-dev libbz2-dev \
                     libboost-all-dev gnupg wget jq screen tmux expect

VAR_PATH="$CURRENT_PATH/../../../../var"

# run noninteractive install for MYSQL
MYSQL_APT_CONFIG_VERSION=0.8.36-1
wget "https://dev.mysql.com/get/mysql-apt-config_${MYSQL_APT_CONFIG_VERSION}_all.deb" -P "$VAR_PATH"
DEBIAN_FRONTEND="noninteractive" $SUDO dpkg -i "$VAR_PATH/mysql-apt-config_${MYSQL_APT_CONFIG_VERSION}_all.deb"
$SUDO apt-get update
DEBIAN_FRONTEND="noninteractive" $SUDO apt-get install -y mysql-server libmysqlclient-dev

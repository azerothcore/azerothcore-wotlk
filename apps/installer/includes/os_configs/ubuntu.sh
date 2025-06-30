#!/usr/bin/env bash

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if ! command -v lsb_release &>/dev/null ; then
    sudo apt-get install -y lsb-release
fi

UBUNTU_VERSION=$(lsb_release -sr);

case $UBUNTU_VERSION in
  "22.04")
    ;;
  "24.04")
    ;;
  *)
    echo "########## ########## ##########"
    echo ""
    echo "    using unsupported Ubuntu version " $UBUNTU_VERSION
    echo "    please update to Ubuntu 22.04 or later"
    echo ""
    echo "########## ########## ##########"
    ;;
esac

sudo apt update

# shared deps
sudo DEBIAN_FRONTEND="noninteractive" \
apt-get -y install ccache clang cmake curl google-perftools libmysqlclient-dev make unzip jq screen tmux \
  libreadline-dev libncurses5-dev libncursesw5-dev libbz2-dev git gcc g++ libssl-dev \
  libncurses-dev libboost-all-dev gdb gdbserver

  VAR_PATH="$CURRENT_PATH/../../../../var"


# Do not install MySQL if we are in docker (It will be used a docker container instead) or we are explicitly skipping it.
if [[ $DOCKER != 1 && $SKIP_MYSQL_INSTALL != 1 ]]; then
  # run noninteractive install for MYSQL 8.4 LTS
  wget https://dev.mysql.com/get/mysql-apt-config_0.8.32-1_all.deb -P "$VAR_PATH"
  sudo DEBIAN_FRONTEND="noninteractive" dpkg -i "$VAR_PATH/mysql-apt-config_0.8.32-1_all.deb"
  sudo apt-get update
  sudo DEBIAN_FRONTEND="noninteractive" apt-get install -y mysql-server
fi


if [[ $CONTINUOUS_INTEGRATION ]]; then
  sudo systemctl enable mysql.service
  sudo systemctl start mysql.service
fi


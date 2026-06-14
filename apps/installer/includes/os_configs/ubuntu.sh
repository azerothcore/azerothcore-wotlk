#!/usr/bin/env bash

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set SUDO variable - one liner
SUDO=$([ "$EUID" -ne 0 ] && echo "sudo" || echo "")

if ! command -v lsb_release &>/dev/null ; then
    $SUDO apt-get install -y lsb-release
fi

UBUNTU_VERSION=$(lsb_release -sr);

case $UBUNTU_VERSION in
  "24.04")
    ;;
  "26.04")
    ;;
  *)
    echo "########## ########## ##########"
    echo ""
    echo "    using unsupported Ubuntu version " $UBUNTU_VERSION
    echo "    please update to Ubuntu 24.04 or later"
    echo ""
    echo "########## ########## ##########"
    ;;
esac

$SUDO apt update

# shared deps
DEBIAN_FRONTEND="noninteractive" $SUDO \
apt-get -y install ccache clang cmake curl google-perftools make unzip jq screen tmux \
  libreadline-dev libbz2-dev git gcc g++ libssl-dev \
  libncurses-dev libboost-all-dev gdb gdbserver expect

# version-specific deps
if [[ "$UBUNTU_VERSION" == "26.04" ]]; then
  $SUDO add-apt-repository -y universe
  $SUDO apt-get update
  DEBIAN_FRONTEND="noninteractive" $SUDO apt-get -y install default-libmysqlclient-dev
else
  DEBIAN_FRONTEND="noninteractive" $SUDO apt-get -y install \
    libmysqlclient-dev libncurses5-dev libncursesw5-dev
fi

  VAR_PATH="$CURRENT_PATH/../../../../var"


# Do not install MySQL if we are in docker (It will be used a docker container instead) or we are explicitly skipping it.
if [[ $DOCKER != 1 && $SKIP_MYSQL_INSTALL != 1 ]]; then
  # run noninteractive install for MYSQL 8.4 LTS
  wget https://dev.mysql.com/get/mysql-apt-config_0.8.35-1_all.deb -P "$VAR_PATH"
  # resolve expired key issue
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A8D3785C
  DEBIAN_FRONTEND="noninteractive" $SUDO dpkg -i "$VAR_PATH/mysql-apt-config_0.8.35-1_all.deb"
  $SUDO apt-get update
  DEBIAN_FRONTEND="noninteractive" $SUDO apt-get install -y mysql-server
fi


if [[ $CONTINUOUS_INTEGRATION ]]; then
  $SUDO systemctl enable mysql.service
  $SUDO systemctl start mysql.service
fi


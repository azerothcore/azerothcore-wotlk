#!/usr/bin/env bash

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set SUDO variable - one liner
SUDO=$([ "$EUID" -ne 0 ] && echo "sudo" || echo "")

if ! command -v lsb_release &>/dev/null ; then
    $SUDO apt-get install -y lsb-release
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

$SUDO apt update

# shared deps
DEBIAN_FRONTEND="noninteractive" $SUDO \
apt-get -y install ccache clang cmake curl google-perftools libmysqlclient-dev make unzip jq screen tmux \
  libreadline-dev libncurses5-dev libncursesw5-dev libbz2-dev git gcc g++ libssl-dev \
  libncurses-dev libboost-all-dev gdb gdbserver expect

  VAR_PATH="$CURRENT_PATH/../../../../var"

# Version
MYSQL_APT_CONFIG_VERSION=0.8.34-1

# Do not install MySQL if we are in docker (It will be used a docker container instead) or we are explicitly skipping it.
if [[ $DOCKER != 1 && $SKIP_MYSQL_INSTALL != 1 ]]; then
  # Download
  wget "https://dev.mysql.com/get/mysql-apt-config_${MYSQL_APT_CONFIG_VERSION}_all.deb" -P "$VAR_PATH"
  wget "https://dev.mysql.com/downloads/gpg/?file=mysql-apt-config_${MYSQL_APT_CONFIG_VERSION}_all.deb&p=37" -O "$VAR_PATH/mysql-apt-config_${MYSQL_APT_CONFIG_VERSION}_all.deb.asc"

  # Verify
  gpg --keyserver keyserver.ubuntu.com --recv-keys A8D3785C
  gpg --verify mysql-apt-config_${MYSQL_APT_CONFIG_VERSION}_all.deb.asc mysql-apt-config_${MYSQL_APT_CONFIG_VERSION}_all.deb

  # run noninteractive install for MYSQL 8.4 LTS
  DEBIAN_FRONTEND="noninteractive" $SUDO dpkg -i "$VAR_PATH/mysql-apt-config_0.8.34-1_all.deb"
  $SUDO apt-get update
  DEBIAN_FRONTEND="noninteractive" $SUDO apt-get install -y mysql-server
fi


if [[ $CONTINUOUS_INTEGRATION ]]; then
  $SUDO systemctl enable mysql.service
  $SUDO systemctl start mysql.service
fi


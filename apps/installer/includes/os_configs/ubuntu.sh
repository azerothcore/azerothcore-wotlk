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
apt-get -y install ccache clang cmake curl google-perftools libmysqlclient-dev make unzip

if [[ $CONTINUOUS_INTEGRATION || $DOCKER ]]; then
  # TODO: update CI / Docker section for Ubuntu 22.04+
  sudo add-apt-repository -y ppa:mhier/libboost-latest && sudo apt update && sudo apt-get -y install build-essential cmake-data  \
  libboost1.74-dev libbz2-dev libncurses5-dev libmysql++-dev libgoogle-perftools-dev libreadline6-dev libssl-dev libtool \
  openssl zlib1g-dev
else
  sudo DEBIAN_FRONTEND="noninteractive" \
  apt-get install -y g++ gdb gdbserver gcc git \
  libboost-all-dev libbz2-dev libncurses-dev libreadline-dev \
  libssl-dev

  # run noninteractive install for MYSQL 8.4 LTS
  wget https://dev.mysql.com/get/mysql-apt-config_0.8.32-1_all.deb
  sudo DEBIAN_FRONTEND="noninteractive" dpkg -i ./mysql-apt-config_0.8.32-1_all.deb
  sudo apt-get update
  sudo DEBIAN_FRONTEND="noninteractive" apt-get install -y mysql-server
fi

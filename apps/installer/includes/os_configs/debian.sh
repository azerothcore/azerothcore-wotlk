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
                     default-libmysqlclient-dev libssl-dev libbz2-dev \
                     libboost-all-dev gnupg wget

# run noninteractive install for MYSQL 8.4 LTS
wget https://dev.mysql.com/get/mysql-apt-config_0.8.32-1_all.deb
sudo DEBIAN_FRONTEND="noninteractive" dpkg -i ./mysql-apt-config_0.8.32-1_all.deb
sudo apt-get update
sudo DEBIAN_FRONTEND="noninteractive" apt-get install -y mysql-server


# if ! command -v lsb_release &>/dev/null ; then
#     sudo apt-get install -y lsb-release
# fi

# UBUNTU_VERSION=$(lsb_release -sr);

# Added repo for newest lib
sudo add-apt-repository -y ppa:mhier/libboost-latest
sudo apt update

# shared deps
sudo apt-get -y install make cmake clang curl unzip libmysqlclient-dev libace-dev ccache google-perftools

# Insstall boost 1.73 from ppa:mhier/libboost-latest for all os versions
sudo apt-get -y install libboost1.73-dev

if [[ $CONTINUOUS_INTEGRATION || $DOCKER ]]; then
  sudo apt-get -y install build-essential libtool cmake-data openssl libgoogle-perftools-dev \
  libssl-dev libmysql++-dev libreadline6-dev zlib1g-dev libbz2-dev mysql-client \
  libncurses5-dev
else
  sudo apt-get install -y git gcc g++ gdb gdbserver \
  libssl-dev libbz2-dev libreadline-dev libncurses-dev \
  mysql-server libace-6.*
fi


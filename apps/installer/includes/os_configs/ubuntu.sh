
# if ! command -v lsb_release &>/dev/null ; then
#     sudo apt-get install -y lsb-release
# fi

# UBUNTU_VERSION=$(lsb_release -sr);

sudo apt update

# shared deps
sudo apt-get -y install make cmake clang curl unzip libmysqlclient-dev libace-dev ccache google-perftools

if [[ $CONTINUOUS_INTEGRATION || $DOCKER ]]; then
  sudo add-apt-repository -y ppa:mhier/libboost-latest && apt update && apt-get -y install build-essential libtool cmake-data openssl libgoogle-perftools-dev \
  libboost1.74-dev libssl-dev libmysql++-dev libreadline6-dev zlib1g-dev libbz2-dev mysql-client \
  libncurses5-dev
else
  sudo apt-get install -y git gcc g++ gdb gdbserver \
  libboost-all-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev \
  mysql-server libace-6.*
fi

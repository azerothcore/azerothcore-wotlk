
if ! command -v lsb_release &>/dev/null ; then
       sudo apt-get install -y lsb-release
fi

UBUNTU_VERSION=$(lsb_release -sr);

sudo apt-get update -y

if [[ $CONTINUOUS_INTEGRATION ]]; then
  sudo apt-get -y install build-essential libtool make cmake cmake-data clang openssl libgoogle-perftools-dev \
  libssl-dev libmysqlclient-dev libmysql++-dev libreadline6-dev zlib1g-dev libbz2-dev libace-dev mysql-client \
  libncurses5-dev ccache
else
  sudo apt-get install -y git cmake make gcc g++ clang libmysqlclient-dev \
  libssl-dev libbz2-dev libreadline-dev libncurses-dev \
  mysql-server libace-6.* libace-dev curl unzip
fi
  

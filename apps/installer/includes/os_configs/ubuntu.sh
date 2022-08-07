if ! command -v lsb_release &>/dev/null ; then
    sudo apt-get install -y lsb-release
fi

UBUNTU_VERSION=$(lsb_release -sr);

sudo apt update

# shared deps
sudo apt-get -y install ccache clang cmake curl google-perftools libmysqlclient-dev make unzip

if [[ $CONTINUOUS_INTEGRATION && $UBUNTU_VERSION == "22.04" || $DOCKER && $UBUNTU_VERSION == "22.04" ]]; then
  sudo apt update && sudo apt remove libunwind-14-dev && sudo apt-get -y install build-essential cmake-data  \
  libboost-all-dev libbz2-dev libncurses5-dev libmysql++-dev libgoogle-perftools-dev libreadline6-dev libssl-dev libtool \
  openssl zlib1g-dev
elif [[ $CONTINUOUS_INTEGRATION && $UBUNTU_VERSION == "20.04" || $DOCKER && $UBUNTU_VERSION == "20.04" ]]; then
  sudo add-apt-repository -y ppa:mhier/libboost-latest && sudo apt update && sudo apt-get -y install build-essential cmake-data  \
  libboost1.74-dev libbz2-dev libncurses5-dev libmysql++-dev libgoogle-perftools-dev libreadline6-dev libssl-dev libtool \
  openssl zlib1g-dev
else
  case $UBUNTU_VERSION in
     "22.04")
       sudo apt-get install -y g++ gdb gdbserver gcc git \
       libboost-all-dev libbz2-dev libncurses-dev libreadline-dev \
       libssl-dev mysql-server
       ;;
     "20.04")
       sudo apt-get install -y g++ gdb gdbserver gcc git \
       libboost-all-dev libbz2-dev libncurses-dev libreadline-dev \
       libssl-dev mysql-server
       ;;
     *)
       sudo add-apt-repository -y ppa:mhier/libboost-latest && sudo apt update && sudo apt-get install -y g++ gdb gdbserver gcc git \
       libboost-all-dev libbz2-dev libncurses-dev libreadline-dev \
       libssl-dev mysql-server
       ;;
  esac
fi

#########################################################
###### Openssl 1.1 workaround ###########################
if [[ $UBUNTU_VERSION == "22.04" ]]; then
  CI=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install openssl@1.1
fi
#########################################################

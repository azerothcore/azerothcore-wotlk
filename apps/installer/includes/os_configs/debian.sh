if ! command -v lsb_release &>/dev/null ; then
       sudo apt-get install -y lsb-release
fi

DEBIAN_VERSION=$(lsb_release -sr)

sudo apt-get update -y

sudo apt-get install -y gdbserver gdb unzip curl libace-6.* libace-dev \
                     libncurses-dev libreadline-dev clang g++ \
                     gcc git cmake make ccache

if [[ $DEBIAN_VERSION -eq "10" ]]; then
  sudo apt-get install -y default-libmysqlclient-dev libssl-dev libreadline-dev libncurses-dev mariadb-server
else # Debian 8 and 9 should work using this
  sudo apt-get install -y libmysqlclient-dev libssl1.0-dev mysql-server
fi

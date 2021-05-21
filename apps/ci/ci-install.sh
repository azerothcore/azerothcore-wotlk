#!/bin/bash

set -e

cat >>conf/config.sh <<CONFIG_SH
MTHREADS=$(($(grep -c ^processor /proc/cpuinfo) + 2))
CWARNINGS=ON
CDEBUG=OFF
CTYPE=Release
CSCRIPTS=ON
CBUILD_TESTING=ON
CSERVERS=ON
CTOOLS=ON
CSCRIPTPCH=OFF
CCOREPCH=OFF
CCUSTOMOPTIONS='-DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_FLAGS="-Werror" -DCMAKE_CXX_FLAGS="-Werror"'
DB_CHARACTERS_CONF="MYSQL_USER='root'; MYSQL_PASS='root'; MYSQL_HOST='localhost';"
DB_AUTH_CONF="MYSQL_USER='root'; MYSQL_PASS='root'; MYSQL_HOST='localhost';"
DB_WORLD_CONF="MYSQL_USER='root'; MYSQL_PASS='root'; MYSQL_HOST='localhost';"
CONFIG_SH

time sudo apt-get update -y
# time sudo apt-get upgrade -y
time sudo apt-get install -y git lsb-release sudo ccache
time ./acore.sh install-deps

case $COMPILER in

  # this is in order to use the "default" gcc version of the OS, without forcing a specific version
  "gcc" )
    time sudo apt-get install -y gcc g++
    echo "CCOMPILERC=\"gcc\"" >> ./conf/config.sh
    echo "CCOMPILERCXX=\"g++\"" >> ./conf/config.sh
    ;;

  "gcc8" )
    time sudo apt-get install -y gcc-8 g++-8
    echo "CCOMPILERC=\"gcc-8\"" >> ./conf/config.sh
    echo "CCOMPILERCXX=\"g++-8\"" >> ./conf/config.sh
    ;;

  "gcc10" )
    time sudo apt-get install -y gcc-10 g++-10
    echo "CCOMPILERC=\"gcc-10\"" >> ./conf/config.sh
    echo "CCOMPILERCXX=\"g++-10\"" >> ./conf/config.sh
    ;;

  # this is in order to use the "default" clang version of the OS, without forcing a specific version
  "clang" )
    time sudo apt-get install -y clang
    echo "CCOMPILERC=\"clang\"" >> ./conf/config.sh
    echo "CCOMPILERCXX=\"clang++\"" >> ./conf/config.sh
    ;;

  "clang7" )
    time sudo apt-get install -y clang-7
    echo "CCOMPILERC=\"clang-7\"" >> ./conf/config.sh
    echo "CCOMPILERCXX=\"clang++-7\"" >> ./conf/config.sh
    ;;

  "clang8" )
    time sudo apt-get install -y clang-8
    echo "CCOMPILERC=\"clang-8\"" >> ./conf/config.sh
    echo "CCOMPILERCXX=\"clang++-8\"" >> ./conf/config.sh
    ;;

  "clang9" )
    time sudo apt-get install -y clang-9
    echo "CCOMPILERC=\"clang-9\"" >> ./conf/config.sh
    echo "CCOMPILERCXX=\"clang++-9\"" >> ./conf/config.sh
    ;;

  "clang10" )
    time sudo apt-get install -y clang-10
    echo "CCOMPILERC=\"clang-10\"" >> ./conf/config.sh
    echo "CCOMPILERCXX=\"clang++-10\"" >> ./conf/config.sh
    ;;

  "clang11" )
    time sudo apt-get install -y clang-11
    echo "CCOMPILERC=\"clang-11\"" >> ./conf/config.sh
    echo "CCOMPILERCXX=\"clang++-11\"" >> ./conf/config.sh
    ;;

  "clang12" )
    time sudo apt-get install -y clang-12
    echo "CCOMPILERC=\"clang-12\"" >> ./conf/config.sh
    echo "CCOMPILERCXX=\"clang++-12\"" >> ./conf/config.sh
    ;;

  * )
    echo "Unknown compiler $COMPILER"
    exit 1
    ;;
esac

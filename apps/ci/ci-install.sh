#!/bin/bash

set -e

cat >>conf/config.sh <<CONFIG_SH
MTHREADS=$(expr $(grep -c ^processor /proc/cpuinfo) + 2)
CWARNINGS=ON
CDEBUG=OFF
CTYPE=Release
CSCRIPTS=ON
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
  "clang6" )
    time sudo apt-get install -y clang-6.0
    echo "CCOMPILERC=\"clang-6.0\"" >> ./conf/config.sh
    echo "CCOMPILERCXX=\"clang++-6.0\"" >> ./conf/config.sh
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
    # disable -Werror for clang-10 TODO: remove when this is fixed https://github.com/azerothcore/azerothcore-wotlk/issues/3108
    echo "CCUSTOMOPTIONS='-DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache'" >> ./conf/config.sh
    ;;

  * )
    echo "Unknown compiler $COMPILER"
    exit 1
    ;;
esac

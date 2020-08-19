#!/bin/bash

set -e

COMPILATION_OPTIONS='-DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache'
# These flags below are disabled for gcc, gcc 10 and clang 10.
ADDITIONAL_OPTIONS='-DCMAKE_C_FLAGS="-Werror" -DCMAKE_CXX_FLAGS="-Werror"'
C_COMP=Unknown
CPP_COMP=Unknown

case $COMPILER in
  # this is in order to use the "default" gcc version of the OS, without forcing a specific version
  "gcc" )
    time sudo apt-get install -y gcc g++
    C_COMP=gcc
    CPP_COMP=g++
    ;;

  "gcc10" )
    time sudo apt-get install -y gcc-10 g++-10
    C_COMP=gcc-10
    CPP_COMP=g++-10
    ;;

  # this is in order to use the "default" clang version of the OS, without forcing a specific version
  "clang" )
    time sudo apt-get install -y clang
    C_COMP=clang
    CPP_COMP=clang++
    COMPILATION_OPTIONS="${COMPILATION_OPTIONS} ${ADDITIONAL_OPTIONS}"
    ;;

  "clang6" )
    time sudo apt-get install -y clang-6.0
    C_COMP=clang-6
    CPP_COMP=clang++-6
    COMPILATION_OPTIONS="${COMPILATION_OPTIONS} ${ADDITIONAL_OPTIONS}"
    ;;

  "clang9" )
    time sudo apt-get install -y clang-9
    C_COMP=clang-9
    CPP_COMP=clang++-9
    COMPILATION_OPTIONS="${COMPILATION_OPTIONS} ${ADDITIONAL_OPTIONS}"
    ;;

  "clang10" )
    time sudo apt-get install -y clang-10
    C_COMP=clang-10
    CPP_COMP=clang++-10
    ;;

  * )
    echo "Unknown compiler $COMPILER"
    exit 1
    ;;
esac

cat > conf/config.sh <<CONFIG_SH
MTHREADS=$(expr $(grep -c ^processor /proc/cpuinfo) + 2)
CWARNINGS=ON
CDEBUG=OFF
CTYPE=Release
CSCRIPTS=ON
CUNIT_TESTS=ON
CSERVERS=ON
CTOOLS=ON
CSCRIPTPCH=OFF
CCOREPCH=OFF
DB_CHARACTERS_CONF="MYSQL_USER='root'; MYSQL_PASS='root'; MYSQL_HOST='localhost';"
DB_AUTH_CONF="MYSQL_USER='root'; MYSQL_PASS='root'; MYSQL_HOST='localhost';"
DB_WORLD_CONF="MYSQL_USER='root'; MYSQL_PASS='root'; MYSQL_HOST='localhost';"
CCOMPILERC="${C_COMP}"
CCOMPILERCXX="${CPP_COMP}"
CCUSTOMOPTIONS="${COMPILATION_OPTIONS}"
CONFIG_SH

time sudo apt-get update -y
# time sudo apt-get upgrade -y
time sudo apt-get install -y git lsb-release sudo ccache
time ./acore.sh install-deps



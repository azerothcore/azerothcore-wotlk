#!/bin/bash

set -e

echo "install OS deps (apt-get)"
bash ./acore.sh "install-deps"

if [ "$TRAVIS_BUILD_ID" = "1" ]
then
  echo "install clang-3.8"
  sudo apt-get install clang-3.8
elif [ "$TRAVIS_BUILD_ID" = "2" ]
then
  echo "install clang-7"
  sudo apt-get install clang-7
fi

echo "create config.sh"
cat >>conf/config.sh <<CONFIG_SH
CCOMPILERC=$CCOMPILERC
CCOMPILERCXX=$CCOMPILERCXX
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
DB_CHARACTERS_CONF="MYSQL_USER='root'; MYSQL_PASS='$DB_RND_NAME'; MYSQL_HOST='localhost';"
DB_AUTH_CONF="MYSQL_USER='root'; MYSQL_PASS='$DB_RND_NAME'; MYSQL_HOST='localhost';"
DB_WORLD_CONF="MYSQL_USER='root'; MYSQL_PASS='$DB_RND_NAME'; MYSQL_HOST='localhost';"
DB_AUTH_NAME=auth_$DB_RND_NAME
DB_CHARACTERS_NAME=characters_$DB_RND_NAME
DB_WORLD_NAME=world_$DB_RND_NAME
CONFIG_SH

if [ "$TRAVIS_BUILD_ID" = "1" ]
then
  echo "import DB"
  bash ./acore.sh "db-assembler" "import-all"
fi

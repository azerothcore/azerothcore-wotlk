#!/bin/bash

set -e

if [ "$TRAVIS_BUILD_ID" = "1" ]
then
  export CCOMPILERC="clang-3.8"
  export CCOMPILERCXX="clang++-3.8"

  echo "set root password"
  export DB_RND_NAME=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 5 | head -n 1)
  sudo mysql -e "use mysql; update user set authentication_string=PASSWORD('$DB_RND_NAME') where User='root'; update user set plugin='mysql_native_password';FLUSH PRIVILEGES;"
  sudo mysql_upgrade -u root -p$DB_RND_NAME
  sudo service mysql restart
  printf "[client]\npassword=%s" "$DB_RND_NAME" >~/.my.cnf
  chmod 400 ~/.my.cnf
elif [ "$TRAVIS_BUILD_ID" = "2" ]
then
  export CCOMPILERC="clang-7"
  export CCOMPILERCXX="clang++-7"

  echo "add custom APT repository llvm-toolchain-xenial-7"
  wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
  echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-7 main" | sudo tee -a /etc/apt/sources.list
  sudo apt-get update -qq
fi

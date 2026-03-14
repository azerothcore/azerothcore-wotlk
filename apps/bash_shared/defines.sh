unamestr=$(uname)
if [[ "$unamestr" == 'Darwin' ]]; then
   if ! command -v brew &>/dev/null ; then
       ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
   fi
   if ! [ "${BASH_VERSINFO}" -ge 4 ]; then
       brew install bash
   fi
   if ! command -v greadlink &>/dev/null ; then
       brew install coreutils
   fi
   AC_PATH_ROOT=$(greadlink -f "$AC_PATH_APPS/../")
else
   AC_PATH_ROOT=$(readlink -f "$AC_PATH_APPS/../")
fi

case $AC_PATH_ROOT in
  /*) AC_PATH_ROOT=$AC_PATH_ROOT;;
  *) AC_PATH_ROOT=$PWD/$AC_PATH_ROOT;;
esac

export AC_PATH_CONF="$AC_PATH_ROOT/conf"

export AC_PATH_MODULES="$AC_PATH_ROOT/modules"

export AC_PATH_DEPS="$AC_PATH_ROOT/deps"

export AC_BASH_LIB_PATH="$AC_PATH_DEPS/acore/bash-lib/src"

export AC_PATH_VAR="$AC_PATH_ROOT/var"

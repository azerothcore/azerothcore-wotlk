unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
   AC_PATH_ROOT=$(greadlink -f "$AC_PATH_BIN/../")
else
   AC_PATH_ROOT=$(readlink -f "$AC_PATH_BIN/../")
fi

AC_PATH_CONF="$AC_PATH_ROOT/conf"

AC_PATH_MODULES="$AC_PATH_ROOT/modules"


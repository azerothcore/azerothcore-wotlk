AC_PATH_ROOT=$(readlink -f "$AC_PATH_BIN/../")

AC_PATH_CONF="$AC_PATH_ROOT/conf"

AC_PATH_MODULES="$AC_PATH_ROOT/modules"

AC_PATH_CUSTOM=$(readlink -f "$AC_PATH_ROOT/../azth_custom")

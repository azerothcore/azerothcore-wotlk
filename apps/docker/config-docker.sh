CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CTOOLS_BUILD=all

# allow the user to override configs
if [ -f  "$AC_PATH_CONF/config.sh" ]; then
    source "$AC_PATH_CONF/config.sh" # should overwrite previous
fi

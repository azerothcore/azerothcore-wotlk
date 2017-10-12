CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_PATH/../../bash_shared/includes.sh"

AC_PATH_INSTALLER="$AC_PATH_BIN/installer"

if [ -f "$AC_PATH_INSTALLER/config.sh"  ]; then
    source "$AC_PATH_INSTALLER/config.sh" # should overwrite previous
fi

source "$AC_PATH_BIN/compiler/includes/includes.sh"
source "$AC_PATH_BIN/db_assembler/includes/includes.sh"

source "$AC_PATH_INSTALLER/includes/functions.sh"

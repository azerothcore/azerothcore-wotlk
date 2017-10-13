CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_PATH/../../bash_shared/includes.sh"

AC_PATH_DBASSEMBLER="$AC_PATH_APPS/db_assembler"

if [ -f "$AC_PATH_DBASSEMBLER/config.sh"  ]; then
    source "$AC_PATH_DBASSEMBLER/config.sh" # should overwrite previous
fi

source "$AC_PATH_DBASSEMBLER/includes/functions.sh"

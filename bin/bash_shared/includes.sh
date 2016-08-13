AC_PATH_BIN="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"

AC_PATH_SHARED="$AC_PATH_BIN/bash_shared"

source "$AC_PATH_SHARED/defines.sh"

source "$AC_PATH_SHARED/functions.sh"

source "$AC_PATH_CONF/config.sh.dist" # "hack" to avoid missing conf variables

if [ -f "$AC_PATH_CONF/config.sh"  ]; then
    source "$AC_PATH_CONF/config.sh" # should overwrite previous
fi

#
# Load modules
#

for entry in "$AC_PATH_MODULES/"*/include.sh
do
    if [ -e $entry ]; then 
        source $entry
    fi
done

AZTH_PATH_BIN="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"

AZTH_PATH_SHARED="$AZTH_PATH_BIN/bash_shared"

source "$AZTH_PATH_SHARED/defines.sh"

source "$AZTH_PATH_SHARED/functions.sh"

source "$AZTH_PATH_CONF/config.sh.dist" # "hack" to avoid missing conf variables

if [ -f "$AZTH_PATH_CONF/config.sh"  ]; then
    source "$AZTH_PATH_CONF/config.sh" # should overwrite previous
fi

#
# Load modules
#

for entry in "$AZTH_PATH_MODULES/"*/include.sh
do
    if [ -e $entry ]; then 
        source $entry
    fi
done

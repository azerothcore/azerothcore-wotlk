# force default language for applications
LC_ALL=C 

AC_PATH_BIN="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"

AC_PATH_SHARED="$AC_PATH_BIN/bash_shared"

source "$AC_PATH_SHARED/defines.sh"

source "$AC_PATH_MODULES/hw-core/bash-lib-event/src/hooks.sh"


function registerHooks() { hwc_event_register_hooks "$@"; }
function runHooks() { hwc_event_run_hooks "$@"; }

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

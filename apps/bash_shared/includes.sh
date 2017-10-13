[[ ${GUARDYVAR:-} -eq 1 ]] && return || readonly GUARDYVAR=1 # include it once

# force default language for applications
LC_ALL=C 

AC_PATH_APPS="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"

AC_PATH_SHARED="$AC_PATH_APPS/bash_shared"

source "$AC_PATH_SHARED/defines.sh"

source "$AC_PATH_DEPS/hw-core/bash-lib-event/src/hooks.sh"


function registerHooks() { hwc_event_register_hooks "$@"; }
function runHooks() { hwc_event_run_hooks "$@"; }

source "$AC_PATH_CONF/config.sh.dist" # "hack" to avoid missing conf variables

if [ -f "$AC_PATH_CONF/config.sh"  ]; then
    source "$AC_PATH_CONF/config.sh" # should overwrite previous
else
    echo "NOTICE: file <$AC_PATH_CONF/config.sh> has not been found, you should create and configure it."
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

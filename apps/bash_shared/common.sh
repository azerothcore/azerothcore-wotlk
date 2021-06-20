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

ACORE_VERSION=$("$AC_PATH_DEPS/jsonpath/JSONPath.sh" -f $AC_PATH_ROOT/acore.json -b '$.version')
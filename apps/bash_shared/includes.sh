[[ ${GUARDYVAR:-} -eq 1 ]] && return || readonly GUARDYVAR=1 # include it once

# force default language for applications
LC_ALL=C

AC_PATH_APPS="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"

AC_PATH_SHARED="$AC_PATH_APPS/bash_shared"

# shellcheck source=./defines.sh
source "$AC_PATH_SHARED/defines.sh"

# shellcheck source=../../deps/acore/bash-lib/src/event/hooks.sh
source "$AC_PATH_DEPS/acore/bash-lib/src/event/hooks.sh"

# shellcheck source=./common.sh
source "$AC_PATH_SHARED/common.sh"

acore_common_loadConfig

if [[ "$OSTYPE" = "msys" ]]; then
    AC_BINPATH_FULL="$BINPATH"
else
    export AC_BINPATH_FULL="$BINPATH/bin"
fi

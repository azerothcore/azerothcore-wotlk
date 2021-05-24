[[ ${GUARDYVAR:-} -eq 1 ]] && return || readonly GUARDYVAR=1 # include it once

# force default language for applications
LC_ALL=C

AC_PATH_APPS="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"

AC_PATH_SHARED="$AC_PATH_APPS/bash_shared"

source "$AC_PATH_SHARED/defines.sh"

source "$AC_PATH_DEPS/acore/bash-lib/src/event/hooks.sh"

source "$AC_PATH_SHARED/common.sh"

source "$AC_PATH_SHARED/deno.sh"

source "$AC_PATH_SHARED/node.sh"

denoInstall

[[ "$OSTYPE" = "msys" ]] && AC_BINPATH_FULL="$BINPATH" || AC_BINPATH_FULL="$BINPATH/bin"


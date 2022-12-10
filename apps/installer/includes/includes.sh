[[ ${INSTALLER_GUARDYVAR:-} -eq 1 ]] && return || readonly INSTALLER_GUARDYVAR=1 # include it once

CURRENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd )

source "$CURRENT_PATH/../../bash_shared/includes.sh"

AC_PATH_INSTALLER="$AC_PATH_APPS/installer"

J_PATH="$AC_PATH_DEPS/acore/joiner"
J_PATH_MODULES="$AC_PATH_MODULES"

source "$J_PATH/joiner.sh"

if [ -f "$AC_PATH_INSTALLER/config.sh"  ]; then
    source "$AC_PATH_INSTALLER/config.sh" # should overwrite previous
fi

source "$AC_PATH_APPS/compiler/includes/includes.sh"

source "$AC_PATH_DEPS/semver_bash/semver.sh"

source "$AC_PATH_INSTALLER/includes/functions.sh"

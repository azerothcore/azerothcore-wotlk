[[ ${INSTALLER_GUARDYVAR:-} -eq 1 ]] && return || readonly INSTALLER_GUARDYVAR=1 # include it once

CURRENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd )

source "$CURRENT_PATH/../../bash_shared/includes.sh"

AC_PATH_INSTALLER="$AC_PATH_APPS/installer"


J_VER_REQ="v0.8.3"
J_PATH="$AC_PATH_APPS/joiner"
J_PATH_MODULES="$AC_PATH_MODULES"

#install/update and include joiner
if [ ! -d "$J_PATH/.git" ]; then
    git clone https://github.com/azerothcore/joiner "$J_PATH"  -b master
    git --git-dir="$J_PATH/.git/" --work-tree="$J_PATH/" reset --hard "$J_VER_REQ"
else
    # legacy code, with new rev of joiner the update process is internally handled
    _cur_branch=`git --git-dir="$J_PATH/.git/" --work-tree="$J_PATH/" rev-parse --abbrev-ref HEAD`
    _cur_ver=`git --git-dir="$J_PATH/.git/" --work-tree="$J_PATH/" name-rev --tags --name-only $_cur_branch`
    if [ "$_cur_ver" != "$J_VER_REQ" ]; then
        git --git-dir="$J_PATH/.git" --work-tree="$J_PATH/" rev-parse && git --git-dir="$J_PATH/.git" --work-tree="$J_PATH/" fetch --tags origin master --quiet
        git --git-dir="$J_PATH/.git/" --work-tree="$J_PATH/" reset --hard "$J_VER_REQ"
    fi
fi
source "$J_PATH/joiner.sh"

if [ -f "$AC_PATH_INSTALLER/config.sh"  ]; then
    source "$AC_PATH_INSTALLER/config.sh" # should overwrite previous
fi

source "$AC_PATH_APPS/compiler/includes/includes.sh"
source "$AC_PATH_APPS/db_assembler/includes/includes.sh"

source "$AC_PATH_DEPS/semver_bash/semver.sh"

source "$AC_PATH_INSTALLER/includes/functions.sh"

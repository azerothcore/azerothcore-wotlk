#!/usr/bin/env bash

cd /azerothcore

# TODO(michaeldelago) Get as close as we can to running `cmake` and `make`
# within the Dockerfile. We shouldn't have to jump out to another file to run
# the build. It's makes it difficult to follow

# The `functions.sh` file assumes that sudo is installed. We don't need to be
# running builds as root and it creates more problems than it solves.
function sudo () {
    $@
}

# Setting bash options for easier debugging and faster failure
# e          = exit on error
# u          = error on unset variable
# o pipefail = in a pipe, make sure the right side of the pipe is failed if the
#              left side is where the failure actually occurred
set -euo pipefail
# TODO(michaeldelago) Evaluate if these includes are necessary
# Import Config variables, mainly used in setting up the build
# Many of them are essentially passed in as variables to cmake

# Export all variables that need to be set
set -a
AC_PATH_ROOT="/azerothcore"
CTOOLS_BUILD="all"
AC_PATH_APPS="/azerothcore/apps"
AC_BINPATH_FULL="/azerothcore/env/dist/bin"
source /azerothcore/apps/bash_shared/defines.sh
source /azerothcore/deps/acore/bash-lib/src/event/hooks.sh
source /azerothcore/apps/bash_shared/common.sh
source /azerothcore/conf/dist/config.sh
set +a

# This file contains the actual shell function used to build AzerothCore
source /azerothcore/apps/compiler/includes/functions.sh

# Disable fast failure for the final build, there's some things in `comp_build`
# that fail
set +eu

comp_build

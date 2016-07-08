CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_PATH/../../bash_shared/includes.sh"

AZTH_PATH_COMPILER="$AZTH_PATH_BIN/compiler"

function azth_on_after_build() {
    # move the run engine
    cp -rvf "$AZTH_PATH_BIN/runners/"* "$INSTALL_PATH/bin/"
}

registerHooks "ON_AFTER_BUILD" azth_on_after_build

source "$AZTH_PATH_COMPILER/includes/defines.sh"

source "$AZTH_PATH_COMPILER/includes/functions.sh"

mkdir -p $BUILDPATH
mkdir -p $BINPATH

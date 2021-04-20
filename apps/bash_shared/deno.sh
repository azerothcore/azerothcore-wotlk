DENO_MIN_VERSION="1.7.4"

function denoInstall() {

    { # try
        echo "Deno version check:" && denoCmd upgrade --version $DENO_MIN_VERSION
    } ||
    { # catch
        echo "Installing Deno..."
        # just one line of command that works on all OSes
        # (temporary cd into AC_PATH_DEPS)
        curl -fsSL https://deno.land/x/install/install.sh | DENO_INSTALL="$AC_PATH_DEPS/deno" sh
    }
}

function denoCmd() {
    (cd "$AC_PATH_ROOT" ; ./deps/deno/bin/deno "$@")
}

function denoRunFile() {
    denoCmd run --allow-all --unstable "$@"
}

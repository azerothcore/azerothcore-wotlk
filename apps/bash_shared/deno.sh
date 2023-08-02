DENO_MIN_VERSION="1.26.0"

function denoInstall() {

    { # try
        echo "Deno version check:" && denoCmd upgrade --version $DENO_MIN_VERSION
    } ||
    { # catch
        echo "Installing Deno..."
        # just one line of command that works on all OSes
        # (temporary cd into AC_PATH_DEPS)
        curl -fsSL https://gist.githubusercontent.com/LukeChannings/09d53f5c364391042186518c8598b85e/raw/ac8cd8c675b985edd4b3e16df63ffef14d1f0e24/deno_install.sh | DENO_INSTALL="$AC_PATH_DEPS/deno" sh
    }
}

function denoCmd() {
    [[ "$OSTYPE" = "msys" ]] && DENOEXEC="./deps/deno/bin/deno.exe" || DENOEXEC="./deps/deno/bin/deno"
    (cd "$AC_PATH_ROOT" ; $DENOEXEC "$@")
}

function denoRunFile() {
    denoCmd run --allow-all --unstable "$@"
}

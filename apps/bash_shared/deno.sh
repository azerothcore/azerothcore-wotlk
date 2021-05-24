DENO_MIN_VERSION="1.9.1"

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
    [[ "$OSTYPE" = "msys" ]] && DENOEXEC="./deps/deno/bin/deno.exe" || DENOEXEC="./deps/deno/bin/deno"
    (cd "$AC_PATH_ROOT" ; $DENOEXEC "$@")
}

function denoRunFile() {
    denoCmd run --config "$AC_PATH_ROOT/tsconfig.json" --allow-all --unstable "$@"
}

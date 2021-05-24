source "$AC_PATH_DEPS/semver_bash/semver.sh"

NODE_MIN_VERSION="14"

# used by Eluna-TS

function nodeInstall() {

    local MAJOR=0
    local MINOR=0
    local PATCH=0
    local SPECIAL=""

    { # try
        echo "Node check:"
        NODE_VERSION=`node --version`

        echo "Current node version: $NODE_VERSION"

        semverParseInto $NODE_VERSION MAJOR MINOR PATCH SPECIAL

        if [[ $MAJOR -ne $NODE_MIN_VERSION ]]; then
            echo "Your NodeJS version $NODE_VERSION is not compatible with required version: $NODE_MIN_VERSION"
            ! [ "$MAJOR" -ne $NODE_MIN_VERSION ]
        fi
    } ||
    { # catch
        echo "Installing NodeJS..."
        # just one line of command that works on all OSes
        # (temporary cd into AC_PATH_DEPS)
        curl -sfLS https://install-node.vercel.app/14 | bash -s -- -f
    }
}


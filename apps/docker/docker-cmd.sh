#!/bin/bash

# TODO(michaeldelago) decide if we need a wrapper like this around docker
# commands.
#
# Running the docker commands should be simple and familiar.
# Introducting extra steps through the dashboard can cause issues with people
# getting started, especially if they already know docker.
#
# If a new user knows docker, they will feel (pretty close) to right at home.
# If a new user doesn't know docker, it's easy to learn and the knowledge
# applies to much more than azerothcore

set -euo pipefail

COMPOSE_DOCKER_CLI_BUILD="1"
DOCKER_BUILDKIT="1"
# BUILDKIT_INLINE_CACHE="1"

function usage () {
    cat <<EOF
Wrapper for shell scripts around docker

usage: $(basename $0) ACTION [ ACTION... ] [ ACTION_ARG... ]

actions:
EOF
# the `-s` will remove the "#" and properly space the action and description
    cat <<EOF | column -t -l2 -s'#'
> start:app             # Start the development worldserver and authserver
> start:app:d           # Start the development worldserver and authserver in detached mode
> build                 # build the development worldserver and authserver
> pull                  # pull the development worldserver and authserver
> build:nocache         # build the development worldserver and authserver without cache
> clean:build           # clean build artifacts from the dev server
> client-data           # download client data in the dev server
> dev:up start          # the dev server
> dev:build             # compile azerothcore using the dev server
> dev:dash              # execute the dashboard in the dev server container
> dev:shell [ ARGS... ] # open a bash shell in the dev server
> prod:build            # Build the service containers used by acore-docker
> prod:pull             # Pull the containers used by acore-docker
> prod:up               # Start the services used by acore-docker
> prod:up:d             # start the services used by acore-docker in the background
> attach SERVICE        # attach to a service currently running in docker compose
EOF
}

# If no args, just spit usage and exit
[[ $# -eq 0 ]] && usage && exit

# loop through commands passed
while [[ $# -gt 0 ]]; do
    case "$1" in
        start:app)
            set -x
            docker compose up
            set +x
            # pop the head off of the queue of args
            # After this, the value of $1 is the value of $2
            shift
            ;;

        start:app:d)
            set -x
            docker compose up -d
            set +x
            shift
            ;;

        build)
            set -x
            docker compose build
            set +x
            shift
            ;;

        pull)
            set -x
            docker compose pull
            set +x
            shift
            ;;

        build:nocache)
            set -x
            docker compose build --no-cache
            set +x
            shift
            ;;

        clean:build)
            set -x
            # Don't run 'docker buildx prune' since it may "escape" our bubble
            # and affect other projects on the user's workstation/server
            cat <<EOF
This command has been deprecated, and at the moment does not do anything.
If you'd like to build without cache, use the command './acore.sh docker build:nocache' or look into the 'docker buildx prune command'

> https://docs.docker.com/engine/reference/commandline/buildx_prune/
EOF
            set +x
            shift
            ;;

        client-data)
            set -x
            docker compose up ac-client-data-init
            set +x
            shift
            ;;

        dev:up)
            set -x
            docker compose --profile dev up ac-dev-server -d
            set +x
            shift
            ;;

        dev:build)
            set -x
            docker compose --profile dev run --rm ac-dev-server bash /azerothcore/acore.sh compiler build
            set +x
            shift
            ;;

        dev:dash)
            set -x
            docker compose --profile dev run --rm ac-dev-server bash /azerothcore/acore.sh ${@:2}
            set +x
            shift
            ;;

        dev:shell)
            set -x
            docker compose --profile dev up -d ac-dev-server
            docker compose --profile dev exec ac-dev-server bash ${@:2}
            set +x
            shift
            ;;

        build:prod|prod:build)
            cat <<EOF
This command is deprecated and is scheduled to be removed. Please update any scripts or automation accordingly to use the other command:

    ./acore.sh docker build

The build will continue in 3 seconds
EOF
            sleep 3
            set -x
            docker compose build
            set +x
            shift
            ;;

        pull:prod|prod:pull)
            cat <<EOF
This command is deprecated and is scheduled to be removed. Please update any scripts or automation accordingly to use the other command:

    ./acore.sh docker pull

The image pull will continue in 3 seconds
EOF
            sleep 3
            set -x
            docker compose pull
            set +x
            shift
            ;;

        prod:up|start:prod)
            cat <<EOF
This command is deprecated and is scheduled to be removed. Please update any scripts or automation accordingly to use the other command:

    ./acore.sh docker start:app

The containers will start in 3 seconds
EOF
            sleep 3
            set -x
            docker compose up
            set +x
            shift
            ;;

        prod:up:d|start:prod:d)
            cat <<EOF
This command is deprecated and is scheduled to be removed. Please update any scripts or automation accordingly to use the other command:

    ./acore.sh docker start:app:d

The containers will start in 3 seconds
EOF
            sleep 3
            set -x
            docker compose up -d
            set +x
            shift
            ;;

        attach)
            SERVICE="$2"
            set -x
            docker compose attach "$SERVICE"
            set +x
            shift
            shift # Second to pass the argument
            ;;

        *)
            echo "Unknown or empty arg"
            usage
            exit 1
    esac
done

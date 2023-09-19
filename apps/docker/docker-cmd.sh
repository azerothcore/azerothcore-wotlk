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
            docker compose --profile app up
            set +x
            # pop the head off of the queue of args
            # After this, the value of $1 is the value of $2
            shift
            ;;

        start:app:d)
            set -x
            docker compose --profile app up -d
            set +x
            shift
            ;;

        build)
            set -x
            docker compose --profile local --profile dev --profile dev-build build
            docker compose --profile dev-build run --rm --no-deps ac-dev-build /bin/bash /azerothcore/apps/docker/docker-build-dev.sh
            set +x
            shift
            ;;

        pull)
            set -x
            docker compose --profile local --profile dev --profile dev-build pull
            docker image prune -f
            set +x
            shift
            ;;

        build:nocache)
            set -x
            docker compose --profile local --profile dev --profile dev-build build --no-cache
            docker image prune -f
            docker compose run --rm --no-deps ac-dev-build /bin/bash /azerothcore/apps/docker/docker-build-dev.sh
            set +x
            shift
            ;;

        clean:build)
            set -x
            docker image prune -f
            docker compose run --rm --no-deps ac-dev-server bash acore.sh compiler clean
            docker compose run --rm --no-deps ac-dev-server bash acore.sh compiler ccacheClean
            set +x
            shift
            ;;

        client-data)
            set -x
            docker compose run --rm --no-deps ac-dev-server bash acore.sh client-data
            set +x
            shift
            ;;

        dev:up)
            set -x
            docker compose up -d ac-dev-server
            set +x
            shift
            ;;

        dev:build)
            set -x
            docker compose run --rm ac-dev-server bash acore.sh compiler build
            set +x
            shift
            ;;

        dev:dash)
            set -x
            docker compose run --rm ac-dev-server bash /azerothcore/acore.sh ${@:2}
            set +x
            shift
            ;;

        dev:shell)
            set -x
            docker compose up -d ac-dev-server
            docker compose exec ac-dev-server bash ${@:2}
            set +x
            shift
            ;;

        build:prod|prod:build)
            set -x
            docker compose --profile prod build
            docker image prune -f
            set +x
            shift
            ;;

        pull:prod|prod:pull)
            set -x
            docker compose --profile prod pull
            set +x
            shift
            ;;

        prod:up|start:prod)
            set -x
            docker compose --profile prod-app up
            set +x
            shift
            ;;

        prod:up:d|start:prod:d)
            set -x
            docker compose --profile prod-app up -d
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

#syntax=docker/dockerfile:1.2

#================================================================
#
# DEV: Stage used for the development environment
#      and the locally built services
#
#=================================================================

FROM ubuntu:20.04 as base
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG DOCKER_USER=acore

LABEL description="AC base image for dev containers"

# List of timezones: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

ENV DOCKER=1

# set timezone environment variable
ARG TZ=Etc/UTC
ENV TZ=$TZ

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

# TODO(michaeldelago) Cache these packages, and remove what we can.
RUN apt-get update && \
    apt-get install -y \
        gdb gdbserver git dos2unix lsb-core curl unzip \
        make cmake clang libmysqlclient-dev \
        libboost-system1.7*-dev libboost-filesystem1.7*-dev \
        libboost-program-options1.7*-dev libboost-iostreams1.7*-dev \
        build-essential libtool cmake-data openssl libgoogle-perftools-dev google-perftools \
        libssl-dev libmysql++-dev libreadline6-dev zlib1g-dev libbz2-dev mysql-client \
        libncurses5-dev ccache && \
    rm -rf /var/lib/apt/lists/*

# change timezone in container
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Create a non-root user
RUN addgroup --gid $GROUP_ID $DOCKER_USER && \
    adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $DOCKER_USER && \
    passwd -d $DOCKER_USER

# must be created to set the correct permissions on them
RUN mkdir -p \
        /azerothcore/env/dist/bin \
        /azerothcore/env/dist/data/Cameras \
        /azerothcore/env/dist/data/dbc \
        /azerothcore/env/dist/data/maps \
        /azerothcore/env/dist/data/mmaps \
        /azerothcore/env/dist/data/vmaps \
        /azerothcore/env/dist/logs \
        /azerothcore/env/dist/temp \
        /azerothcore/env/dist/etc \
        /azerothcore/var/build/obj

# Correct permissions for non-root operations
RUN chown -R $DOCKER_USER:$DOCKER_USER \
        /home/acore \
        /run \
        /opt \
        /azerothcore

USER $DOCKER_USER

# TODO(michaeldelago) evaluate if necessary. The dev container mounts the git repo so it
# shouldn't really need to copy everything in.
# copy only necessary files for the acore dashboard
COPY --chown=$DOCKER_USER:$DOCKER_USER apps /azerothcore/apps
COPY --chown=$DOCKER_USER:$DOCKER_USER bin /azerothcore/bin
COPY --chown=$DOCKER_USER:$DOCKER_USER conf /azerothcore/conf
# TODO(michaeldelago) remove this line especially. This copies in over 600MB of
# SQL files to the container, which is only necessary at runtime.
COPY --chown=$DOCKER_USER:$DOCKER_USER data /azerothcore/data
COPY --chown=$DOCKER_USER:$DOCKER_USER deps /azerothcore/deps
COPY --chown=$DOCKER_USER:$DOCKER_USER acore.json /azerothcore/acore.json
COPY --chown=$DOCKER_USER:$DOCKER_USER acore.sh /azerothcore/acore.sh

WORKDIR /azerothcore

#================================================================
#
# Dev: create dev server image
#
#=================================================================

FROM base as dev

LABEL description="AC dev image for dev containers"

USER $DOCKER_USER

# TODO(michaeldelago) re-evalutate if this is necessary. The dev server mounts it anyway, and
# despite lower comment this seems redundant

# copy everything so we can work directly within the container
# using tools such as vscode dev-container
# NOTE: this folder is different by the /azerothcore (which is binded instead)
COPY --chown=$DOCKER_USER:$DOCKER_USER . /azerothcore

# Needed if we use the dev image without linking any external folder (e.g. acore-docker)
COPY --chown=$DOCKER_USER:$DOCKER_USER env/docker/etc/authserver.conf.dockerdist /azerothcore/env/dist/etc/authserver.conf.dockerdist
COPY --chown=$DOCKER_USER:$DOCKER_USER env/docker/etc/worldserver.conf.dockerdist /azerothcore/env/dist/etc/worldserver.conf.dockerdist
COPY --chown=$DOCKER_USER:$DOCKER_USER env/docker/etc/dbimport.conf.dockerdist /azerothcore/env/dist/etc/dbimport.conf.dockerdist

# Ensure Git works
RUN git config --global --add safe.directory /azerothcore

#================================================================
#
# SERVICE BASE: prepare the OS for the production-ready services
#
#=================================================================

FROM ubuntu:20.04 as servicebase

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG DOCKER_USER=acore

LABEL description="AC service image for server applications"

# List of timezones: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

# set timezone environment variable
ARG TZ

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

# Create a non-root user
RUN addgroup --gid $GROUP_ID $DOCKER_USER && \
    adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $DOCKER_USER && \
    passwd -d $DOCKER_USER

# TODO(michaeldelago) Cache these packages
# install the required dependencies to run the server
RUN apt-get update && \
    apt-get install -y \
        dos2unix gdb gdbserver google-perftools libgoogle-perftools-dev net-tools \
        libboost-system1.71.0 libboost-filesystem1.71.0 \
        libboost-program-options1.71.0 libboost-iostreams1.71.0 \
        libboost-regex1.71.0 \
        tzdata curl unzip \
        # Both libmysqlclient and mysql-client are needed since the DB importer uses the
        # `mysql` binary
        mysql-client libmysqlclient-dev && \
    rm -rf /var/lib/apt/lists/* ;

# change timezone in container
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Correct permissions for non-root operations
RUN chown -R $DOCKER_USER:$DOCKER_USER \
        /home/acore \
        /run \
        /opt

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=base /azerothcore /azerothcore

USER $DOCKER_USER

# must be created to avoid permissions errors
RUN mkdir -p \
        /azerothcore/env/dist/data/Cameras \
        /azerothcore/env/dist/data/dbc \
        /azerothcore/env/dist/data/maps \
        /azerothcore/env/dist/data/mmaps \
        /azerothcore/env/dist/data/vmaps \
        /azerothcore/env/dist/logs \
        /azerothcore/env/dist/etc \
        /azerothcore/env/dist/bin && \
    chown -R "$USER_ID:$GROUP_ID" /azerothcore

WORKDIR /azerothcore/

#================================================================
#
# AUTH & WORLD local: images used for local services
# These images don't include binaries by default
#
#=================================================================

FROM servicebase as authserver-local

LABEL description="AC authserver image for local environment"

# TODO(michaeldelago) evaluate if we can use something like tini (widespread
# usage, built into docker) for service handling. Having a "restarter" such as
# this doesn't add anything to docker
CMD /azerothcore/apps/startup-scripts/simple-restarter \
        /azerothcore/env/dist/bin/authserver

USER $DOCKER_USER

FROM servicebase as worldserver-local

LABEL description="AC worldserver image for local environment"

# TODO(michaeldelago) evaluate if we can use something like tini (widespread
# usage, built into docker) for service handling. Having a "restarter" such as
# this doesn't add anything to docker
CMD /azerothcore/apps/startup-scripts/simple-restarter \
        /azerothcore/env/dist/bin/workdserver

USER $DOCKER_USER

#================================================================
#
# BUILD: compile sources
#
#=================================================================
FROM base as build

ARG DOCKER_USER=acore
USER $DOCKER_USER

LABEL description="AC Image used by the build stage to generate production images"

RUN mkdir -p /azerothcore/env/etc/

# .git is needed by the build system
COPY --chown=$DOCKER_USER:$DOCKER_USER ./.git /azerothcore/.git
COPY --chown=$DOCKER_USER:$DOCKER_USER ./CMakeLists.txt /azerothcore/CMakeLists.txt
COPY --chown=$DOCKER_USER:$DOCKER_USER ./deps /azerothcore/deps
COPY --chown=$DOCKER_USER:$DOCKER_USER ./src /azerothcore/src
COPY --chown=$DOCKER_USER:$DOCKER_USER ./modules /azerothcore/modules
COPY --chown=$DOCKER_USER:$DOCKER_USER var/docker/ccache /azerothcore/var/ccache
COPY --chown=$DOCKER_USER:$DOCKER_USER env/docker/etc/authserver.conf.dockerdist /azerothcore/env/dist/etc/authserver.conf.dockerdist
COPY --chown=$DOCKER_USER:$DOCKER_USER env/docker/etc/worldserver.conf.dockerdist /azerothcore/env/dist/etc/worldserver.conf.dockerdist
COPY --chown=$DOCKER_USER:$DOCKER_USER env/docker/etc/dbimport.conf.dockerdist /azerothcore/env/dist/etc/dbimport.conf.dockerdist

# install eluna
RUN git clone --depth=1 --branch=master \
    https://github.com/azerothcore/mod-eluna.git \
    /azerothcore/modules/mod-eluna

ARG BUILD_FORKS
ARG USER_CONF_PATH=/azerothcore/apps/docker/config-docker.sh
ARG CTYPE=RelWithDebInfo
ARG AC_CCACHE=true
ARG CCACHE_CPP2=true
ARG CSCRIPTPCH=OFF
ARG CCOREPCH=OFF
ARG CTOOLS_BUILD=all
ARG CSCRIPTS=static
ARG DEFAULT_CMAKE_OPTIONS="\
    -DCTYPE=$CTYPE -DAC_CCACHE=$AC_CCACHE \
    -DCCACHE_CPP2=$CCACHE_CPP2 -DCSCRIPTPCH=$CCACHE_CPP2 \
    -DCCOREPCH=$CCOREPCH -DCTOOLS_BUILD=$CTOOLS_BUILD -DCSCRIPTS=$CSCRIPTS"
ARG EXTRA_CMAKE_OPTIONS

# TODO(michaeldelago) don't copy in cache, mount it to a cache volume instead
RUN bash /azerothcore/apps/docker/docker-build-prod.sh

#================================================================
#
# AUTH SERVICE: create a ready-to-use authserver image
# with binaries included
#
#=================================================================
FROM authserver-local as authserver

LABEL description="AC Production: authserver"

ARG DOCKER_USER=acore
USER $DOCKER_USER

# TODO(michaeldelago) Evaluate the need for "production" and "dev" container
# build
COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build /azerothcore/env/dist/etc /azerothcore/env/dist/etc
COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build /azerothcore/env/dist/bin/authserver /azerothcore/env/dist/bin/authserver

#================================================================
#
# WORLD SERVICE: create a ready-to-use worldserver image
# with binaries and data included
#
#=================================================================
FROM worldserver-local as worldserver

LABEL description="AC Production: worldserver"

ARG DOCKER_USER=acore
USER $DOCKER_USER

# TODO(michaeldelago) Evaluate the need for "production" and "dev" container
# build
RUN mkdir -p /azerothcore/env/dist/bin/lua_scripts
COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build /azerothcore/env/dist/etc /azerothcore/env/dist/etc
COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build /azerothcore/env/dist/bin/worldserver /azerothcore/env/dist/bin/worldserver
COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build /azerothcore/env/dist/bin/lua_scripts /azerothcore/env/dist/bin/lua_scripts
COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build /azerothcore/env/dist/bin/dbimport /azerothcore/env/dist/bin/dbimport

#================================================================
#
# CLIENT DATA
#
#=================================================================

FROM ubuntu:20.04 as client-data

LABEL description="AC Production: client-data"

RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

COPY apps/installer/includes/functions.sh \
     /azerothcore/installer/includes/functions.sh

ENV DATAPATH="/azerothcore/env/dist/data"

ENTRYPOINT ["/bin/bash"]
CMD ["-c", "source /azerothcore/installer/includes/functions.sh && inst_download_client_data"]

#================================================================
#
# TOOLS
#
#=================================================================

FROM ubuntu:20.04 as tools
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG DOCKER_USER=acore

LABEL description="AC Production: tools"

# List of timezones: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

# set timezone environment variable
ARG TZ

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        libmysqlclient-dev libssl-dev libbz2-dev \
        libboost-system1.7*-dev libboost-filesystem1.7*-dev \
        libboost-program-options1.7*-dev libboost-iostreams1.7*-dev && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN addgroup --gid $GROUP_ID $DOCKER_USER && \
    adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $DOCKER_USER && \
    passwd -d $DOCKER_USER

RUN mkdir -p /azerothcore/env/client/ && \
    chown -R $DOCKER_USER:$DOCKER_USER /azerothcore

USER $DOCKER_USER

WORKDIR /azerothcore/env/client/

RUN mkdir -p \
    /azerothcore/env/client/Cameras \
    /azerothcore/env/client/dbc     \
    /azerothcore/env/client/maps    \
    /azerothcore/env/client/mmaps   \
    /azerothcore/env/client/vmaps

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build /azerothcore/env/dist/bin/map_extractor /azerothcore/env/client/map_extractor
COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build /azerothcore/env/dist/bin/mmaps_generator /azerothcore/env/client/mmaps_generator
COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build /azerothcore/env/dist/bin/vmap4_assembler /azerothcore/env/client/vmap4_assembler
COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build /azerothcore/env/dist/bin/vmap4_extractor /azerothcore/env/client/vmap4_extractor

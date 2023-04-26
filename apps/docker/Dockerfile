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
ENV TZ=Etc/UTC

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

# Do not use acore dashboard to install
# since it's not cacheable by docker
RUN apt-get update && apt-get install -y gdb gdbserver git dos2unix lsb-core sudo curl unzip \
  make cmake clang libmysqlclient-dev \
  libboost-system1.7*-dev libboost-filesystem1.7*-dev libboost-program-options1.7*-dev libboost-iostreams1.7*-dev \
  build-essential libtool cmake-data openssl libgoogle-perftools-dev google-perftools \
  libssl-dev libmysql++-dev libreadline6-dev zlib1g-dev libbz2-dev mysql-client \
  libncurses5-dev ccache \
  && rm -rf /var/lib/apt/lists/*

# change timezone in container
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

# Create a non-root user
RUN addgroup --gid $GROUP_ID acore && \
    adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID acore && \
    passwd -d acore && \
    echo 'acore ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

# must be created to set the correct permissions on them
RUN mkdir -p /azerothcore/env/dist/bin
RUN mkdir -p /azerothcore/env/dist/data/Cameras
RUN mkdir -p /azerothcore/env/dist/data/dbc
RUN mkdir -p /azerothcore/env/dist/data/maps
RUN mkdir -p /azerothcore/env/dist/data/mmaps
RUN mkdir -p /azerothcore/env/dist/data/vmaps
RUN mkdir -p /azerothcore/env/dist/logs
RUN mkdir -p /azerothcore/env/dist/temp
RUN mkdir -p /azerothcore/env/dist/etc
RUN mkdir -p /azerothcore/var/build/obj

# Correct permissions for non-root operations
RUN chown -R $DOCKER_USER:$DOCKER_USER /home/acore
RUN chown -R $DOCKER_USER:$DOCKER_USER /run
RUN chown -R $DOCKER_USER:$DOCKER_USER /opt
RUN chown -R $DOCKER_USER:$DOCKER_USER /azerothcore

USER $DOCKER_USER

# copy only necessary files for the acore dashboard
COPY --chown=$DOCKER_USER:$DOCKER_USER apps /azerothcore/apps
COPY --chown=$DOCKER_USER:$DOCKER_USER bin /azerothcore/bin
COPY --chown=$DOCKER_USER:$DOCKER_USER conf /azerothcore/conf
COPY --chown=$DOCKER_USER:$DOCKER_USER data /azerothcore/data
COPY --chown=$DOCKER_USER:$DOCKER_USER deps /azerothcore/deps
COPY --chown=$DOCKER_USER:$DOCKER_USER acore.json /azerothcore/acore.json
COPY --chown=$DOCKER_USER:$DOCKER_USER acore.sh /azerothcore/acore.sh

# Download deno and make sure the dashboard works
RUN bash /azerothcore/acore.sh quit

WORKDIR /azerothcore

#================================================================
#
# Dev: create dev server image
#
#=================================================================

FROM base as dev

LABEL description="AC dev image for dev containers"

USER $DOCKER_USER

# copy everything so we can work directly within the container
# using tools such as vscode dev-container
# NOTE: this folder is different by the /azerothcore (which is binded instead)
COPY --chown=$DOCKER_USER:$DOCKER_USER . /azerothcore

# Needed if we use the dev image without linking any external folder (e.g. acore-docker)
COPY --chown=$DOCKER_USER:$DOCKER_USER env/docker/etc/authserver.conf.dockerdist /azerothcore/env/dist/etc/authserver.conf.dockerdist
COPY --chown=$DOCKER_USER:$DOCKER_USER env/docker/etc/worldserver.conf.dockerdist /azerothcore/env/dist/etc/worldserver.conf.dockerdist
COPY --chown=$DOCKER_USER:$DOCKER_USER env/docker/etc/dbimport.conf.dockerdist /azerothcore/env/dist/etc/dbimport.conf.dockerdist

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
ENV TZ=Etc/UTC

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

# Create a non-root user
RUN addgroup --gid $GROUP_ID acore && \
    adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID acore && \
    passwd -d acore && \
    echo 'acore ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

# install the required dependencies to run the server
RUN apt-get update && apt-get install -y dos2unix gdb gdbserver google-perftools libgoogle-perftools-dev net-tools \
    libboost-system1.7*-dev libboost-filesystem1.7*-dev libboost-program-options1.7*-dev libboost-iostreams1.7*-dev \
    tzdata libmysqlclient-dev mysql-client curl unzip && rm -rf /var/lib/apt/lists/* ;

# change timezone in container
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

# Correct permissions for non-root operations
RUN chown -R $DOCKER_USER:$DOCKER_USER /home/acore
RUN chown -R $DOCKER_USER:$DOCKER_USER /run
RUN chown -R $DOCKER_USER:$DOCKER_USER /opt

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=base /azerothcore /azerothcore

USER $DOCKER_USER

# must be created to avoid permissions errors
RUN mkdir -p /azerothcore/env/dist/data/Cameras
RUN mkdir -p /azerothcore/env/dist/data/dbc
RUN mkdir -p /azerothcore/env/dist/data/maps
RUN mkdir -p /azerothcore/env/dist/data/mmaps
RUN mkdir -p /azerothcore/env/dist/data/vmaps
RUN mkdir -p /azerothcore/env/dist/logs
RUN mkdir -p /azerothcore/env/dist/etc
RUN mkdir -p /azerothcore/env/dist/bin

# Download deno and make sure the dashboard works
RUN bash /azerothcore/acore.sh quit

WORKDIR /azerothcore/

#================================================================
#
# AUTH & WORLD local: images used for local services
# These images don't include binaries by default
#
#=================================================================

FROM servicebase as authserver-local

LABEL description="AC authserver image for local environment"

CMD ./acore.sh run-authserver

USER $DOCKER_USER

FROM servicebase as worldserver-local

LABEL description="AC worldserver image for local environment"

CMD ./acore.sh run-worldserver

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

# .git is needed by the compiler
COPY --chown=$DOCKER_USER:$DOCKER_USER ./.git /azerothcore/.git
COPY --chown=$DOCKER_USER:$DOCKER_USER ./CMakeLists.txt /azerothcore/CMakeLists.txt
COPY --chown=$DOCKER_USER:$DOCKER_USER ./deps /azerothcore/deps
COPY --chown=$DOCKER_USER:$DOCKER_USER ./src /azerothcore/src
COPY --chown=$DOCKER_USER:$DOCKER_USER ./modules /azerothcore/modules
# check if we have ccache files available outside
RUN rm -rf /azerothcore/var/ccache/*
COPY --chown=$DOCKER_USER:$DOCKER_USER var/docker/ccache /azerothcore/var/ccache
COPY --chown=$DOCKER_USER:$DOCKER_USER env/docker/etc/authserver.conf.dockerdist /azerothcore/env/dist/etc/authserver.conf.dockerdist
COPY --chown=$DOCKER_USER:$DOCKER_USER env/docker/etc/worldserver.conf.dockerdist /azerothcore/env/dist/etc/worldserver.conf.dockerdist
COPY --chown=$DOCKER_USER:$DOCKER_USER env/docker/etc/dbimport.conf.dockerdist /azerothcore/env/dist/etc/dbimport.conf.dockerdist

# install eluna
RUN git clone --depth=1 --branch=master https://github.com/azerothcore/mod-eluna.git /azerothcore/modules/mod-eluna

ENV USER_CONF_PATH=/azerothcore/apps/docker/config-docker.sh
ENV CTYPE=RelWithDebInfo
ENV AC_CCACHE=true
ENV CCACHE_CPP2=true
ENV CSCRIPTPCH=OFF
ENV CCOREPCH=OFF
ENV CTOOLS_BUILD=all
# ENV CTOOLS_BUILD=maps-only
ENV CSCRIPTS=static
RUN bash apps/docker/docker-build-prod.sh

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
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG DOCKER_USER=acore

LABEL description="AC Production: client-data"

RUN apt-get update && apt-get install -y tzdata curl unzip && rm -rf /var/lib/apt/lists/* ;

# set timezone environment variable
ENV TZ=Etc/UTC

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

RUN addgroup --gid $GROUP_ID acore && \
    adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID acore && \
    passwd -d acore && \
    echo 'acore ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

# ENV DATAPATH=/azerothcore/env/dist/data-temp
ENV DATAPATH=/azerothcore/env/dist/data
ENV DATAPATH_ZIP=/tmp/data.zip

RUN mkdir -p "$DATAPATH"
ARG CACHEBUST=1
# RUN --mount=type=bind,target=/azerothcore-temp,readwrite --mount=type=cache,target=/azerothcore/env/dist/data-temp /azerothcore-temp/acore.sh client-data && cp -rT /azerothcore/env/dist/data-temp/ /azerothcore/env/dist/data && chown -R $DOCKER_USER:$DOCKER_USER /azerothcore
RUN --mount=type=bind,target=/azerothcore-temp,readwrite /azerothcore-temp/acore.sh client-data && chown -R $DOCKER_USER:$DOCKER_USER /azerothcore

USER $DOCKER_USER

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
ENV TZ=Etc/UTC

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y libmysqlclient-dev libssl-dev libbz2-dev \
    libboost-system1.7*-dev libboost-filesystem1.7*-dev libboost-program-options1.7*-dev libboost-iostreams1.7*-dev \
    sudo && rm -rf /var/lib/apt/lists/* ;

# Create a non-root user
RUN addgroup --gid $GROUP_ID acore && \
    adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID acore && \
    passwd -d acore && \
    echo 'acore ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

RUN mkdir -p /azerothcore/env/client/
RUN chown -R $DOCKER_USER:$DOCKER_USER /azerothcore

USER $DOCKER_USER

WORKDIR /azerothcore/env/client/

RUN mkdir -p /azerothcore/env/client/Cameras
RUN mkdir -p /azerothcore/env/client/dbc
RUN mkdir -p /azerothcore/env/client/maps
RUN mkdir -p /azerothcore/env/client/mmaps
RUN mkdir -p /azerothcore/env/client/vmaps

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build /azerothcore/env/dist/bin/map_extractor /azerothcore/env/client/map_extractor
COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build /azerothcore/env/dist/bin/mmaps_generator /azerothcore/env/client/mmaps_generator
COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build /azerothcore/env/dist/bin/vmap4_assembler /azerothcore/env/client/vmap4_assembler
COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build /azerothcore/env/dist/bin/vmap4_extractor /azerothcore/env/client/vmap4_extractor


# syntax=docker/dockerfile:1-labs

ARG TZ=Etc/UTC
ARG UBUNTU_VERSION=22.04

# Create Directory tree
FROM ubuntu:$UBUNTU_VERSION as skeleton

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG DOCKER_USER=acore
ARG INSTALLER_GUARDYVAR=1

ENV DEBIAN_FRONTEND=noninteractive
ENV DOCKER=true
ENV TZ=$TZ
ENV AC_FORCE_CREATE_DB=1

WORKDIR /azerothcore

RUN mkdir -pv /azerothcore/apps                  \
              /azerothcore/bin                   \
              /azerothcore/conf                  \
              /azerothcore/data                  \
              /azerothcore/deps                  \
              /azerothcore/env                   \
              /azerothcore/modules               \
              /azerothcore/src                   \
              /azerothcore/var                   \
              /azerothcore/apps/bash_shared      \
              /azerothcore/apps/docker           \
              /azerothcore/apps/startup-scripts  \
              /azerothcore/env/dist/bin          \
              /azerothcore/env/dist/data/Cameras \
              /azerothcore/env/dist/data/dbc     \
              /azerothcore/env/dist/data/maps    \
              /azerothcore/env/dist/data/mmaps   \
              /azerothcore/env/dist/data/vmaps   \
              /azerothcore/env/dist/logs         \
              /azerothcore/env/dist/temp         \
              /azerothcore/env/dist/etc          \
              /azerothcore/env/etc               \
              /azerothcore/var/build/obj         \
              /azerothcore/var/ccache

# configure timezone
RUN apt update && \
    apt install -y tzdata ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Create the acore user and set their homedir to /azerothcore
RUN groupadd --gid "$GROUP_ID"  "$DOCKER_USER" && \
    useradd -d /azerothcore --uid "$USER_ID"  --gid "$GROUP_ID"  "$DOCKER_USER" && \
    passwd -d "$DOCKER_USER" && \
    chown -R "$DOCKER_USER:$DOCKER_USER" /azerothcore

# Build Applications

FROM skeleton as build

ARG CTOOLS_BUILD=all
ARG USER_CONF_PATH=/azerothcore/apps/docker/config-docker.sh
ARG CTYPE=RelWithDebInfo
ARG AC_CCACHE=true
ARG CCACHE_CPP2=true
ARG CSCRIPTPCH=OFF
ARG CCOREPCH=OFF
ARG CSCRIPTS=static
ARG CSCRIPTS_DEFAULT_LINKAGE=static
ARG CMODULES=static

# Install the Eluna Lua scripting engine
ARG INSTALL_ELUNA=true

WORKDIR /azerothcore

# This is a lot of large packages to download
RUN --mount=target=/var/cache/apt,type=cache,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean && \
    apt update && \
    apt install -y --no-install-recommends \
      # Build tools
      git lsb-core curl unzip sudo make cmake clang  mysql-client\
      build-essential ccache libtool cmake-data openssl \
      # source libraries
      libmysqlclient-dev libboost-system-dev libboost-filesystem-dev \
      libboost-program-options-dev libboost-iostreams-dev \
      libssl-dev libmysql++-dev libreadline-dev zlib1g-dev \
      libbz2-dev libncurses5-dev && \
    rm -rf /var/lib/apt/lists/*

# see .dockerignore to see what isn't being blocked in.
# main things NOT bringing brought in are
# - /.git
# - /apps, except for the few necessary sections
# - /build*
# - /data
# - /deps/deno
# - /env/dist
# - /env/user
# - /env/docker/logs
# - /env/docker/data
# - /env/**/bin
# - /var
COPY . .

# Copy configs into env/dist. Config generation scripts make assumptions that they will be in this dir
COPY env/docker env/dist

RUN if [ "$INSTALL_ELUNA" = "true" ]; then \
    git clone \
      --depth=1 \
      --branch=master \
      https://github.com/azerothcore/mod-eluna.git \
      modules/mod-eluna; \
    fi

# Force re-run the build without removing docker cache with this build arg
# --build-arg CACHEBUST=$(date +%s)
ARG CACHEBUST=1

# As
RUN --mount=type=cache,target=/azerothcore/var/ \
    git config --global --add safe.directory /azerothcore && \
    DOCKER=1 bash apps/compiler/compiler.sh build

#############################
# Base runtime for services #
#############################

FROM skeleton as runtime

ENV ACORE_COMPONENT=undefined

# Install base dependencies for azerothcore
RUN apt update && \
    apt install -y --no-install-recommends \
      libmysqlclient21 libreadline8 \
      gettext-base expect mysql-client && \
    rm -rf /var/lib/apt/lists/*

COPY apps/docker/entrypoint.sh /entrypoint.sh
COPY acore.json acore.json

RUN chmod -v +x /entrypoint.sh

# Create a separate dir with the configs.
# The entrypoint will move these to env/dist/etc and template them with env variables
COPY --from=build /azerothcore/env/dist/etc/ /azerothcore/env/ref/etc/

VOLUME /azerothcore/env/dist/etc

RUN chown -R $DOCKER_USER:$DOCKER_USER \
      /azerothcore \
      /run \
      /opt

ENV PATH="/azerothcore/env/dist/bin:$PATH"

USER $DOCKER_USER

ENTRYPOINT ["/entrypoint.sh"]

###############
# Auth Server #
###############

FROM runtime as authserver
LABEL description "AzerothCore Auth Server"

ENV ACORE_COMPONENT=authserver

COPY --chown=$DOCKER_USER:$DOCKER_USER \
     --from=build \
     /azerothcore/env/dist/bin/authserver /azerothcore/env/dist/bin/authserver


CMD ["/azerothcore/env/dist/bin/authserver"]

################
# World Server #
################

FROM runtime as worldserver

LABEL description "AzerothCore World Server"

ENV ACORE_COMPONENT=worldserver

COPY --chown=$DOCKER_USER:$DOCKER_USER \
     apps/docker/worldserver.exp /azerothcore/worldserver.exp

COPY --chown=$DOCKER_USER:$DOCKER_USER \
     --from=build \
     /azerothcore/env/dist/bin/worldserver /azerothcore/env/dist/bin/worldserver

VOLUME /azerothcore/env/dist/etc

CMD ["/azerothcore/env/dist/bin/worldserver"]

##################
# Map Extractors #
##################

FROM runtime as tools

LABEL description "AzerothCore Tools"

WORKDIR /azerothcore/env/client/

RUN mkdir -pv /azerothcore/env/client/Cameras \
              /azerothcore/env/client/dbc     \
              /azerothcore/env/client/maps    \
              /azerothcore/env/client/mmaps   \
              /azerothcore/env/client/vmaps

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build \
  /azerothcore/env/dist/bin/map_extractor /azerothcore/env/client/map_extractor

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build \
  /azerothcore/env/dist/bin/mmaps_generator /azerothcore/env/client/mmaps_generator

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build \
  /azerothcore/env/dist/bin/vmap4_assembler /azerothcore/env/client/vmap4_assembler

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build \
  /azerothcore/env/dist/bin/vmap4_extractor /azerothcore/env/client/vmap4_extractor

###############
# Client Data #
###############

FROM skeleton as client-data

LABEL description="AzerothCore client-data"

ENV DATAPATH=/azerothcore/env/dist/data

RUN apt update && \
    apt install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

COPY --chown=$DOCKER_USER:$DOCKER_USER apps apps

VOLUME /azerothcore/env/dist/data

USER $DOCKER_USER

CMD bash -c "source /azerothcore/apps/installer/includes/functions.sh && inst_download_client_data"

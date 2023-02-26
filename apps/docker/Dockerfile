# syntax=docker/dockerfile:1-labs

ARG TZ=Etc/UTC
ARG UBUNTU_VERSION=20.04

# Create Directory tree
FROM ubuntu:$UBUNTU_VERSION as skeleton

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG DOCKER_USER=acore

ENV DEBIAN_FRONTEND=noninteractive

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

RUN apt update && \
    apt install -y tzdata ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd --gid "$GROUP_ID"  "$DOCKER_USER" && \
    useradd -d /azerothcore --uid "$USER_ID"  --gid "$GROUP_ID"  "$DOCKER_USER" && \
    passwd -d "$DOCKER_USER" && \
    chown -R "$DOCKER_USER:$DOCKER_USER" /azerothcore

# Build Applications

FROM skeleton as build

ARG TZ
ARG CTOOLS_BUILD=all
ARG INSTALL_ELUNA=true


ENV TZ=$TZ
ENV DEBIAN_FRONTEND=noninteractive
ARG SKIP_INSTALL_DENO=true

ENV USER_CONF_PATH=/azerothcore/apps/docker/config-docker.sh
ENV CTYPE=RelWithDebInfo
ENV AC_CCACHE=true
ENV CCACHE_CPP2=true
ENV CSCRIPTPCH=OFF
ENV CCOREPCH=OFF
ENV CTOOLS_BUILD=$CTOOLS_BUILD
ENV CSCRIPTS=static
ENV CSCRIPTS_DEFAULT_LINKAGE=static
ENV CMODULES=static

WORKDIR /azerothcore

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

# This is a lot of packages to download
# We're going to benefit from caching apt packages
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean && \
    apt update && \
    apt install -y --no-install-recommends \
      git lsb-core curl unzip sudo \
      make cmake clang libmysqlclient-dev \
      libboost-system-dev libboost-filesystem-dev \
      libboost-program-options-dev libboost-iostreams-dev \
      build-essential libtool cmake-data openssl \
      libssl-dev libmysql++-dev libreadline-dev zlib1g-dev \
      libbz2-dev mysql-client \
      libncurses5-dev ccache && \
    rm -rf /var/lib/apt/lists/*

COPY . .
COPY env/docker env/dist

RUN if [ "$INSTALL_ELUNA" = "true" ]; then \
    git clone \
      --depth=1 \
      --branch=master \
      https://github.com/azerothcore/mod-eluna.git \
      modules/mod-eluna; \
    fi

ARG CACHEBUST=1

RUN --mount=type=cache,target=/azerothcore/var/ \
    git config --global --add safe.directory /azerothcore && \
    DOCKER=1 bash apps/compiler/compiler.sh build

#############################
# Base runtime for services #
#############################

FROM skeleton as runtime

ARG TZ Etc/UTC

ENV TZ $TZ
ENV DEBIAN_FRONTEND=noninteractive
ENV ACORE_COMPONENT=undefined
ENV DOCKER=1

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN apt update && \
    apt install -y \ 
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

#############
# DB Import #
#############

FROM runtime as dbimport

LABEL description "AzerothCore Database Import tool"

USER $DOCKER_USER

ENV ACORE_COMPONENT=dbimport

COPY --chown=$DOCKER_USER:$DOCKER_USER\
     --from=build \
     /azerothcore/env/dist/bin/dbimport /azerothcore/env/dist/bin/dbimport

VOLUME /azerothcore/env/dist/etc

CMD /azerothcore/env/dist/bin/dbimport

###############
# Client Data #
###############

FROM skeleton as client-data

LABEL description="AzerothCore client-data"

RUN apt update && \
    apt install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

COPY --chown=$DOCKER_USER:$DOCKER_USER apps apps

COPY --chown=$DOCKER_USER:$DOCKER_USER \
  apps/docker/client-data.sh /azerothcore/apps/docker/client-data.sh

RUN chmod +x /azerothcore/apps/docker/client-data.sh

VOLUME /azerothcore/env/dist/data

USER $DOCKER_USER

CMD /azerothcore/apps/docker/client-data.sh 

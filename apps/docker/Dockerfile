ARG UBUNTU_VERSION=22.04 # lts
ARG TZ=Etc/UTC

# This target lays out the general directory skeleton for AzerothCore,
# This target isn't intended to be directly used
FROM ubuntu:$UBUNTU_VERSION as skeleton

ARG DOCKER=1
ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=$TZ
ENV AC_FORCE_CREATE_DB=1

RUN mkdir -pv \
        /azerothcore/bin                   \
        /azerothcore/data                  \
        /azerothcore/deps                  \
        /azerothcore/env/dist/bin          \
        /azerothcore/env/dist/data/Cameras \
        /azerothcore/env/dist/data/dbc     \
        /azerothcore/env/dist/data/maps    \
        /azerothcore/env/dist/data/mmaps   \
        /azerothcore/env/dist/data/vmaps   \
        /azerothcore/env/dist/logs         \
        /azerothcore/env/dist/temp         \
        /azerothcore/env/dist/etc          \
        /azerothcore/modules               \
        /azerothcore/src                   \
        /azerothcore/build

ENV DOCKER=1

# Ensure ac-dev-server can properly pull versions
ENV GIT_DISCOVERY_ACROSS_FILESYSTEM=1

# set timezone environment variable
ENV TZ=Etc/UTC

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

# Do not use acore dashboard to install
# since it's not cacheable by docker
RUN apt-get update && apt-get install -y gdb gdbserver git dos2unix lsb-core sudo curl unzip \
  make cmake clang libmysqlclient-dev \
  libboost-system1.7*-dev libboost-filesystem1.7*-dev libboost-program-options1.7*-dev libboost-iostreams1.7*-dev libboost-thread1.7*-dev \
  build-essential libtool cmake-data openssl libgoogle-perftools-dev google-perftools \
  libssl-dev libmysql++-dev libreadline6-dev zlib1g-dev libbz2-dev mysql-client \
  libncurses5-dev ccache \
  && rm -rf /var/lib/apt/lists/*

# Ensure git will work with the AzerothCore source directory
RUN git config --global --add safe.directory /azerothcore

# change timezone in container
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

# Create a non-root user
RUN addgroup --gid "$GROUP_ID" "$DOCKER_USER" && \
    adduser --disabled-password --gecos '' --uid "$USER_ID" --gid "$GROUP_ID" "$DOCKER_USER" && \
    passwd -d "$DOCKER_USER" && \
    echo "$DOCKER_USER ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

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

# This target builds the docker image
# This target can be useful to inspect the explicit outputs from the build,
FROM skeleton as build

ARG CTOOLS_BUILD="all"
ARG CTYPE="RelWithDebInfo"
ARG CCACHE_CPP2="true"
ARG CSCRIPTPCH="OFF"
ARG CSCRIPTS="static"
ARG CMODULES="static"
ARG CSCRIPTS_DEFAULT_LINKAGE="static"
ARG CWITH_WARNINGS="ON"
ARG CMAKE_EXTRA_OPTIONS=""
ARG GIT_DISCOVERY_ACROSS_FILESYSTEM=1

ARG CCACHE_DIR="/ccache"
ARG CCACHE_MAXSIZE="1000MB"
ARG CCACHE_SLOPPINESS="pch_defines,time_macros,include_file_mtime"
ARG CCACHE_COMPRESS=""
ARG CCACHE_COMPRESSLEVEL="9"
ARG CCACHE_COMPILERCHECK="content"
ARG CCACHE_LOGFILE=""

RUN apt-get update                                                     \
    && apt-get install -y --no-install-recommends                         \
        build-essential ccache libtool cmake-data make cmake clang    \
        git lsb-base curl unzip default-mysql-client openssl                  \
        default-libmysqlclient-dev libboost-all-dev libssl-dev libmysql++-dev \
        libreadline-dev zlib1g-dev libbz2-dev libncurses5-dev         \
    && rm -rf /var/lib/apt/lists/*

COPY CMakeLists.txt /azerothcore/CMakeLists.txt
COPY conf /azerothcore/conf
COPY deps /azerothcore/deps
COPY src /azerothcore/src
COPY modules /azerothcore/modules

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
RUN addgroup --gid "$GROUP_ID" "$DOCKER_USER" && \
    adduser --disabled-password --gecos '' --uid "$USER_ID" --gid "$GROUP_ID" "$DOCKER_USER" && \
    passwd -d "$DOCKER_USER" && \
    echo "$DOCKER_USER ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

# install the required dependencies to run the server
RUN apt-get update && apt-get install -y dos2unix gdb gdbserver google-perftools libgoogle-perftools-dev net-tools \
    libboost-system1.7*-dev libboost-filesystem1.7*-dev libboost-program-options1.7*-dev libboost-iostreams1.7*-dev libboost-thread1.7*-dev \
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

RUN addgroup --gid "$GROUP_ID" "$DOCKER_USER" && \
    adduser --disabled-password --gecos '' --uid "$USER_ID" --gid "$GROUP_ID" "$DOCKER_USER" && \
    passwd -d "$DOCKER_USER" && \
    echo "$DOCKER_USER ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

# ENV DATAPATH=/azerothcore/env/dist/data-temp
ENV DATAPATH=/azerothcore/env/dist/data
ENV DATAPATH_ZIP=/tmp/data.zip

RUN mkdir -p "$DATAPATH"
ARG CACHEBUST=1

WORKDIR /azerothcore/build

RUN --mount=type=cache,target=/ccache,sharing=locked \
    # This may seem silly (and it is), but AzerothCore wants the git repo at
    # build time. The git repo is _huge_ and it's not something that really
    # makes sense to mount into the container, but this way we can let the build
    # have the information it needs without including the hundreds of megabytes
    # of git repo into the container.
    --mount=type=bind,target=/azerothcore/.git,source=.git \
    git config --global --add safe.directory /azerothcore \
    && cmake /azerothcore \
       -DCMAKE_INSTALL_PREFIX="/azerothcore/env/dist"  \
       -DAPPS_BUILD="all"                              \
       -DTOOLS_BUILD="$CTOOLS_BUILD"                   \
       -DSCRIPTS="$CSCRIPTS"                           \
       -DMODULES="$CMODULES"                           \
       -DWITH_WARNINGS="$CWITH_WARNINGS"               \
       -DCMAKE_BUILD_TYPE="$CTYPE"                     \
       -DCMAKE_CXX_COMPILER="clang++"                  \
       -DCMAKE_C_COMPILER="clang"                      \
       -DCMAKE_CXX_COMPILER_LAUNCHER="ccache"          \
       -DCMAKE_C_COMPILER_LAUNCHER="ccache"            \
       -DBoost_USE_STATIC_LIBS="ON"                    \
    && cmake --build . --config "$CTYPE" -j $(($(nproc) + 1)) \
    && cmake --install . --config "$CTYPE"

#############################
# Base runtime for services #
#############################

FROM skeleton as runtime

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG DOCKER_USER=acore

ENV ACORE_COMPONENT=undefined

# Install base dependencies for azerothcore
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libmysqlclient21 libreadline8 \
      gettext-base default-mysql-client && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /azerothcore/env/dist/etc/ /azerothcore/env/ref/etc

VOLUME /azerothcore/env/dist/etc

RUN apt-get update && apt-get install -y libmysqlclient-dev libssl-dev libbz2-dev \
    libboost-system1.7*-dev libboost-filesystem1.7*-dev libboost-program-options1.7*-dev libboost-iostreams1.7*-dev libboost-thread1.7*-dev \
    sudo && rm -rf /var/lib/apt/lists/* ;

RUN groupadd --gid "$GROUP_ID"  "$DOCKER_USER" && \
    useradd -d /azerothcore --uid "$USER_ID"  --gid "$GROUP_ID"  "$DOCKER_USER" && \
    passwd -d "$DOCKER_USER" && \
    chown -R "$DOCKER_USER:$DOCKER_USER" /azerothcore

COPY --chown=$USER_ID:$GROUP_ID \
     --chmod=755 \
     apps/docker/entrypoint.sh /azerothcore/entrypoint.sh

USER $DOCKER_USER

ENTRYPOINT ["/usr/bin/env", "bash", "/azerothcore/entrypoint.sh"]

###############
# Auth Server #
###############

FROM runtime as authserver
LABEL description "AzerothCore Auth Server"

ENV ACORE_COMPONENT=authserver
# Don't run database migrations. We can leave that up to the db-import container
ENV AC_UPDATES_ENABLE_DATABASES=0
# This disables user prompts. The console is still active, however
ENV AC_DISABLE_INTERACTIVE=1
ENV AC_CLOSE_IDLE_CONNECTIONS=0

COPY --chown=$DOCKER_USER:$DOCKER_USER \
     --from=build \
     /azerothcore/env/dist/bin/authserver /azerothcore/env/dist/bin/authserver


CMD ["authserver"]

################
# World Server #
################

FROM runtime as worldserver

LABEL description "AzerothCore World Server"

ENV ACORE_COMPONENT=worldserver
# Don't run database migrations. We can leave that up to the db-import container
ENV AC_UPDATES_ENABLE_DATABASES=0
# This disables user prompts. The console is still active, however
ENV AC_DISABLE_INTERACTIVE=1
ENV AC_CLOSE_IDLE_CONNECTIONS=0

COPY --chown=$DOCKER_USER:$DOCKER_USER \
     --from=build \
     /azerothcore/env/dist/bin/worldserver /azerothcore/env/dist/bin/worldserver

VOLUME /azerothcore/env/dist/etc

CMD ["worldserver"]

#############
# DB Import #
#############

FROM runtime as db-import

LABEL description "AzerothCore Database Import tool"

USER $DOCKER_USER

ENV ACORE_COMPONENT=dbimport

COPY --chown=$DOCKER_USER:$DOCKER_USER \
    data data

COPY --chown=$DOCKER_USER:$DOCKER_USER\
     --from=build \
     /azerothcore/env/dist/bin/dbimport /azerothcore/env/dist/bin/dbimport

CMD /azerothcore/env/dist/bin/dbimport

###############
# Client Data #
###############

FROM skeleton as client-data

LABEL description="AzerothCore client-data"

ENV DATAPATH=/azerothcore/env/dist/data

RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

COPY --chown=$DOCKER_USER:$DOCKER_USER apps apps

VOLUME /azerothcore/env/dist/data

USER $DOCKER_USER

CMD bash -c "source /azerothcore/apps/installer/includes/functions.sh && inst_download_client_data"

##################
# Map Extractors #
##################

FROM runtime as tools

LABEL description "AzerothCore Tools"

WORKDIR /azerothcore/env/dist/

RUN mkdir -pv /azerothcore/env/dist/Cameras \
              /azerothcore/env/dist/dbc     \
              /azerothcore/env/dist/maps    \
              /azerothcore/env/dist/mmaps   \
              /azerothcore/env/dist/vmaps

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build \
  /azerothcore/env/dist/bin/map_extractor /azerothcore/env/dist/bin/map_extractor

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build \
  /azerothcore/env/dist/bin/mmaps_generator /azerothcore/env/dist/bin/mmaps_generator

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build \
  /azerothcore/env/dist/bin/vmap4_assembler /azerothcore/env/dist/bin/vmap4_assembler

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build \
  /azerothcore/env/dist/bin/vmap4_extractor /azerothcore/env/dist/bin/vmap4_extractor

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

# Configure Timezone
RUN apt-get update                                          \
    && apt-get install -y tzdata ca-certificates            \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime   \
    && echo $TZ > /etc/timezone                         \
    && dpkg-reconfigure --frontend noninteractive tzdata

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

ENV PATH="/azerothcore/env/dist/bin:$PATH"

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

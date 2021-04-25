#================================================================
#
# DEV: Stage used for the development environment
#      and the locally built services
#
#=================================================================

FROM ubuntu:20.04 as dev
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG DOCKER_USER=acore

LABEL description="AC Worldserver Debug Container for use with Visual Studio"

# List of timezones: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

ENV DOCKER=1

# set timezone environment variable
ENV TZ=Etc/UTC

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

# Do not use acore dashboard to install
# since it's not cacheable by docker
RUN apt-get update
RUN apt-get install -y gdb gdbserver git dos2unix lsb-core sudo curl unzip \
  make cmake clang libmysqlclient-dev libace-dev \
  build-essential libtool cmake-data openssl libgoogle-perftools-dev \
  libssl-dev libmysql++-dev libreadline6-dev zlib1g-dev libbz2-dev mysql-client \
  libncurses5-dev ccache

# change timezone in container
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

# Create a non-root user
RUN addgroup --gid $GROUP_ID acore && \
    adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID acore && \
    passwd -d acore && \
    echo 'acore ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

# must be created to set the correct permissions on them
RUN mkdir -p /azerothcore-internal/env/dist/data
RUN mkdir -p /azerothcore-internal/env/dist/logs
RUN mkdir -p /azerothcore-internal/env/dist/etc
RUN mkdir -p /azerothcore-internal/var/build
RUN mkdir -p /azerothcore

# Correct permissions for non-root operations
RUN chown -R $DOCKER_USER:$DOCKER_USER /home/acore
RUN chown -R $DOCKER_USER:$DOCKER_USER /run
RUN chown -R $DOCKER_USER:$DOCKER_USER /opt
RUN chown -R $DOCKER_USER:$DOCKER_USER /azerothcore
RUN chown -R $DOCKER_USER:$DOCKER_USER /azerothcore-internal

USER $DOCKER_USER

# copy everything so we can work directly within the container
# using tools such as vscode dev-container
# NOTE: this folder is different by the /azerothcore (which is binded instead)
COPY --chown=$DOCKER_USER:$DOCKER_USER . /azerothcore-internal

#================================================================
#
# BUILD: compile sources
#
#=================================================================

FROM dev as build

WORKDIR /azerothcore-internal

RUN bin/acore-docker-build

#================================================================
#
# SERVICE BASE: prepare the OS for the production-ready services
#
#=================================================================

FROM ubuntu:20.04 as servicebase

ARG DOCKER_USER=acore

# List of timezones: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

# set timezone environment variable
ENV TZ=Etc/UTC

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

USER $DOCKER_USER

COPY --from=build /azerothcore-internal/env /azerothcore/env

# copy the sources from the host machine
COPY apps /azerothcore/apps
COPY bin /azerothcore/bin
COPY conf /azerothcore/conf
COPY data /azerothcore/data
COPY deps /azerothcore/deps
COPY acore.json /azerothcore/acore.json
COPY acore.sh /azerothcore/acore.sh

# install the required dependencies to run the authserver
RUN apt-get update && apt-get install -y gdb gdbserver net-tools tzdata libmysqlclient-dev libace-dev mysql-client curl unzip;

# change timezone in container
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

WORKDIR /azerothcore/

#================================================================
#
# AUTH SERVICE: create a ready-to-use authserver image
#
#=================================================================

FROM servicebase as authserver

CMD ./acore.sh run-authserver

#================================================================
#
# WORLD SERVICE: create a ready-to-use worldserver image
#
#=================================================================

FROM servicebase as worldserver

ENV DATAPATH=/azerothcore/env/dist/data

RUN /azerothcore/acore.sh client-data

CMD ./acore.sh run-worldserver




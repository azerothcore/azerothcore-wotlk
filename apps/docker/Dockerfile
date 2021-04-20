#================================================================
#
# DEV: Stage used for the development environment
#      and the locally built services
#
#=================================================================

FROM ubuntu:20.04 as dev
ARG USER_ID=1000
ARG GROUP_ID=1000

LABEL description="AC Worldserver Debug Container for use with Visual Studio"

# List of timezones: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

ENV DOCKER=1

# set timezone environment variable
ENV TZ=Etc/UTC

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

# install essentials
RUN apt-get update && apt-get install -y gdb gdbserver git dos2unix lsb-core sudo curl unzip

# copy everything so we can work directly within the container
# using tools such as vscode dev-container
COPY . /azerothcore

# install the required dependencies to run the worldserver
RUN /azerothcore/acore.sh install-deps

# change timezone in container
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

# Create a non-root user
RUN addgroup --gid $GROUP_ID acore && \
    adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID acore && \
    passwd -d acore && \
    echo 'acore ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

RUN mkdir -p /azerothcore

# Correct permissions for non-root operations
RUN chown -R acore:acore \
    /run \
    /home/acore \
    /opt/ \
    /azerothcore

USER acore

WORKDIR /azerothcore

#================================================================
#
# BUILD STAGE: to prepare binaries for the production services
#
#=================================================================
FROM dev as build

RUN bash acore.sh compiler build

#================================================================
#
# SERVICE BASE: prepare the OS for the production-ready services
#
#=================================================================

FROM ubuntu:20.04 as servicebase

# List of timezones: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

# set timezone environment variable
ENV TZ=Etc/UTC

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

COPY --from=build /azerothcore/env /azerothcore/env

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

RUN cp -n "/azerothcore/env/docker/etc/worldserver.conf.dockerdist" "/azerothcore/env/dist/etc/worldserver.conf"
RUN cp -n "/azerothcore/env/docker/etc/authserver.conf.dockerdist" "/azerothcore/env/dist/etc/authserver.conf"

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




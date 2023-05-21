FROM ubuntu:20.04

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG DOCKER_USER=acore

LABEL description="AC service image for server applications"

# List of timezones: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones
# set timezone environment variable
ENV TZ=Etc/UTC

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

# install the required dependencies to run the server
RUN --mount=target=/var/cache/apt,type=cache \
    rm -f /etc/apt/apt.conf.d/docker-clean && \
    apt-get update && \
    apt-get install -y \
        gdb gdbserver git dos2unix lsb-core sudo curl unzip \
        make cmake clang libmysqlclient-dev \
        libboost-system1.7*-dev libboost-filesystem1.7*-dev libboost-program-options1.7*-dev libboost-iostreams1.7*-dev \
        build-essential libtool cmake-data openssl libgoogle-perftools-dev google-perftools \
        libssl-dev libmysql++-dev libreadline6-dev zlib1g-dev libbz2-dev mysql-client ccache && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    bash -c "echo $TZ > /etc/timezone" && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Create a non-root user and give passwordless sudo access
RUN groupadd --gid $GROUP_ID $DOCKER_USER && \
    useradd --comment 'azerothcore' -d /azerothcore --no-create-home --uid $USER_ID --gid $GROUP_ID $DOCKER_USER && \
    bash -c 'echo "$DOCKER_USER ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers'
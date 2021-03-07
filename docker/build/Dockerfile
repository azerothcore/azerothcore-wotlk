FROM ubuntu:20.04
ARG USER_ID=1000
ARG GROUP_ID=1000

# install the required dependencies to compile AzerothCore
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y git curl cmake make gcc g++ clang mysql-client libmysqlclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev libace-6.4.5 libace-dev unzip

# copy the sources from the host machine to the Docker container
ADD .git /azerothcore/.git
ADD acore.sh /azerothcore/acore.sh
ADD acore.json /azerothcore/acore.json
ADD apps /azerothcore/apps
ADD deps /azerothcore/deps
ADD conf /azerothcore/conf
ADD src /azerothcore/src
ADD modules /azerothcore/modules
ADD CMakeLists.txt /azerothcore/CMakeLists.txt

ARG ENABLE_SCRIPTS=1
ENV ENABLE_SCRIPTS=$ENABLE_SCRIPTS

# Create a non-root user
RUN addgroup --gid $GROUP_ID acore && \
    adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID acore && \
    passwd -d acore && \
    echo 'acore ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

RUN mkdir -p /azerothcore/var/build
RUN mkdir -p /azerothcore/env/dist

# Correct permissions for non-root operations
RUN chown -R acore:acore \
    /run \
    /home/acore \
    /opt/ \
    /azerothcore \
    /azerothcore/var/build \
    /azerothcore/env/dist

USER acore

ADD docker/build/.my.cnf /home/acore/.my.cnf

WORKDIR /azerothcore/

CMD bash acore.sh compiler build && bash acore.sh db-assembler import-all


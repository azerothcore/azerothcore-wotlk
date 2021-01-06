FROM ubuntu:20.04

# install the required dependencies to compile AzerothCore
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y git cmake make gcc g++ clang libmysqlclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev libace-6.4.5 libace-dev

# copy the sources from the host machine to the Docker container
ADD .git /azerothcore/.git
ADD acore.sh /azerothcore/acore.sh
ADD apps /azerothcore/apps
ADD deps /azerothcore/deps
ADD conf /azerothcore/conf
ADD src /azerothcore/src
ADD modules /azerothcore/modules
ADD CMakeLists.txt /azerothcore/CMakeLists.txt

ARG ENABLE_SCRIPTS=1
ENV ENABLE_SCRIPTS=$ENABLE_SCRIPTS

WORKDIR /azerothcore/

ENTRYPOINT  bash acore.sh compiler build && \
            # copy the binary files "authserver" and "worldserver" files back to the host
            # - the directories "/binworldserver" and "/binauthserver" are meant to be bound to the host directories
            # - see docker/build/README.md to view the bindings
            cp -f env/dist/bin/worldserver /binworldserver && \
            cp -f env/dist/bin/authserver /binauthserver

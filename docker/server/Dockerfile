# syntax = docker/dockerfile:1.2

FROM ubuntu:20.04 as testable

# install the required dependencies to compile AzerothCore
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y git \
                   cmake make gcc g++ clang ccache \
                   libmysqlclient-dev libssl-dev \
                   libbz2-dev libreadline-dev \
                   libncurses-dev libace-6.4.5 \
                   libace-dev

# copy the sources from the host machine to the Docker container
ADD deps /azerothcore/deps
ADD conf/dist /azerothcore/conf/dist
ADD src /azerothcore/src
ADD modules /azerothcore/modules
ADD CMakeLists.txt /azerothcore/CMakeLists.txt

ARG ENABLE_SCRIPTS=1
ENV ENABLE_SCRIPTS=$ENABLE_SCRIPTS

RUN --mount=type=cache,target=/root/.ccache \
    mkdir azerothcore/build && \
    cd azerothcore/build && \
    # run cmake
    cmake ../ -DCMAKE_INSTALL_PREFIX=/azeroth-server \
              -DCMAKE_C_COMPILER=/usr/bin/clang \
              -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
              -DTOOLS=0 \
              -DSCRIPTS=$ENABLE_SCRIPTS \
              -DWITH_WARNINGS=1 \
              -DCMAKE_C_FLAGS="-Werror" \
              -DCMAKE_CXX_FLAGS="-Werror" \
              -DBUILD_TESTING=1 \
              -DCMAKE_C_COMPILER_LAUNCHER=ccache \
              -DCMAKE_CXX_COMPILER_LAUNCHER=ccache && \
    # calculate the optimal number of threads
    MTHREADS=`grep -c ^processor /proc/cpuinfo`; MTHREADS=$(($MTHREADS + 2)) && \
    # run compilation
    CCACHE_CPP2=true \
    CCACHE_MAXSIZE='500MB' \
    CCACHE_COMPRESS=1 \
    make -j $MTHREADS && \
    make install -j $MTHREADS && \
    # copy the binary files "authserver" and "worldserver" files back to the host
    # - the directories "/binworldserver" and "/binauthserver" are meant to be bound to the host directories
    # - see docker/build/README.md to view the bindings
    cp -f /azeroth-server/bin/worldserver /binworldserver && \
    cp -f /azeroth-server/bin/authserver /binauthserver

FROM ubuntu:20.04 as runnable

COPY --from=testable /azeroth-server/bin/worldserver /azeroth-server/bin/worldserver 
COPY --from=testable /azeroth-server/bin/authserver /azeroth-server/bin/authserver

COPY docker/server/config/worldserver.conf.dist /azeroth-server/etc/worldserver.conf.dist
COPY docker/server/config/authserver.conf.dist /azeroth-server/etc/authserver.conf.dist
COPY docker/server/config/worldserver.conf.dockerdist /azeroth-server/etc/worldserver.conf
COPY docker/server/config/authserver.conf.dockerdist /azeroth-server/etc/authserver.conf

# List of timezones: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones
# set timezone environment variable 
ENV TZ=Etc/UTC

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

# install the required dependencies to run the authserver
RUN apt update && apt install -y libmysqlclient-dev libssl-dev libace-6.4.5 libace-dev libreadline-dev net-tools tzdata;

# change timezone in container
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

HEALTHCHECK --interval=5s --timeout=15s --start-period=30s --retries=3 CMD netstat -lnpt | grep :8085 || exit 1

COPY entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]

# run the worldserver located in the directory "docker/worldserver/bin" of the host machine
CMD ["/azeroth-server/bin/worldserver"]

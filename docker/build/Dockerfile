FROM ubuntu:bionic

ENV IS_DOCKER_CONTAINER=1

# install the required dependencies to compile AzerothCore
ADD apps /azerothcore/apps
ADD acore.sh /azerothcore/acore.sh
RUN bash ./acore.sh install-deps

# copy the sources from the host machine to the Docker container
ADD .git /azerothcore/.git
ADD deps /azerothcore/deps
ADD conf/config.cmake.dist /azerothcore/conf/config.cmake.dist
ADD src /azerothcore/src
ADD modules /azerothcore/modules
ADD CMakeLists.txt /azerothcore/CMakeLists.txt

ARG ENABLE_SCRIPTS=1
ENV ENABLE_SCRIPTS=$ENABLE_SCRIPTS

ENTRYPOINT  cd azerothcore/build && \
            # run cmake
            cmake ../ -DCMAKE_INSTALL_PREFIX=/azeroth-server -DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++ -DTOOLS=0 -DSCRIPTS=$ENABLE_SCRIPTS -DWITH_WARNINGS=1 -DCMAKE_C_FLAGS="-Werror" -DCMAKE_CXX_FLAGS="-Werror" && \
            # calculate the optimal number of threads
            MTHREADS=`grep -c ^processor /proc/cpuinfo`; MTHREADS=$(($MTHREADS + 2)) && \
            # run compilation
            make -j $MTHREADS && \
            make install -j $MTHREADS && \
            # copy the binary files "authserver" and "worldserver" files back to the host
            # - the directories "/binworldserver" and "/binauthserver" are meant to be bound to the host directories
            # - see docker/build/README.md to view the bindings
            cp /azeroth-server/bin/worldserver /binworldserver && \
            cp /azeroth-server/bin/authserver /binauthserver

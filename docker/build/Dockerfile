FROM ubuntu:bionic

# install the required dependencies to compile AzerothCore
RUN apt update && apt install -y git cmake make gcc g++ clang libmysqlclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev libace-6.* libace-dev

# copy the sources from the host machine to the Docker container
ADD .git /azerothcore/.git
ADD deps /azerothcore/deps
ADD conf/config.cmake.dist /azerothcore/conf/config.cmake.dist
ADD src /azerothcore/src
ADD CMakeLists.txt /azerothcore/CMakeLists.txt

ENTRYPOINT  cd azerothcore/build && \
            # run cmake
            cmake ../ -DCMAKE_INSTALL_PREFIX=/azeroth-server -DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++ -DTOOLS=0 -DSCRIPTS=1 && \
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

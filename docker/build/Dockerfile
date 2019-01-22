FROM ubuntu:bionic

RUN apt update && apt install -y git cmake make gcc g++ clang libmysqlclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev libace-6.* libace-dev

ADD .git /azerothcore/.git
ADD deps /azerothcore/deps
ADD conf/config.cmake.dist /azerothcore/conf/config.cmake.dist
ADD src /azerothcore/src
ADD CMakeLists.txt /azerothcore/CMakeLists.txt

RUN cd azerothcore; \
    mkdir build; \
    cd build; \
    cmake ../ -DCMAKE_INSTALL_PREFIX=/azeroth-server -DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++ -DTOOLS=0 -DSCRIPTS=1; \
    MTHREADS=`grep -c ^processor /proc/cpuinfo`; MTHREADS=$(($MTHREADS + 2)); \
    make -j $MTHREADS; \
    make install -j $MTHREADS;

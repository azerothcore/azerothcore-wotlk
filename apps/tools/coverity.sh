#!/usr/bin/env bash

set -x

# move inside var directory
cd var

# download the coverity tool
wget -q https://scan.coverity.com/download/cxx/linux64 --post-data "token=$COVERITY_TOKEN&project=azerothcore%2Fazerothcore-wotlk" -O cov-analysis-linux64.tar.gz
mkdir cov-analysis-linux64
tar xzf cov-analysis-linux64.tar.gz --strip 1 -C cov-analysis-linux64
export PATH=`pwd`/cov-analysis-linux64/bin:$PATH

#configure the compilation
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
mkdir cov-build
cd cov-build
cov-configure --template --compiler clang --comptype clangcc
cmake ../../ -DWITH_WARNINGS=1 -DWITH_COREDEBUG=1 -DUSE_COREPCH=1 -DUSE_SCRIPTPCH=1 -DTOOLS=0 -DSCRIPTS=1 -DSERVERS=1 -DWITH_PERFTOOLS=0 -DENABLE_EXTRA_LOGS=1 -DCMAKE_BUILD_TYPE=Debug

# start the compilation
echo "Using # cpu core:"`nproc`
cov-build --dir cov-int make -j`nproc` -k

# send the archive to coverity
tar czvf acore.tgz cov-int
curl \
--form token=$COVERITY_TOKEN \
--form email=$COVERITY_EMAIL \
--form file=@acore.tgz \
--form version=trunk \
--form description="Coverity scan for azerothcore" \
https://scan.coverity.com/builds?project=azerothcore%2Fazerothcore-wotlk


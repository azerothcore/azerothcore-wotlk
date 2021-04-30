#!/usr/bin/env bash

cd /azerothcore

export CCACHE_CPP2=true
export CCACHE_MAXSIZE='500MB'
export CCACHE_COMPRESS=1

export CTOOLS=ON

ccache -s
bash acore.sh compiler build
ccache -s

echo "Generating confs..."
cp -n "env/dist/etc/worldserver.conf.dockerdist" "env/dist/etc/worldserver.conf"
cp -n "env/dist/etc/authserver.conf.dockerdist" "env/dist/etc/authserver.conf"



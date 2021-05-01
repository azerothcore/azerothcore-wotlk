#!/usr/bin/env bash

cd /azerothcore

export CTOOLS=${CTOOLS:-ON}

bash acore.sh compiler build

echo "Generating confs..."
cp -n "env/dist/etc/worldserver.conf.dockerdist" "env/dist/etc/worldserver.conf"
cp -n "env/dist/etc/authserver.conf.dockerdist" "env/dist/etc/authserver.conf"



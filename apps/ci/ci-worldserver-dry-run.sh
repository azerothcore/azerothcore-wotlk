#!/bin/bash

set -e

echo "[worldserver]" >> ./env/dist/etc/worldserver.conf
echo "DataDir = \"../data/\"" >> ./env/dist/etc/worldserver.conf
echo "LoginDatabaseInfo     = \"localhost;3306;root;root;acore_auth\"" >> ./env/dist/etc/worldserver.conf
echo "WorldDatabaseInfo     = \"localhost;3306;root;root;acore_world\"" >> ./env/dist/etc/worldserver.conf
echo "CharacterDatabaseInfo = \"localhost;3306;root;root;acore_characters\"" >> ./env/dist/etc/worldserver.conf
git clone --depth=1 --branch=master --single-branch https://github.com/ac-data/ac-data.git ./env/dist/data
(cd ./env/dist/bin/ && timeout 5m ./worldserver --dry-run)

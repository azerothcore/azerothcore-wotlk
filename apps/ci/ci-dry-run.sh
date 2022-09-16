#!/bin/bash

set -e

# Start mysql
sudo systemctl start mysql

APP_NAME=$1

echo "LoginDatabaseInfo     = \"localhost;3306;root;root;acore_auth\"" >> ./env/dist/etc/$APP_NAME.conf

if [[ $APP_NAME != "authserver" ]]; then
    {
        echo "WorldDatabaseInfo     = \"localhost;3306;root;root;acore_world\""
        echo "CharacterDatabaseInfo = \"localhost;3306;root;root;acore_characters\""
    } >> ./env/dist/etc/$APP_NAME.conf
fi

if [[ $APP_NAME == "worldserver" ]]; then
    echo "DataDir = \"../data/\"" >> ./env/dist/etc/$APP_NAME.conf

    git clone --depth=1 --branch=master --single-branch https://github.com/ac-data/ac-data.git ./env/dist/data
fi

(cd ./env/dist/bin/ && timeout 5m ./$APP_NAME -dry-run)

# Stop mysql
sudo systemctl stop mysql

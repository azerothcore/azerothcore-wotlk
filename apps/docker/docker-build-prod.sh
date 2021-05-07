#!/usr/bin/env bash

cd /azerothcore

bash acore.sh compiler build

# set worldserver SUID bit
sudo chown root:root env/dist/bin/worldserver
sudo chmod u+s env/dist/bin/worldserver

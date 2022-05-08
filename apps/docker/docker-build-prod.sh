#!/usr/bin/env bash

cd /azerothcore
git config --global --add safe.directory /azerothcore

bash acore.sh compiler build

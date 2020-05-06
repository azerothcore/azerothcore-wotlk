#!/bin/bash

set -e

echo "install modules"
git clone --depth=1 --branch=master --recursive https://github.com/azerothcore/mod-eluna-lua-engine.git modules/mod-eluna-lua-engine
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-autobalance.git modules/mod-autobalance
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-transmog.git modules/mod-transmog
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-npc-beastmaster.git modules/mod-npc-beastmaster
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-duel-reset.git modules/mod-duel-reset
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-premium modules/mod-premium

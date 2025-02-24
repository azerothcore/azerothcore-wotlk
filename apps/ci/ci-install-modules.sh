#!/bin/bash

set -e

echo "install modules"
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-eluna.git modules/mod-eluna
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-autobalance.git modules/mod-autobalance
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-ah-bot.git modules/mod-ah-bot
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-anticheat.git modules/mod-anticheat
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-bg-item-reward.git modules/mod-bg-item-reward
# NOTE: disabled because it causes DB error
# git clone --depth=1 --branch=master https://github.com/azerothcore/mod-azerothshard.git modules/mod-azerothshard
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-cfbg.git modules/mod-cfbg
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-chat-transmitter modules/mod-chat-transmitter
# NOTE: disabled because it causes DB error
#git clone --depth=1 --branch=master https://github.com/azerothcore/mod-chromie-xp.git modules/mod-chromie-xp
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-cta-switch.git modules/mod-cta-switch
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-desertion-warnings.git modules/mod-desertion-warnings
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-duel-reset.git modules/mod-duel-reset
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-ip-tracker.git modules/mod-ip-tracker
git clone --depth=1 --branch=main   https://github.com/azerothcore/mod-low-level-arena.git modules/mod-low-level-arena
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-low-level-rbg.git modules/mod-low-level-rbg
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-multi-client-check.git modules/mod-multi-client-check
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-pvp-titles.git modules/mod-pvp-titles
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-pvpstats-announcer.git modules/mod-pvpstats-announcer
git clone --depth=1 --branch=main   https://github.com/azerothcore/mod-queue-list-cache.git modules/mod-queue-list-cache
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-server-auto-shutdown.git modules/mod-server-auto-shutdown
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-transmog.git modules/mod-transmog
git clone --depth=1 --branch=main   https://github.com/azerothcore/mod-progression-system.git modules/mod-progression-system
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-arena-3v3-solo-queue.git modules/mod-arena-3v3-solo-queue
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-costumes.git modules/mod-costumes

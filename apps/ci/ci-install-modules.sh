#!/bin/bash

set -e

echo "install modules"
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-1v1-arena modules/mod-1v1-arena
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-account-mounts modules/mod-account-mounts
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-ah-bot modules/mod-ah-bot
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-anticheat modules/mod-anticheat
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-antifarming modules/mod-antifarming
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-arena-3v3-solo-queue modules/mod-arena-3v3-solo-queue
git clone --depth=1 --branch=main   https://github.com/azerothcore/mod-arena-replay modules/mod-arena-replay
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-auto-revive modules/mod-auto-revive
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-autobalance modules/mod-autobalance
# NOTE: disabled because it causes DB error
# git clone --depth=1 --branch=master https://github.com/azerothcore/mod-azerothshard.git modules/mod-azerothshard
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-better-item-reloading modules/mod-better-item-reloading
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-bg-item-reward modules/mod-bg-item-reward
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-bg-reward modules/mod-bg-reward
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-boss-announcer modules/mod-boss-announcer
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-breaking-news-override modules/mod-breaking-news-override
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-buff-command modules/mod-buff-command
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-cfbg modules/mod-cfbg
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-character-tools modules/mod-character-tools
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-chat-login modules/mod-chat-login
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-chat-transmitter modules/mod-chat-transmitter
# NOTE: disabled because it causes DB startup error
# git clone --depth=1 --branch=master https://github.com/azerothcore/mod-chromie-xp modules/mod-chromie-xp
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-congrats-on-level modules/mod-congrats-on-level
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-costumes modules/mod-costumes
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-cta-switch modules/mod-cta-switch
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-custom-login modules/mod-custom-login
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-desertion-warnings modules/mod-desertion-warnings
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-detailed-logging modules/mod-detailed-logging
git clone --depth=1 --branch=main   https://github.com/azerothcore/mod-dmf-switch modules/mod-dmf-switch
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-duel-reset modules/mod-duel-reset
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-dynamic-xp modules/mod-dynamic-xp
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-ale modules/mod-ale
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-emblem-transfer modules/mod-emblem-transfer
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-fireworks-on-level modules/mod-fireworks-on-level
git clone --depth=1 --branch=main   https://github.com/azerothcore/mod-global-chat modules/mod-global-chat
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-guild-zone-system modules/mod-guild-zone-system
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-guildhouse modules/mod-guildhouse
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-individual-xp modules/mod-individual-xp
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-instance-reset modules/mod-instance-reset
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-instanced-worldbosses modules/mod-instanced-worldbosses
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-ip-tracker modules/mod-ip-tracker
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-item-level-up modules/mod-item-level-up
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-keep-out modules/mod-keep-out
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-learn-highest-talent modules/mod-learn-highest-talent
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-learn-spells modules/mod-learn-spells
git clone --depth=1 --branch=main   https://github.com/azerothcore/mod-low-level-arena modules/mod-low-level-arena
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-low-level-rbg modules/mod-low-level-rbg
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-mall-teleport modules/mod-mall-teleport
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-morph-all-players modules/mod-morph-all-players
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-morphsummon modules/mod-morphsummon
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-multi-client-check modules/mod-multi-client-check
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-notify-muted modules/mod-notify-muted
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-npc-all-mounts modules/mod-npc-all-mounts
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-npc-beastmaster modules/mod-npc-beastmaster
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-npc-buffer modules/mod-npc-buffer
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-npc-codebox modules/mod-npc-codebox
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-npc-enchanter modules/mod-npc-enchanter
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-npc-free-professions modules/mod-npc-free-professions
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-npc-gambler modules/mod-npc-gambler
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-npc-morph modules/mod-npc-morph
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-npc-services modules/mod-npc-services
# not yet on azerothcore github
git clone --depth=1 --branch=master https://github.com/gozzim/mod-npc-spectator modules/mod-npc-spectator
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-npc-talent-template modules/mod-npc-talent-template
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-npc-titles-tokens modules/mod-npc-titles-tokens
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-phased-duels modules/mod-phased-duels
# outdated
# git clone --depth=1 --branch=master https://github.com/azerothcore/mod-playerbots modules/mod-playerbots
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-pocket-portal modules/mod-pocket-portal
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-premium modules/mod-premium
git clone --depth=1 --branch=main   https://github.com/azerothcore/mod-progression-system.git modules/mod-progression-system
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-promotion-azerothcore modules/mod-promotion-azerothcore
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-pvp-quests modules/mod-pvp-quests
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-pvp-titles modules/mod-pvp-titles
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-pvp-zones modules/mod-pvp-zones
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-pvpscript modules/mod-pvpscript
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-pvpstats-announcer modules/mod-pvpstats-announcer
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-quest-status modules/mod-quest-status
git clone --depth=1 --branch=main   https://github.com/azerothcore/mod-queue-list-cache modules/mod-queue-list-cache
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-quick-teleport modules/mod-quick-teleport
git clone --depth=1 --branch=main   https://github.com/azerothcore/mod-racial-trait-swap modules/mod-racial-trait-swap
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-random-enchants modules/mod-random-enchants
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-rdf-expansion modules/mod-rdf-expansion
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-resurrection-scroll modules/mod-resurrection-scroll
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-reward-played-time modules/mod-reward-played-time
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-reward-shop modules/mod-reward-shop
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-server-auto-shutdown.git modules/mod-server-auto-shutdown
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-solocraft modules/mod-solocraft
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-skip-dk-starting-area modules/mod-skip-dk-starting-area
# has core patch file
# git clone --depth=1 --branch=master https://github.com/azerothcore/mod-spell-regulator modules/mod-spell-regulator
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-starter-guild modules/mod-starter-guild
git clone --depth=1 --branch=main   https://github.com/azerothcore/mod-system-vip modules/mod-system-vip
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-tic-tac-toe modules/mod-tic-tac-toe
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-top-arena modules/mod-top-arena
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-transmog modules/mod-transmog
# archived / outdated
#git clone --depth=1 --branch=master https://github.com/azerothcore/mod-war-effort modules/mod-war-effort
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-weekend-xp modules/mod-weekend-xp
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-who-logged modules/mod-who-logged
git clone --depth=1 --branch=master https://github.com/azerothcore/mod-zone-difficulty modules/mod-zone-difficulty

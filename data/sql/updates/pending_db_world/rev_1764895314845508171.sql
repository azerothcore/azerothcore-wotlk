-- https://github.com/azerothcore/azerothcore-wotlk/issues/15626
UPDATE `creature_template` SET `ScriptName` = 'npc_cos_entrance_gossip' WHERE `entry` IN (30551, 30552);

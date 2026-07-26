-- DB update 2026_06_16_02 -> 2026_06_16_03
-- Remove creature_multispawn rows orphaned by deleted creature spawns
DELETE FROM `creature_multispawn` WHERE `spawnId` NOT IN (SELECT `guid` FROM `creature`);

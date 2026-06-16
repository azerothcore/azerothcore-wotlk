-- Remove creature_multispawn rows orphaned by deleted creature spawns
DELETE FROM `creature_multispawn` WHERE `spawnId` NOT IN (SELECT `guid` FROM `creature`);

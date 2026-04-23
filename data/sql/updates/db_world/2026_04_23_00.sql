-- DB update 2026_04_22_03 -> 2026_04_23_00
--
-- Fix quest "The Deadliest Trap Ever Laid" (11097 Scryer / 11101 Aldor):
-- the AC-specific SCRIPTED_SPAWN (state=0 on AI_INIT -> despawn self)
-- pattern loops forever under the ported dynamic spawn system because
-- each respawn creates a new creature whose AI_INIT fires the despawn
-- again. Migrate to MANUAL_SPAWN spawn groups and SPAWN_SPAWNGROUP /
-- DESPAWN_SPAWNGROUP, which is what the spawn system port was built for.
--

-- Four manual-spawn groups: two per quest (defenders, skybreakers)
DELETE FROM `spawn_group_template` WHERE `groupId` IN (100, 101, 102, 103);
INSERT INTO `spawn_group_template` (`groupId`, `groupName`, `groupFlags`) VALUES
(100, 'Sanctum of the Stars - Defenders',   0x04),
(101, 'Sanctum of the Stars - Skybreakers', 0x04),
(102, 'Altar of Sha''tar - Defenders',      0x04),
(103, 'Altar of Sha''tar - Skybreakers',    0x04);

-- Assign existing creature spawns to their groups
DELETE FROM `spawn_group` WHERE `groupId` = 100;
INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`) SELECT 100, 0, `guid` FROM `creature` WHERE `id1` = 23435;
DELETE FROM `spawn_group` WHERE `groupId` = 101;
INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`) SELECT 101, 0, `guid` FROM `creature` WHERE `id1` = 23440;
DELETE FROM `spawn_group` WHERE `groupId` = 102;
INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`) SELECT 102, 0, `guid` FROM `creature` WHERE `id1` = 23453;
DELETE FROM `spawn_group` WHERE `groupId` = 103;
INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`) SELECT 103, 0, `guid` FROM `creature` WHERE `id1` = 23441;

-- Skybreakers respawn mid-event (wave mechanic)
UPDATE `creature` SET `spawntimesecs` = 5 WHERE `id1` IN (23440, 23441);

-- Drop the creatures' AI_INIT self-despawn events (dormancy now handled by MANUAL_SPAWN)
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `event_type` = 37 AND `action_type` = 226 AND `entryorguid` IN (23435, 23440, 23441, 23453);

-- Commander Hobb: On Just Died cleanup -> DESPAWN_SPAWNGROUP
UPDATE `smart_scripts` SET `action_type` = 132, `action_param1` = 100, `action_param2` = 0, `action_param3` = 0, `target_type` = 1, `target_param1` = 0, `target_param3` = 0, `comment` = 'Commander Hobb - On Just Died - Despawn Defenders Group'   WHERE `entryorguid` = 23434 AND `source_type` = 0 AND `id` = 7;
UPDATE `smart_scripts` SET `action_type` = 132, `action_param1` = 101, `action_param2` = 0, `action_param3` = 0, `target_type` = 1, `target_param1` = 0, `target_param3` = 0, `comment` = 'Commander Hobb - On Just Died - Despawn Skybreakers Group' WHERE `entryorguid` = 23434 AND `source_type` = 0 AND `id` = 8;

-- Commander Arcus (Aldor): same cleanup
UPDATE `smart_scripts` SET `action_type` = 132, `action_param1` = 102, `action_param2` = 0, `action_param3` = 0, `target_type` = 1, `target_param1` = 0, `target_param3` = 0, `comment` = 'Commander Arcus - On Just Died - Despawn Defenders Group'   WHERE `entryorguid` = 23452 AND `source_type` = 0 AND `id` = 7;
UPDATE `smart_scripts` SET `action_type` = 132, `action_param1` = 103, `action_param2` = 0, `action_param3` = 0, `target_type` = 1, `target_param1` = 0, `target_param3` = 0, `comment` = 'Commander Arcus - On Just Died - Despawn Skybreakers Group' WHERE `entryorguid` = 23452 AND `source_type` = 0 AND `id` = 8;

-- Hobb start actionlist: SPAWN_SPAWNGROUP
UPDATE `smart_scripts` SET `action_type` = 131, `action_param1` = 100, `action_param2` = 0, `action_param3` = 0, `action_param4` = 0, `action_param5` = 0, `target_type` = 1, `target_param1` = 0, `target_param3` = 0, `comment` = 'Commander Hobb - Actionlist - Spawn Sanctum Defenders Group'   WHERE `entryorguid` = 2343400 AND `source_type` = 9 AND `id` = 3;
UPDATE `smart_scripts` SET `action_type` = 131, `action_param1` = 101, `action_param2` = 0, `action_param3` = 0, `action_param4` = 0, `action_param5` = 0, `target_type` = 1, `target_param1` = 0, `target_param3` = 0, `comment` = 'Commander Hobb - Actionlist - Spawn Dragonmaw Skybreakers Group' WHERE `entryorguid` = 2343400 AND `source_type` = 9 AND `id` = 10;

-- Hobb complete actionlist: DESPAWN_SPAWNGROUP
UPDATE `smart_scripts` SET `action_type` = 132, `action_param1` = 100, `action_param2` = 0, `action_param3` = 0, `target_type` = 1, `target_param1` = 0, `target_param3` = 0, `comment` = 'Commander Hobb - Actionlist - Despawn Defenders Group'   WHERE `entryorguid` = 2343402 AND `source_type` = 9 AND `id` = 0;
UPDATE `smart_scripts` SET `action_type` = 132, `action_param1` = 101, `action_param2` = 0, `action_param3` = 0, `target_type` = 1, `target_param1` = 0, `target_param3` = 0, `comment` = 'Commander Hobb - Actionlist - Despawn Skybreakers Group' WHERE `entryorguid` = 2343402 AND `source_type` = 9 AND `id` = 1;

-- Arcus start actionlist
UPDATE `smart_scripts` SET `action_type` = 131, `action_param1` = 102, `action_param2` = 0, `action_param3` = 0, `action_param4` = 0, `action_param5` = 0, `target_type` = 1, `target_param1` = 0, `target_param3` = 0, `comment` = 'Commander Arcus - Actionlist - Spawn Altar Defenders Group'     WHERE `entryorguid` = 2345200 AND `source_type` = 9 AND `id` = 5;
UPDATE `smart_scripts` SET `action_type` = 131, `action_param1` = 103, `action_param2` = 0, `action_param3` = 0, `action_param4` = 0, `action_param5` = 0, `target_type` = 1, `target_param1` = 0, `target_param3` = 0, `comment` = 'Commander Arcus - Actionlist - Spawn Dragonmaw Skybreakers Group' WHERE `entryorguid` = 2345200 AND `source_type` = 9 AND `id` = 9;

-- Arcus complete actionlist
UPDATE `smart_scripts` SET `action_type` = 132, `action_param1` = 102, `action_param2` = 0, `action_param3` = 0, `target_type` = 1, `target_param1` = 0, `target_param3` = 0, `comment` = 'Commander Arcus - Actionlist - Despawn Defenders Group'   WHERE `entryorguid` = 2345202 AND `source_type` = 9 AND `id` = 0;
UPDATE `smart_scripts` SET `action_type` = 132, `action_param1` = 103, `action_param2` = 0, `action_param3` = 0, `target_type` = 1, `target_param1` = 0, `target_param3` = 0, `comment` = 'Commander Arcus - Actionlist - Despawn Skybreakers Group' WHERE `entryorguid` = 2345202 AND `source_type` = 9 AND `id` = 1;

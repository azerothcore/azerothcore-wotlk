-- DB update 2023_11_16_08 -> 2023_11_16_09
-- Spawns for Razzashi Cobra (11373)
DELETE FROM `creature` WHERE `guid` IN (52323, 52324, 52325, 52326);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(52323, 11373, 0, 0, 309, 0, 0, 1, 1, 0, -12021.2, -1719.73, 39.2625, 0.85, 259200, 0, 0, 15260, 0, 0, 0, 0, 0, '', NULL, 0, NULL),
(52324, 11373, 0, 0, 309, 0, 0, 1, 1, 0, -12029.4, -1714.54, 39.2802, 0.68, 259200, 0, 0, 15260, 0, 0, 0, 0, 0, '', NULL, 0, NULL),
(52325, 11373, 0, 0, 309, 0, 0, 1, 1, 0, -12036.8, -1704.27, 39.9802, 0.45, 259200, 0, 0, 15260, 0, 0, 0, 0, 0, '', NULL, 0, NULL),
(52326, 11373, 0, 0, 309, 0, 0, 1, 1, 0, -12037.7, -1694.2, 39.2746, 0.27, 259200, 0, 0, 15260, 0, 0, 0, 0, 0, '', NULL, 0, NULL);

-- Remove script from Razzashi Cobra (11373)
UPDATE `creature_template` SET `ScriptName` = '' WHERE (`entry` = 11373);

-- Update SAI for Razzaishi Cobra (11373)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11373) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11373, 0, 0, 0, 0, 0, 100, 0, 8000, 8000, 15000, 15000, 0, 0, 11, 24097, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Cobra - In Combat - Cast \'Poison\'');

-- High Priest Venoxis (GUID: 49194) and Razzashi Cobra (GUID: 52323-52326) creature formation
DELETE FROM `creature_formations` WHERE `leaderGUID` = 49194;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(49194, 49194, 0, 0, 27, 0, 0),
(49194, 52323, 0, 0, 27, 0, 0),
(49194, 52324, 0, 0, 27, 0, 0),
(49194, 52325, 0, 0, 27, 0, 0),
(49194, 52326, 0, 0, 27, 0, 0);

-- High Priest Venoxis (GUID: 49194) and Razzashi Cobra (GUID: 52323-52326) linked respawn
DELETE FROM `linked_respawn` WHERE `linkedGuid` = 49194;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(52323, 49194, 0),
(52324, 49194, 0),
(52325, 49194, 0),
(52326, 49194, 0);

-- DB update 2025_01_14_03 -> 2025_01_14_04

-- Add Waypoint.
DELETE FROM `waypoint_data` WHERE `id` IN (10041400);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(10041400, 1, 1142.7643, 977.347, 361.2085, NULL, 0, 0, 0, 100, 0),
(10041400, 2, 1155.1647, 984.28235, 361.20853, NULL, 0, 0, 0, 100, 0),
(10041400, 3, 1166.8981, 993.3729, 361.2085, NULL, 0, 0, 0, 100, 0),
(10041400, 4, 1174.3507, 1003.2168, 361.20853, NULL, 0, 0, 0, 100, 0),
(10041400, 5, 1179.8309, 1016.7469, 361.20847, NULL, 0, 0, 0, 100, 0),
(10041400, 6, 1181.4456, 1026.8712, 361.20853, NULL, 0, 0, 0, 100, 0),
(10041400, 7, 1179.8309, 1016.7469, 361.20847, NULL, 0, 0, 0, 100, 0),
(10041400, 8, 1174.3507, 1003.2168, 361.20853, NULL, 0, 0, 0, 100, 0),
(10041400, 9, 1166.8981, 993.3729, 361.2085, NULL, 0, 0, 0, 100, 0),
(10041400, 10, 1155.1647, 984.28235, 361.20853, NULL, 0, 0, 0, 100, 0),
(10041400, 11, 1142.7643, 977.347, 361.2085, NULL, 0, 0, 0, 100, 0),
(10041400, 12, 1123.0382, 971.89996, 361.30014, NULL, 0, 0, 0, 100, 0);

-- Change WD, MT, Position for an Azure Inquisitor.
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 2, `position_x` = 1123.0382, `position_y` = 971.89996, `position_z` = 361.30014, `orientation` = 3.4109 WHERE `guid` IN (100414) AND `id1` = 27633;

-- Create new Azure Spellbinders.
DELETE FROM `creature` WHERE (`id1` = 27635) AND (`guid` IN (100400, 100402, 100404));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(100400, 27635, 0, 0, 578, 0, 0, 3, 1, 1, 1123.0382, 971.89996, 361.30014, 3.4109, 3600, 0, 0, 48700, 19465, 2, 0, 0, 0, '', 0, 0, NULL),
(100402, 27635, 0, 0, 578, 0, 0, 3, 1, 1, 1183, 1037.33, 361.07, 3.93238, 3600, 2, 0, 48700, 19465, 1, 0, 0, 0, '', 0, 0, NULL),
(100404, 27635, 0, 0, 578, 0, 0, 3, 1, 1, 1094.9, 1127.86, 361.07, 4.98004, 3600, 2, 0, 48700, 19465, 1, 0, 0, 0, '', 0, 0, NULL);

-- Create new Azure Inquisitors.
DELETE FROM `creature` WHERE (`id1` = 27633) AND (`guid` IN (100405, 100406, 100409));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(100405, 27633, 0, 0, 578, 0, 0, 3, 1, 1, 1179.05, 1068.18, 361.07, 3.20184, 3600, 5, 0, 48700, 0, 1, 0, 0, 0, '', 0),
(100406, 27633, 0, 0, 578, 0, 0, 3, 1, 1, 1181.48, 1070.53, 361.07, 4.55913, 3600, 5, 0, 48700, 0, 1, 0, 0, 0, '', 0),
(100409, 27633, 0, 0, 578, 0, 0, 3, 1, 1, 1107.68, 1132.91, 361.07, 2.17407, 3600, 5, 0, 48700, 0, 1, 0, 0, 0, '', 0);

-- Set waypoint for an Azure Inquisitor and Spellbinder.
DELETE FROM `creature_addon` WHERE (`guid` IN (100414, 100400));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(100414, 10041400, 0, 0, 0, 0, 0, NULL),
(100400, 10041400, 0, 0, 0, 0, 0, NULL);

-- Create Groups.
DELETE FROM `pool_template` WHERE (`entry` IN (22408, 22409, 22410, 22411, 22412, 22413));
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(22408, 1, 'Azure Spellbinder/Inquisitor 1'),
(22409, 1, 'Azure Spellbinder/Inquisitor 2'),
(22410, 1, 'Azure Spellbinder/Inquisitor 3'),
(22411, 1, 'Azure Spellbinder/Inquisitor 4'),
(22412, 1, 'Azure Spellbinder/Inquisitor 5'),
(22413, 1, 'Azure Spellbinder/Inquisitor 6');

DELETE FROM `pool_creature` WHERE (`pool_entry` IN (22408, 22409, 22410, 22411, 22412, 22413)) AND (`guid` IN (100405, 100418, 100406, 100416, 100409, 100419, 100411, 100404, 100414, 100400, 100415, 100402));
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(100405, 22408, 0, 'Azure Spellbinder/Inquisitor (1-2)'),
(100418, 22408, 0, 'Azure Spellbinder/Inquisitor (2-2)'),
(100406, 22409, 0, 'Azure Spellbinder/Inquisitor (1-2)'),
(100416, 22409, 0, 'Azure Spellbinder/Inquisitor (2-2)'),
(100409, 22410, 0, 'Azure Spellbinder/Inquisitor (1-2)'),
(100419, 22410, 0, 'Azure Spellbinder/Inquisitor (2-2)'),
(100411, 22411, 0, 'Azure Spellbinder/Inquisitor (1-2)'),
(100404, 22411, 0, 'Azure Spellbinder/Inquisitor (2-2)'),
(100414, 22412, 0, 'Azure Spellbinder/Inquisitor (1-2)'),
(100400, 22412, 0, 'Azure Spellbinder/Inquisitor (2-2)'),
(100415, 22413, 0, 'Azure Spellbinder/Inquisitor (1-2)'),
(100402, 22413, 0, 'Azure Spellbinder/Inquisitor (2-2)');

-- Change SmartAI for Azure Ley-Whelp
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27636;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27636);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27636, 0, 0, 0, 0, 0, 100, 2, 0, 0, 2000, 2000, 0, 0, 11, 50705, 64, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Azure Ley-Whelp - In Combat - Cast \'Arcane Bolt\' (Normal Dungeon)'),
(27636, 0, 1, 0, 0, 0, 100, 4, 0, 0, 2000, 2000, 0, 0, 11, 59210, 66, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Azure Ley-Whelp - In Combat - Cast \'Arcane Bolt\' (Heroic Dungeon)');

-- Change SmartAI for Azure Spellbinder
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27635;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27635);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27635, 0, 0, 0, 0, 0, 100, 2, 5000, 7000, 5000, 7000, 0, 0, 11, 50702, 64, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Azure Spellbinder - In Combat - Cast \'Arcane Volley\' (Normal Dungeon)'),
(27635, 0, 1, 0, 0, 0, 100, 4, 5000, 7000, 5000, 7000, 0, 0, 11, 59212, 64, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Azure Spellbinder - In Combat - Cast \'Arcane Volley\' (Heroic Dungeon)'),
(27635, 0, 2, 0, 0, 0, 100, 2, 6000, 9000, 6000, 9000, 0, 0, 11, 38047, 64, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Azure Spellbinder - In Combat - Cast \'Mind Warp\' (Normal Dungeon)'),
(27635, 0, 3, 0, 0, 0, 100, 4, 6000, 9000, 6000, 9000, 0, 0, 11, 50566, 64, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Azure Spellbinder - In Combat - Cast \'Mind Warp\' (Heroic Dungeon)'),
(27635, 0, 4, 0, 0, 0, 100, 6, 9000, 12000, 4000, 8000, 0, 0, 11, 50572, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Azure Spellbinder - In Combat - Cast \'Power Sap\' (Dungeon)');

-- Change SmartAI for Azure Inquisitor
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27633;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27633);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27633, 0, 0, 0, 106, 0, 100, 2, 5000, 7000, 5000, 7000, 5, 30, 11, 51454, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Azure Inquisitor - On Hostile in Range - Cast \'Throw\' (Normal Dungeon)'),
(27633, 0, 1, 0, 106, 0, 100, 4, 5000, 7000, 5000, 7000, 5, 30, 11, 59209, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Azure Inquisitor - On Hostile in Range - Cast \'Throw\' (Heroic Dungeon)'),
(27633, 0, 2, 0, 106, 0, 100, 6, 14000, 20000, 14000, 20000, 0, 10, 11, 50690, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Azure Inquisitor - On Hostile in Range - Cast \'Immobilizing Field\' (Dungeon)'),
(27633, 0, 3, 0, 0, 0, 100, 6, 4000, 7000, 9000, 12000, 0, 0, 11, 50573, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Azure Inquisitor - In Combat - Cast \'Arcane Cleave\' (Dungeon)');

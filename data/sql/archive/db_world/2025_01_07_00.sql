-- DB update 2025_01_05_07 -> 2025_01_07_00

-- Remove Wrong WP for Tamed Amani Crocolisk
DELETE FROM `waypoint_data` WHERE `id` IN (176360, 201960);

-- Remove Amani'shi Handler and Flame Caster (replaced with Amani'shi Beast Tamer)
DELETE FROM `creature` WHERE (`id1` = 24065) AND (`guid` IN (24323, 20861, 34024, 34025, 34026));
DELETE FROM `creature` WHERE (`id1` = 23596) AND (`guid` IN (34031, 34030));
DELETE FROM `creature_addon` WHERE (`guid` IN (24323, 20861, 34024, 34025, 34031, 34030, 34026));
DELETE FROM `linked_respawn` WHERE (`guid` IN (24323, 20861, 34024, 34025, 34031, 34030, 34026));

-- Waypoint for Amani'shi Beast Tamer group (already in DB I only corrected it)
DELETE FROM `waypoint_data` WHERE `id` IN (243230);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(243230, 1, 442.129, 904.214, 0.000692, NULL, 0, 0, 0, 100, 0),
(243230, 2, 416.327, 888.693, 0.000035, NULL, 0, 0, 0, 100, 0),
(243230, 3, 442.129, 904.214, 0.000692, NULL, 0, 0, 0, 100, 0),
(243230, 4, 445.459, 962.963, 0.000075, NULL, 0, 0, 0, 100, 0),
(243230, 5, 425.408, 985.171, 0.000075, NULL, 0, 0, 0, 100, 0),
(243230, 6, 410.89, 986.49, 0.000075, NULL, 0, 0, 0, 100, 0),
(243230, 7, 425.408, 985.171, 0.000075, NULL, 0, 0, 0, 100, 0),
(243230, 8, 445.459, 962.963, 0.000075, NULL, 0, 0, 0, 100, 0),
(243230, 9, 442.129, 904.214, 0.000692, NULL, 0, 0, 0, 100, 0);

-- Sniffed Waypoint for an Amani'shi Handler
DELETE FROM `waypoint_data` WHERE `id` IN (8917400);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(8917400, 1, 221.95709, 1133.2837, 0, NULL, 0, 0, 0, 100, 0),
(8917400, 2, 220.70128, 1130.3092, 0, NULL, 0, 0, 0, 100, 0),
(8917400, 3, 222.21317, 1126.2802, 0, NULL, 0, 0, 0, 100, 0),
(8917400, 4, 225.12256, 1123.6393, 0, NULL, 0, 0, 0, 100, 0),
(8917400, 5, 231.03201, 1126.2893, 0, NULL, 0, 0, 0, 100, 0),
(8917400, 6, 235.53342, 1124.0503, 0, NULL, 0, 0, 0, 100, 0),
(8917400, 7, 242.74089, 1126.9958, 0, NULL, 0, 0, 0, 100, 0),
(8917400, 8, 244.73573, 1133.0251, 1.55080, NULL, 0, 0, 0, 100, 0),
(8917400, 9, 248.98828, 1142.2306, 0, NULL, 0, 0, 0, 100, 0),
(8917400, 10, 243.06467, 1143.4736, 0, NULL, 0, 0, 0, 100, 0),
(8917400, 11, 242.09348, 1137.6598, 0, NULL, 0, 0, 0, 100, 0),
(8917400, 12, 236.63585, 1135.982, 0, NULL, 0, 0, 0, 100, 0),
(8917400, 13, 231.60368, 1135.6569, 0, NULL, 0, 0, 0, 100, 0),
(8917400, 14, 227.66483, 1133.9977, 0, NULL, 0, 0, 0, 100, 0),
(8917400, 15, 224.44601, 1136.731, 0, NULL, 0, 0, 0, 100, 0),
(8917400, 16, 221.43864, 1138.8192, 0, NULL, 0, 0, 0, 100, 0),
(8917400, 17, 221.95709, 1133.2837, 0, NULL, 0, 0, 0, 100, 0);

-- Set WD, MT and remove pathid from Tamed Amani Crocolisk
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE `guid` IN (17636, 20196) AND `id1` = 24138;
UPDATE `creature_addon` SET `path_id` = 0 WHERE (`guid` IN (17636, 20196));

-- Create new Amani'shi Beast Tamer
DELETE FROM `creature` WHERE (`id1` = 24059) AND (`guid` IN (89309, 89311, 89312, 89329, 89407));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(89309, 24059, 0, 0, 568, 0, 0, 1, 1, 1, 277.305, 1054.69, 0.000044, 5.70759, 7200, 0, 0, 78044, 0, 2, 0, 0, 0, '', 0),
(89311, 24059, 0, 0, 568, 0, 0, 1, 1, 1, 436.083, 920.6, 0.00397012, 1.93599, 7200, 0, 0, 78044, 0, 2, 0, 0, 0, '', 0),
(89312, 24059, 0, 0, 568, 0, 0, 1, 1, 1, 440.151, 919.88, 0.0001, 4.539345, 7200, 0, 0, 78044, 0, 0, 0, 0, 0, '', 0),
(89329, 24059, 0, 0, 568, 0, 0, 1, 1, 1, 385.161, 996.886, 0.009852, 5.01081, 7200, 0, 0, 78044, 0, 0, 0, 0, 0, '', 0),
(89407, 24059, 0, 0, 568, 0, 0, 1, 1, 1, 381.87, 991.632, 0.00122086, 0.387951, 7200, 0, 0, 78044, 0, 0, 0, 0, 0, '', 0);

-- Update WD and MT for Amani'shi Handler
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 2 WHERE `guid` IN (89174) AND `id1` = 24065;

-- Creature Addon for two Amani'shi Beast Tamer and one Amani'shi Handler
DELETE FROM `creature_addon` WHERE (`guid` IN (89309, 89311, 89174));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(89309, 208610, 0, 0, 0, 0, 0, NULL),
(89311, 243230, 0, 0, 0, 0, 0, NULL),
(89174, 8917400, 0, 0, 0, 0, 0, NULL);

-- Set Creature Formation for Amani'shi Beast Tamer and Crocodiles
DELETE FROM `creature_formations` WHERE `leaderGUID` = 89309;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(89309, 89309, 0, 0, 515, 0, 0),
(89309, 17636, 3, 90, 515, 0, 0),
(89309, 20196, 3, 270, 515, 0, 0);

-- Set Creature Formation for two Amani'shi Beast Tamer
DELETE FROM `creature_formations` WHERE `leaderGUID` = 89311;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(89311, 89311, 0, 0, 515, 0, 0),
(89311, 89312, 3, 90, 515, 0, 0);

-- Set WD and MT for Amani Lynx
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE `guid` IN (25813, 28406, 29104, 29105, 29107, 29108, 29109, 29441, 29846, 31753, 31756, 31826, 31834, 33301) AND `id1` = 24043;

-- Set SmartAI for Amani Lynx
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24043;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24043);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24043, 0, 0, 0, 1, 0, 100, 3, 0, 0, 1000, 1000, 0, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(24043, 0, 1, 2, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - On Aggro - Remove Aura \'Stealth\''),
(24043, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 43317, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - On Aggro - Cast \'Dash\''),
(24043, 0, 3, 0, 0, 0, 100, 2, 5000, 5000, 35000, 35000, 0, 0, 11, 43357, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - In Combat - Cast \'Feral Swipe\'');

-- Set WD and MT for Amani Lynx Cub
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE `guid` IN (87042, 89201, 89202, 89203) AND `id1` = 24064;

-- Add Extra Flag (DONT_OVERRIDE_SAI_ENTRY)
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|134217728 WHERE `entry` IN (24064);

-- Amani Lynx Cub smartAI change
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24064;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24064);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24064, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - On Aggro - Remove Aura \'Stealth\''),
(24064, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 43317, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - On Aggro - Cast \'Dash\''),
(24064, 0, 2, 0, 0, 0, 100, 2, 5000, 5000, 35000, 35000, 0, 0, 11, 43358, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - In Combat - Cast \'Gut Rip\' (Normal Dungeon)');

-- First on/off invisibility pack
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -89177);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-89177, 0, 3, 0, 1, 0, 100, 0, 30000, 35000, 30000, 35000, 0, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(-89177, 0, 4, 0, 1, 0, 100, 0, 40000, 40000, 40000, 40000, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Remove Aura \'Stealth\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -86922);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-86922, 0, 3, 0, 1, 0, 100, 0, 50000, 55000, 50000, 55000, 0, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(-86922, 0, 4, 0, 1, 0, 100, 0, 60000, 60000, 60000, 60000, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Remove Aura \'Stealth\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -89172);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-89172, 0, 3, 0, 1, 0, 100, 0, 60000, 65000, 60000, 65000, 0, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(-89172, 0, 4, 0, 1, 0, 100, 0, 70000, 70000, 70000, 70000, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Remove Aura \'Stealth\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -89173);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-89173, 0, 3, 0, 1, 0, 100, 0, 80000, 85000, 80000, 85000, 0, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(-89173, 0, 4, 0, 1, 0, 100, 0, 90000, 90000, 90000, 90000, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Remove Aura \'Stealth\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -89145);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-89145, 0, 3, 0, 1, 0, 100, 0, 100000, 105000, 100000, 105000, 0, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(-89145, 0, 4, 0, 1, 0, 100, 0, 110000, 110000, 110000, 110000, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Remove Aura \'Stealth\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -89175);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-89175, 0, 3, 0, 1, 0, 100, 0, 20000, 25000, 20000, 25000, 0, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(-89175, 0, 4, 0, 1, 0, 100, 0, 30000, 30000, 30000, 30000, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Remove Aura \'Stealth\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -86921);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-86921, 0, 3, 0, 1, 0, 100, 0, 120000, 125000, 120000, 125000, 0, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(-86921, 0, 4, 0, 1, 0, 100, 0, 130000, 130000, 130000, 130000, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Remove Aura \'Stealth\'');

-- Second on/off invisibility pack
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -87043);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-87043, 0, 3, 0, 1, 0, 100, 0, 30000, 35000, 30000, 35000, 0, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(-87043, 0, 4, 0, 1, 0, 100, 0, 40000, 40000, 40000, 40000, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Remove Aura \'Stealth\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -86198);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-86198, 0, 3, 0, 1, 0, 100, 0, 50000, 55000, 50000, 55000, 0, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(-86198, 0, 4, 0, 1, 0, 100, 0, 60000, 60000, 60000, 60000, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Remove Aura \'Stealth\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -89141);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-89141, 0, 3, 0, 1, 0, 100, 0, 60000, 65000, 60000, 65000, 0, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(-89141, 0, 4, 0, 1, 0, 100, 0, 70000, 70000, 70000, 70000, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Remove Aura \'Stealth\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -89176);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-89176, 0, 3, 0, 1, 0, 100, 0, 80000, 85000, 80000, 85000, 0, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(-89176, 0, 4, 0, 1, 0, 100, 0, 90000, 90000, 90000, 90000, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Remove Aura \'Stealth\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -88652);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-88652, 0, 3, 0, 1, 0, 100, 0, 100000, 105000, 100000, 105000, 0, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(-88652, 0, 4, 0, 1, 0, 100, 0, 110000, 110000, 110000, 110000, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Remove Aura \'Stealth\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -89135);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-89135, 0, 3, 0, 1, 0, 100, 0, 20000, 25000, 20000, 25000, 0, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(-89135, 0, 4, 0, 1, 0, 100, 0, 30000, 30000, 30000, 30000, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Remove Aura \'Stealth\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -89200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-89200, 0, 3, 0, 1, 0, 100, 0, 120000, 125000, 120000, 125000, 0, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(-89200, 0, 4, 0, 1, 0, 100, 0, 130000, 130000, 130000, 130000, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Remove Aura \'Stealth\'');

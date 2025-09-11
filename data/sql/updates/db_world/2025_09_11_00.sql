-- DB update 2025_09_10_02 -> 2025_09_11_00

-- Remove Drakkari Raiders from vehicle_template_accessory
DELETE FROM `vehicle_template_accessory` WHERE `entry` = 29931;

-- Set Waypoints
DELETE FROM `waypoint_data` WHERE (`id` IN (1272070, 1271110));
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
("1272070", 1, 1844.9067, 743.2189, 136.38834, NULL, 0, 1, 0, 100, 0),
("1272070", 2, 1817.4067, 743.2189, 120.388336, NULL, 0, 1, 0, 100, 0),
("1272070", 3, 1777.2518, 743.6567, 119.87546, NULL, 0, 1, 0, 100, 0),
("1271110", 1, 1875.0017, 743.1162, 136.34253, NULL, 0, 1, 0, 100, 0),
("1271110", 2, 1850.7517, 743.3662, 136.09253, NULL, 0, 1, 0, 100, 0),
("1271110", 3, 1845.94, 743.354, 136.0013, NULL, 0, 1, 0, 100, 0);

-- Add Drakkari Raiders
DELETE FROM `creature` WHERE (`id1` = 29982);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(127217, 29982, 0, 0, 604, 0, 0, 3, 1, 0, 1865.06, 742.781, 136.401, 3.14159, 3600, 0, 0, 16291, 0, 0, 0, 0, 0, '', 0, 0, ''),
(127225, 29982, 0, 0, 604, 0, 0, 3, 1, 0, 1865.06, 742.781, 136.401, 3.14159, 3600, 0, 0, 16291, 0, 0, 0, 0, 0, '', 0, 0, ''),
(127226, 29982, 0, 0, 604, 0, 0, 3, 1, 0, 1865.06, 742.781, 136.401, 3.14159, 3600, 0, 0, 16291, 0, 0, 0, 0, 0, '', 0, 0, '');

-- Set SmartAI for Doodad
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 192633;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 192633);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(192633, 1, 0, 0, 38, 0, 100, 0, 0, 1, 0, 0, 0, 0, 80, 19263300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doodad_GunDrak_Collision_01 - On Data Set 0 1 - Run Script');

-- Set Action List for Doodad
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 19263300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19263300, 9, 0, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 45, 0, 2, 0, 0, 0, 0, 10, 127207, 29931, 0, 0, 0, 0, 0, 0, 'Doodad_GunDrak_Collision_01 - Actionlist - Set Data 0 2'),
(19263300, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 2, 0, 0, 0, 0, 10, 127111, 29838, 0, 0, 0, 0, 0, 0, 'Doodad_GunDrak_Collision_01 - Actionlist - Set Data 0 2');

-- Set Extra Flag DONT_OVERRIDE_SAI_ENTRY
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |134217728 WHERE (`entry` IN (29838, 29982));

-- Set Comment.
UPDATE `creature` SET `Comment` = 'has Personal SAI' WHERE (`id1` IN (29838, 29982)) AND (`guid` IN (127111, 127217, 127225, 127226));

-- Set Personal SmartAI for the first Rhino
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -127111);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-127111, 0, 2, 0, 38, 0, 100, 0, 0, 2, 0, 0, 0, 0, 232, 1271110, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - On Data Set 0 2 - Start Path 1271110'),
(-127111, 0, 3, 0, 108, 0, 100, 0, 3, 1271110, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - On Point 3 of Path 1271110 Reached - Set Home Position');

-- Set SmartAI for the Second Rhino.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29931;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29931);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29931, 0, 0, 0, 9, 0, 100, 514, 0, 0, 8000, 8000, 5, 40, 11, 55530, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - Within 5-40 Range - Cast \'Charge\' (Normal Dungeon)'),
(29931, 0, 1, 0, 9, 0, 100, 516, 0, 0, 8000, 8000, 5, 40, 11, 58991, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - Within 5-40 Range - Cast \'Charge\' (Heroic Dungeon)'),
(29931, 0, 2, 0, 0, 0, 100, 514, 0, 10000, 8000, 22000, 0, 0, 11, 55663, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - In Combat - Cast \'Deafening Roar\' (Normal Dungeon)'),
(29931, 0, 3, 0, 0, 0, 100, 516, 0, 10000, 8000, 22000, 0, 0, 11, 58992, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - In Combat - Cast \'Deafening Roar\' (Heroic Dungeon)'),
(29931, 0, 4, 0, 38, 0, 100, 0, 0, 2, 0, 0, 0, 0, 232, 1272070, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - On Data Set 0 2 - Start Path 1272070'),
(29931, 0, 5, 6, 108, 0, 100, 0, 3, 1272070, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - On Point 3 of Path 1272070 Reached - Set Home Position'),
(29931, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 3, 0, 0, 0, 0, 10, 127217, 29982, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - On Point 3 of Path 1272070 Reached - Set Data 0 3'),
(29931, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 3, 0, 0, 0, 0, 10, 127225, 29982, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - On Point 3 of Path 1272070 Reached - Set Data 0 3'),
(29931, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 3, 0, 0, 0, 0, 10, 127226, 29982, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - On Point 3 of Path 1272070 Reached - Set Data 0 3');

-- Set SmartAI for Drakkari Raiders
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29982;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29982);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29982, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 46598, 0, 0, 0, 0, 0, 10, 127207, 29931, 0, 0, 0, 0, 0, 0, 'Drakkari Raider - On Initialize - Cast \'Ride Vehicle Hardcoded\''),
(29982, 0, 1, 0, 0, 0, 100, 0, 2000, 6000, 5000, 11000, 0, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Raider - In Combat - Cast \'Cleave\'');

-- Set Personal SmartAI for Drakkari Raiders
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-127217, -127225, -127226));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-127217, 0, 2, 3, 38, 0, 100, 0, 0, 3, 0, 0, 0, 0, 28, 46598, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Raider - On Data Set 0 3 - Remove Aura \'Ride Vehicle Hardcoded\''),
(-127217, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 203, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Raider - On Data Set 0 3 - Exit vehicle'),
(-127217, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1773.92, 748.702, 119.4, 3.1151, 'Drakkari Raider - On Data Set 0 3 - Set Home Position'),
(-127225, 0, 2, 3, 38, 0, 100, 0, 0, 3, 0, 0, 0, 0, 28, 46598, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Raider - On Data Set 0 3 - Remove Aura \'Ride Vehicle Hardcoded\''),
(-127225, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 203, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Raider - On Data Set 0 3 - Exit vehicle'),
(-127225, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1769.33, 743.685, 119.4, 3.1151, 'Drakkari Raider - On Data Set 0 3 - Set Home Position'),
(-127226, 0, 2, 3, 38, 0, 100, 0, 0, 3, 0, 0, 0, 0, 28, 46598, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Raider - On Data Set 0 3 - Remove Aura \'Ride Vehicle Hardcoded\''),
(-127226, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 203, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Raider - On Data Set 0 3 - Exit vehicle'),
(-127226, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1771.29, 738.667, 119.4, 3.1151, 'Drakkari Raider - On Data Set 0 3 - Set Home Position');

-- Correct exit points (I was unable to find another solution).
DELETE FROM `vehicle_seat_addon` WHERE `SeatEntry` IN (2178, 2179, 2180);
INSERT INTO `vehicle_seat_addon` (`SeatEntry`, `SeatOrientation`, `ExitParamX`, `ExitParamY`, `ExitParamZ`, `ExitParamO`, `ExitParamValue`) VALUES
(2178, 0, 7.9178,  0.0000, -0.4759, 0, 1),
(2179, 0, 5.9427, -5.0106, -0.4759, 0, 1),
(2180, 0, 3.3464,  5.0329, -0.4759, 0, 1);

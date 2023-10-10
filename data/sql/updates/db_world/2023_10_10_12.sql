-- DB update 2023_10_10_11 -> 2023_10_10_12
-- Witchbane Torch
SET @GUID := 5448;
DELETE FROM `gameobject` WHERE `guid`=@GUID;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(@GUID, 186425, 1, 0, 0, 1, 1, -2967.03, -3872.18, 33.0928, 2.24779, 0, 0, -0.90179, -0.432175, -20, 255, 1, '', 0, '');

DELETE FROM `event_scripts` WHERE `id`=15452;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(15452,0,9,@GUID,20,0,0,0,0,0);

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 186425;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 186425);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(186425, 1, 0, 0, 70, 0, 100, 0, 1, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 4792, 0, 0, 0, 0, 0, 0, 0, 'Witchbane Torch - On Gameobject State Changed - Set Data 1 1 to \'Swamp Eye\' Jarl');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (42517,42515);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,42517,0,0,31,0,3,23869,0,0,0,0,'','Spell \'Beam to Zelfrax\' can only target \'Invis Zelfrax Origin\''),
(13,1,42515,0,0,31,0,3,23868,0,0,0,0,'','Spell \'Jarl Beam\' can only target \'Invis Zelfrax Target\'');

-- "Swamp Eye" Jarl
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=4792;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4792 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=479200 AND `source_type`=9;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4792, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 80, 479200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '\'Swamp Eye\' Jarl - On Data Set 1 1 - Run Script'),
(479200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 42515, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '\'Swamp Eye\' Jarl - Actionlist - Cast \'Jarl Beam\''),
(479200, 9, 1, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 86, 42517, 0, 19, 23868, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '\'Swamp Eye\' Jarl - Actionlist - Cross Cast \'Beam to Zelfrax\''),
(479200, 9, 2, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 12, 23864, 3, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -2984.98, -3853.72, 45.7142, 5.44525, '\'Swamp Eye\' Jarl - Actionlist - Summon Creature \'Zelfrax\'');

-- Zelfrax
DELETE FROM `waypoints` WHERE `entry` = 23864;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(23864, 1, -2965.74, -3873.83, 33.3183, NULL, 0, '');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' ,`unit_flags` = `unit_flags`&~(768) WHERE `entry` = 23864;
DELETE FROM `smart_scripts` WHERE `entryorguid`=23864 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2386400,2386401) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23864, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zelfrax - On Just Summoned - Set Flags Immune To Players & Immune To NPC\'s'),
(23864, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2386400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zelfrax - On Just Summoned - Run Script'),
(23864, 0, 2, 0, 40, 0, 100, 0, 1, 23864, 0, 0, 0, 0, 80, 2386401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zelfrax - On Point 1 of Path 23864 Reached - Run Script'),
(2386400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zelfrax - Actionlist - Say Line 0'),
(2386400, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zelfrax - Actionlist - Say Line 1'),
(2386400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 1, 23864, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zelfrax - Actionlist - Start Waypoint Path 23864'),
(2386401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zelfrax - Actionlist - Set Home Position'),
(2386401, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zelfrax - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(2386401, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Zelfrax - Actionlist - Start Attacking');

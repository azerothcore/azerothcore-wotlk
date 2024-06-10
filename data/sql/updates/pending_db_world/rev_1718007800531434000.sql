 -- Apprentice Morlann smart ai
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23600;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23600) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23600, 0, 0, 0, 1, 0, 100, 0, 0, 0, 143957, 143957, 0, 0, 53, 0, 23600, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - Out of Combat - Start Waypoint Path 23600'),
(23600, 0, 1, 2, 40, 0, 100, 0, 1, 23600, 0, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Point 1 of Path 23600 Reached - Pause Waypoint'),
(23600, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Point 1 of Path 23600 Reached - Say Line 0'),
(23600, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 4000, 4000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Point 1 of Path 23600 Reached - Create Timed Event'),
(23600, 0, 4, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Timed Event 1 Triggered - Resume Waypoint'),
(23600, 0, 5, 6, 40, 0, 100, 0, 5, 23600, 0, 0, 0, 0, 54, 13000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Point 5 of Path 23600 Reached - Pause Waypoint'),
(23600, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Point 5 of Path 23600 Reached - Say Line 1'),
(23600, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 2, 5000, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Point 5 of Path 23600 Reached - Create Timed Event'),
(23600, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 3, 14000, 14000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Point 5 of Path 23600 Reached - Create Timed Event'),
(23600, 0, 9, 10, 59, 0, 100, 0, 2, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Timed Event 2 Triggered - Set Flag Standstate Kneel'),
(23600, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Timed Event 2 Triggered - Say Line 2'),
(23600, 0, 11, 12, 59, 0, 100, 0, 3, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Timed Event 3 Triggered - Remove FlagStandstate Kneel'),
(23600, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Timed Event 3 Triggered - Resume Waypoint'),
(23600, 0, 13, 14, 58, 0, 100, 0, 6, 23600, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Path 23600 Finished - Stop Waypoint'),
(23600, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3.87463, 'Apprentice Morlann - On Path 23600 Finished - Set Orientation 3.87463');

DELETE FROM `waypoints` WHERE `entry`=23600;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES 
(23600, 1, -4044.12, -3393.59, 38.1363, NULL, 0, 'Apprentice Morlann Points'),
-- WayPoints
(23600, 2, -4044.21, -3394.23, 38.3905, NULL, 0, 'Apprentice Morlann WayPoints'),
-- WayPoints
(23600, 3, -4042.96, -3396.48, 38.3905, NULL, 0, 'Apprentice Morlann WayPoints'),
-- WayPoints
(23600, 4, -4041.71, -3397.23, 38.3905, NULL, 0, 'Apprentice Morlann WayPoints'),
(23600, 5, -4040.8, -3396.88, 38.1447, NULL, 0, 'Apprentice Morlann Points'),
(23600, 6, -4043.67, -3395.27, 38.1634, NULL, 0, 'Apprentice Morlann Points');

--  set MovementType
DELETE FROM `creature` WHERE (`id1` = 23600) AND (`guid` IN (18604));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(18604, 23600, 0, 0, 1, 0, 0, 1, 1, 0, -4043.43, -3395.4, 38.2663, 3.87463, 360, 0, 0, 1093, 1142, 0, 0, 0, 0, '', 0);

-- del path_id
DELETE FROM `creature_addon` WHERE (`guid` IN (18604));

DELETE FROM `creature_text` WHERE `CreatureID` = 23600;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23600, 0, 0, 'Hmm... I wonder...', 12, 0, 100, 6, 0, 0, 22042, 0, 'Apprentice Morlann'),
(23600, 1, 0, 'Now, where is it?', 12, 0, 100, 1, 0, 0, 22045, 0, 'Apprentice Morlann'),
(23600, 2, 0, 'Stupid mages... always using the last of a reagent and never replacing it.', 12, 0, 100, 0, 0, 0, 22043, 0, 'Apprentice Morlann');
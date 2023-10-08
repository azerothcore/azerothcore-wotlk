-- DB update 2023_10_08_02 -> 2023_10_08_03
-- "Dirty" Michael Crowe
DELETE FROM `waypoint_data` WHERE `id`=306490;
DELETE FROM `waypoint_scripts` WHERE `id`=23;
DELETE FROM `creature_addon` WHERE `guid` = 30649;
UPDATE `creature` SET `MovementType` = 0 WHERE `id1` = 23896 AND `guid` = 30649;

DELETE FROM `creature_template_addon` WHERE (`entry` = 23896);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(23896, 0, 0, 0, 1, 0, 0, '');

DELETE FROM `creature_text` WHERE `CreatureID`=23896;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23896, 0, 0, 'You might wanna stand back. Fish guttin\' is a dirty job.', 12, 0, 100, 1, 0, 0, 22392, 0, '"Dirty" Michael Crowe');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23896;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23896);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23896, 0, 0, 0, 1, 0, 100, 0, 60000, 120000, 60000, 120000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Dirty" Michael Crowe - Out of Combat - Say Line 0');

-- DB update 2023_04_04_01 -> 2023_04_04_02
-- ID 8397 (Sentinel Keldara Sunblade)
DELETE FROM `creature_addon` WHERE (`guid` IN (35937));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(35937, 0, 0, 0, 1, 0, 0, '');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8397;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 8397);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8397, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Keldara Sunblade - On Aggro - Remove FlagStandstate Dead'),
(8397, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Keldara Sunblade - On Reset - Set Flag Standstate Dead');

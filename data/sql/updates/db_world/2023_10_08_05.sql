-- DB update 2023_10_08_04 -> 2023_10_08_05
-- Terrorclaw 
DELETE FROM `creature_template_addon` WHERE (`entry` = 20477);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(20477, 0, 0, 0, 0, 0, 0, '35408');

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 20477;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20477, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 5000, 9000, 0, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Terrorclaw - In Combat - Cast \'Cleave\'');

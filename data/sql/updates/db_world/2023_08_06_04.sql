-- DB update 2023_08_06_03 -> 2023_08_06_04
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17350;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17350);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17350, 0, 0, 0, 0, 0, 100, 0, 1500, 1500, 10500, 10500, 11, 36332, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Royal Blue Flutterer - In Combat - Cast \'36332\'');

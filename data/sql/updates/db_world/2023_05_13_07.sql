-- DB update 2023_05_13_06 -> 2023_05_13_07
--
UPDATE `smart_scripts` SET `comment` = 'Windroc - In Combat - Cast \'Eagle Claw\'' WHERE `entryorguid` = 17128 AND `source_type` = 0 AND `id` = 0;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `Entry` = 18220;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 18220 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18220, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 10000, 20000, 0, 11, 30285, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ravenous Windroc - In Combat - Cast \'Eagle Claw\'');

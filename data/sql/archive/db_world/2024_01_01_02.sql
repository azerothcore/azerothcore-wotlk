-- DB update 2024_01_01_01 -> 2024_01_01_02
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17604;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 17604 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17604, 0, 0, 0, 26, 0, 100, 1, 0, 10, 0, 1, 0, 0, 11, 31734, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Spy - In Combat LOS 10 yards - Cast \'31734\' (No Repeat)'),
(17604, 0, 1, 0, 0, 0, 100, 0, 4800, 29700, 16140, 25110, 0, 0, 11, 13730, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Spy - In Combat - Cast \'Demoralizing Shout\''),
(17604, 0, 2, 0, 0, 0, 100, 0, 6450, 9380, 9700, 21250, 0, 0, 11, 31827, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Spy - In Combat - Cast \'Heroic Strike\'');

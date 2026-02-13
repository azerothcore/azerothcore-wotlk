-- DB update 2024_12_02_03 -> 2024_12_02_04
--

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27499;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27499);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27499, 0, 0, 1, 19, 0, 100, 0, 12308, 0, 0, 0, 0, 0, 86, 48710, 0, 19, 24042, 0, 0, 19, 24042, 20, 0, 0, 0, 0, 0, 0, 'Caged Prisoner - On Quest \'Escape from Silverbrook\' Taken - Cast \'Summon Freed Alliance Scout\''),
(27499, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 15, 188706, 10, 0, 0, 0, 0, 0, 0, 'Caged Prisoner - On Quest \'Escape from Silverbrook\' Taken - Activate Gameobject'),
(27499, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caged Prisoner - On Quest \'Escape from Silverbrook\' Taken - Despawn In 500 ms');

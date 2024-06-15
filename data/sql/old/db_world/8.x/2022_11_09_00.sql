-- DB update 2022_11_08_01 -> 2022_11_09_00

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17058;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17058) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17058, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 36, 19477, 0, 0, 0, 0, 0, 9, 16938, 0, 20, 1, 0, 0, 0, 0, 'Illidari Taskmaster - On Just Died - Update Template To \'Fleeing Dreghood Warrior\''),
(17058, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 36, 19477, 0, 0, 0, 0, 0, 9, 16937, 0, 20, 1, 0, 0, 0, 0, 'Illidari Taskmaster - On Just Died - Update Template To \'Fleeing Dreghood Warrior\''),
(17058, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 2, 15, 0, 0, 0, 0, 0, 9, 19477, 0, 20, 0, 0, 0, 0, 0, 'Illidari Taskmaster - On Just Died - Set Faction 15'),
(17058, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 17, 470, 0, 0, 0, 0, 0, 9, 19477, 0, 20, 1, 0, 0, 0, 0, 'Illidari Taskmaster - On Just Died - Set Emote State 470'),
(17058, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 9, 19477, 0, 20, 1, 0, 0, 0, 0, 'Illidari Taskmaster - On Just Died - Evade'),
(17058, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 9, 19477, 0, 20, 1, 0, 0, 0, 0, 'Illidari Taskmaster - On Just Died - Say Line 0'),
(17058, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 9, 19477, 0, 20, 1, 0, 0, 0, 0, 'Illidari Taskmaster - On Just Died - Start Random Movement'),
(17058, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 9, 19477, 0, 20, 1, 0, 0, 0, 0, 'Illidari Taskmaster - On Just Died - Despawn In 10000 ms');

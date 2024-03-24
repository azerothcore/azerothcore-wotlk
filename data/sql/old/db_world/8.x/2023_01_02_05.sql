-- DB update 2023_01_02_04 -> 2023_01_02_05
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19399;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19399);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19399, 0, 0, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 41, 3000, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Cannon - On Just Died - Despawn In 3000 ms'),
(19399, 0, 1, 0, 1, 0, 100, 513, 1000, 1000, 1000, 1000, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Cannon - Out of Combat - Disable Combat Movement (No Repeat)'),
(19399, 0, 2, 0, 0, 0, 100, 0, 0, 1000, 2500, 2500, 0, 11, 36238, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Cannon - In Combat - Cast \'Fel Cannon Blast\'');

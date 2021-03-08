INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615207809116814300');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3375;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3375);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3375, 0, 0, 0, 0, 0, 100, 1, 100, 100, 1000, 1000, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Foreman - In Combat - Enable Combat Movement (No Repeat)'),
(3375, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 3000, 4000, 0, 11, 6257, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Foreman - In Combat - Cast \'Torch Toss\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5849;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 5849);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5849, 0, 0, 0, 0, 0, 80, 0, 12500, 12500, 10000, 10000, 0, 11, 6253, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Digger Flameforge - In Combat - Cast \'Backhand\''),
(5849, 0, 1, 0, 0, 0, 100, 1, 100, 100, 1000, 1000, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Digger Flameforge - In Combat - Enable Combat Movement (No Repeat)'),
(5849, 0, 2, 0, 0, 0, 100, 0, 2000, 2000, 2000, 2000, 0, 11, 7978, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Digger Flameforge - In Combat - Cast \'Throw Dynamite\'');

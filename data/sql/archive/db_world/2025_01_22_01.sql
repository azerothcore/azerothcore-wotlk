-- DB update 2025_01_22_00 -> 2025_01_22_01

-- Shoveltusk Stag
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23691;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23691);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23691, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 55860, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shoveltusk Stag - On Aggro - Cast \'Shoveltusk Charge\''),
(23691, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 20000, 30000, 0, 0, 11, 32019, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shoveltusk Stag - In Combat - Cast \'Gore\'');

-- Shoveltusk Forager
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29479;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29479);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29479, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 55860, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shoveltusk Stag - On Aggro - Cast \'Shoveltusk Charge\''),
(29479, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 20000, 30000, 0, 0, 11, 32019, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shoveltusk Stag - In Combat - Cast \'Gore\'');

-- Shoveltuck
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23690;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23690);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23690, 0, 0, 0, 0, 0, 100, 0, 8000, 14000, 15000, 24000, 0, 0, 11, 42320, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shoveltusk - In Combat - Cast \'Head Butt\'');

-- Shoveltuck Calf
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24791;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24791);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24791, 0, 0, 0, 0, 0, 100, 0, 8000, 14000, 15000, 24000, 0, 0, 11, 42320, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shoveltusk - In Combat - Cast \'Head Butt\'');

-- Tamed Shoveltusk
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29486;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29486);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29486, 0, 0, 0, 0, 0, 100, 0, 8000, 14000, 15000, 24000, 0, 0, 11, 42320, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shoveltusk - In Combat - Cast \'Head Butt\'');

-- Tamed Shoveltusk
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29487;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29487);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29487, 0, 0, 0, 0, 0, 100, 0, 8000, 14000, 15000, 24000, 0, 0, 11, 42320, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shoveltusk - In Combat - Cast \'Head Butt\'');

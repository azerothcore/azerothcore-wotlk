-- DB update 2023_01_02_02 -> 2023_01_02_03
-- On spawn set the modelID to model 25749 to fix the golem model

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28882) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28882, 0, 2, 0, 11, 0, 100, 1, 0, 0, 0, 0, 0, 3, 0, 25749, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enchanted Tiki Warrior - On Respawn - Morph To Model 25749 (No Repeat)');

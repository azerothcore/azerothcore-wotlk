-- Updates 4690 so it moves randomly instead of just standing there.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4690;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4690);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4690, 0, 0, 0, 0, 0, 100, 1, 2500, 5000, 0, 0, 0, 11, 3150, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rabid Bonepaw - In Combat - Cast \'3150\' (No Repeat)'),
(4690, 0, 1, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '');


UPDATE `creature_template` SET `MovementType` = 0 WHERE (`entry` = 4690);
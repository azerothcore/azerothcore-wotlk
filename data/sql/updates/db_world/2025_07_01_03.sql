-- DB update 2025_07_01_02 -> 2025_07_01_03

-- Scourge Gryphons
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28906;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28906);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28906, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Gryphon - On Just Summoned - Set Reactstate Passive'),
(28906, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 87, 2890600, 2890601, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Gryphon - On Just Summoned - Run Random Script'),
(28906, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 37, 300000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Gryphon - On Just Summoned - Kill Self'),
(28906, 0, 3, 4, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 233, 2890600, 2890604, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Gryphon - On Reached Point 1 - Start Random Path 2890600-2890604'),
(28906, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Gryphon - On Reached Point 1 - Set Reactstate Aggressive');

-- Scarlet Ghouls
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28897;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28897);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28897, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2889700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Ghoul - On Just Summoned - Run Script'),
(28897, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 37, 300000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Ghoul - On Just Summoned - Kill Self'),
(28897, 0, 2, 0, 58, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Ghoul - On Path 0 Finished - Start Random Movement'),
(28897, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 205, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Ghoul - On Reset - Set combat distance to 30');

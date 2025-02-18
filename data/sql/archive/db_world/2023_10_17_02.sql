-- DB update 2023_10_17_01 -> 2023_10_17_02
-- Midsummer Celebrants - Applause/Cheer
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 16781;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16781);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16781, 0, 0, 1, 8, 0, 100, 0, 45407, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Midsummer Celebrant - On Spellhit \'Reveler - Applause/Cheer\' - Set Orientation Invoker'),
(16781, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 1678100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Midsummer Celebrant - On Spellhit \'Reveler - Applause/Cheer\' - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1678100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1678100, 9, 0, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 0, 10, 4, 21, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Midsummer Celebrant - Actionlist - Play Random Emote (4, 21)'),
(1678100, 9, 1, 0, 0, 0, 100, 0, 4200, 4200, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Midsummer Celebrant - Actionlist - Set Orientation Home Position');


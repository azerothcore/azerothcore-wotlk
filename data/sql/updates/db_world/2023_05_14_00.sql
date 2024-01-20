-- DB update 2023_05_13_15 -> 2023_05_14_00
-- 21151 (Borgrim Stouthammer)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21151;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21151);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21151, 0, 0, 0, 20, 0, 100, 0, 10511, 0, 0, 0, 0, 80, 2115100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Borgrim Stouthammer - On Quest \'Strange Brew\' Finished - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2115100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2115100, 9, 0, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Borgrim Stouthammer - Actionlist - Say Line 0');

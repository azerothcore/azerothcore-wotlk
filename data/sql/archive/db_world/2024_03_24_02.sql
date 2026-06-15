-- DB update 2024_03_24_01 -> 2024_03_24_02

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6268;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 6268);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6268, 0, 0, 0, 0, 0, 100, 0, 5000, 11000, 11000, 17000, 0, 0, 11, 2691, 256, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 0, 'Summoned Felhunter - In Combat - Cast \'Mana Burn\''),
(6268, 0, 1, 2, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Felhunter - On Just Summoned -set faction 35'),
(6268, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 626800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Felhunter - On Just Summoned - Run Script'),
(6268, 0, 3, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 6251, 0, 60, 0, 0, 0, 0, 0, 'Summoned Felhunter - On Just Died - Set Data 1 1'),
(6268, 0, 4, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Felhunter - On Reached_Home - Despawn');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 626800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(626800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 7741, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Felhunter - On Script - Cast SpellId7741'),
(626800, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Felhunter - On Script - SetReactState  Aggressive '),
(626800, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Felhunter - On Script - Set faction 14'),
(626800, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Felhunter - On Script - attack start to action invoker');

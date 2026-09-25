-- DB update 2025_03_25_00 -> 2025_03_25_01
-- Update Alumeth the Ascended 32300 to repeat around psychicscream ~20 sec
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32300;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 32300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32300, 0, 0, 0, 0, 0, 100, 0, 8000, 9000, 8000, 9000, 0, 0, 11, 60472, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Alumeth the Ascended - In Combat - Cast \'Mind Flay\''),
(32300, 0, 1, 0, 0, 0, 100, 0, 8000, 10000, 18000, 22000, 0, 0, 11, 34322, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Alumeth the Ascended - In Combat - Cast \'Psychic Scream\''),
(32300, 0, 2, 0, 0, 0, 100, 0, 9000, 12000, 9000, 12000, 0, 0, 11, 37978, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alumeth the Ascended - In Combat - Cast \'Renew\''),
(32300, 0, 3, 0, 0, 0, 100, 0, 7000, 10000, 7000, 10000, 0, 0, 11, 34942, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Alumeth the Ascended - In Combat - Cast \'Shadow Word: Pain\'');

-- Shadowy Summoner
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17088);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17088, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 8722, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Summoner - On Reset - Cast \'Summon Succubus\''),
(17088, 0, 1, 0, 0, 0, 100, 0, 6000, 15000, 21000, 35000, 0, 0, 11, 32940, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Summoner - In Combat - Cast \'Shadow Rush\''),
(17088, 0, 2, 0, 9, 0, 100, 0, 1500, 1500, 1500, 1500, 5, 30, 11, 13878, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Summoner - Within 5-30 Range - Cast \'Scorch\''),
(17088, 0, 3, 0, 9, 0, 100, 0, 5000, 10000, 5000, 10000, 0, 5, 11, 13878, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Summoner - Within 0-5 Range - Cast \'Scorch\'');

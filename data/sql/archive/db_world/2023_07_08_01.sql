-- DB update 2023_07_08_00 -> 2023_07_08_01
-- remove old SAI trying to script mob behaviour (see AC issue for old SAI) and add simple behaviour equivalent to Riverpaw Mystic
DELETE FROM `smart_scripts` WHERE `entryorguid` = 16337 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16337, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3400, 4800, 0, 11, 20802, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackpaw Shaman - In Combat CMC - Cast \'Lightning Bolt\''),
(16337, 0, 1, 0, 2, 0, 100, 1, 0, 30, 15000, 25000, 0, 11, 28902, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackpaw Shaman - Between 0-30% Health - Cast \'Bloodlust\''),
(16337, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackpaw Shaman - Between 0-15% Health - Flee For Assist (No Repeat)');

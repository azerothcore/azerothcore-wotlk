--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21251);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21251, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2125100, 2125102, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Reset - Run Random Script'),
(21251, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 31, 1, 12, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Reset - Set Phase Random Between 1-12'),
(21251, 0, 2, 0, 0, 15, 100, 0, 14600, 19700, 21400, 33100, 0, 0, 11, 38976, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast \'Spore Quake\' (Phases 1 & 2 & 3 & 4)'),
(21251, 0, 3, 0, 0, 15, 100, 0, 5700, 11400, 14400, 24900, 0, 0, 11, 39032, 0, 0, 0, 0, 0, 5, 0, 1, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast \'Initial Infection\' (Phases 1 & 2 & 3 & 4)'),
(21251, 0, 4, 0, 0, 240, 100, 0, 16800, 22400, 27700, 31200, 0, 0, 11, 38971, 0, 0, 0, 0, 0, 6, 0, 1, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast \'Acid Geyser\' (Phases 5 & 6 & 7 & 8)'),
(21251, 0, 5, 0, 0, 240, 100, 0, 9400, 14500, 21200, 32400, 0, 0, 11, 39044, 0, 0, 0, 0, 0, 5, 0, 1, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast \'Serpentshrine Parasite\' (Phases 5 & 6 & 7 & 8)'),
(21251, 0, 6, 0, 9, 3840, 100, 0, 2400, 6800, 2400, 6800, 0, 5, 11, 39015, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - Within 0-5 Range - Cast \'Atrophic Blow\' (Phases 9 & 10 & 11 & 12)'),
(21251, 0, 7, 0, 0, 3840, 100, 0, 6700, 10900, 16100, 21800, 0, 0, 11, 39031, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast \'Enrage\' (Phases 9 & 10 & 11 & 12)'),
(21251, 0, 8, 0, 6, 273, 100, 0, 0, 0, 0, 0, 0, 0, 11, 38718, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Just Died - Cast \'Toxic Pool\' (Phases 1 & 5 & 9)'),
(21251, 0, 9, 0, 6, 546, 100, 0, 0, 0, 0, 0, 0, 0, 11, 38922, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Just Died - Cast \'Serverside - Summon Colossus Lurkers\' (Phases 2 & 6 & 10)'),
(21251, 0, 10, 0, 6, 1092, 100, 0, 0, 0, 0, 0, 0, 0, 11, 38928, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Just Died - Cast \'Serverside - Summon Colossus Ragers\' (Phases 3 & 7 & 11)'),
(21251, 0, 11, 12, 6, 2184, 100, 0, 0, 0, 0, 0, 0, 0, 11, 38726, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Just Died - Cast \'Serverside - Summon Serpentshrine Mushroom\' (Phases 4 & 8 & 12)'),
(21251, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 38726, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Just Died - Cast \'Serverside - Summon Serpentshrine Mushroom\' (Phases 4 & 8 & 12)'),
(21251, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 38726, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Just Died - Cast \'Serverside - Summon Serpentshrine Mushroom\' (Phases 4 & 8 & 12)'),
(21251, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 38726, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Just Died - Cast \'Serverside - Summon Serpentshrine Mushroom\' (Phases 4 & 8 & 12)'),
(21251, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 38726, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Just Died - Cast \'Serverside - Summon Serpentshrine Mushroom\' (Phases 4 & 8 & 12)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 22335);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22335, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 38730, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mushrom Spell Effect - On Respawn - Cast \'Refreshing Mist\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 2125100 AND 2125102);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2125100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 38714, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - Actionlist - Cast \'Frost Vulnerability\''),
(2125101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 38715, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - Actionlist - Cast \'Fire Vulnerability\''),
(2125102, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 38717, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - Actionlist - Cast \'Nature Vulnerability\'');

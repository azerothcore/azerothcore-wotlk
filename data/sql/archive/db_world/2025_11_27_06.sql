-- DB update 2025_11_27_05 -> 2025_11_27_06
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27719);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27719, 0, 0, 0, 19, 0, 100, 0, 12427, 0, 0, 0, 0, 0, 80, 2771900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - On Quest \'The Conquest Pit: Bear Wrestling!\' Taken - Run Script'),
(27719, 0, 1, 0, 19, 0, 100, 0, 12428, 0, 0, 0, 0, 0, 80, 2771910, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - On Quest \'The Conquest Pit: Mad Furbolg Fighting\' Taken - Run Script'),
(27719, 0, 2, 0, 19, 0, 100, 0, 12429, 0, 0, 0, 0, 0, 80, 2771920, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - On Quest \'The Conquest Pit: Blood and Metal\' Taken - Run Script'),
(27719, 0, 3, 0, 19, 0, 100, 0, 12430, 0, 0, 0, 0, 0, 80, 2771930, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - On Quest \'The Conquest Pit: Death Is Likely\' Taken - Run Script'),
(27719, 0, 4, 0, 19, 0, 100, 0, 12431, 0, 0, 0, 0, 0, 80, 2771940, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - On Quest \'The Conquest Pit: Final Showdown\' Taken - Run Script'),
(27719, 0, 5, 0, 38, 0, 100, 0, 0, 1, 0, 0, 0, 0, 80, 2771901, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - On Data Set 0 1 - Run Script'),
(27719, 0, 6, 0, 38, 0, 100, 0, 0, 2, 0, 0, 0, 0, 80, 2771902, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - On Data Set 0 2 - Run Script'),
(27719, 0, 7, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 80, 2771911, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - On Data Set 1 1 - Run Script'),
(27719, 0, 8, 0, 38, 0, 100, 0, 1, 2, 0, 0, 0, 0, 80, 2771912, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - On Data Set 1 2 - Run Script'),
(27719, 0, 9, 0, 38, 0, 100, 0, 2, 1, 0, 0, 0, 0, 80, 2771921, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - On Data Set 2 1 - Run Script'),
(27719, 0, 10, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 0, 80, 2771922, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - On Data Set 2 2 - Run Script'),
(27719, 0, 11, 0, 38, 0, 100, 0, 3, 1, 0, 0, 0, 0, 80, 2771931, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - On Data Set 3 1 - Run Script'),
(27719, 0, 12, 0, 38, 0, 100, 0, 3, 2, 0, 0, 0, 0, 80, 2771932, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - On Data Set 3 2 - Run Script'),
(27719, 0, 13, 0, 38, 0, 100, 0, 4, 1, 0, 0, 0, 0, 80, 2771941, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - On Data Set 4 1 - Run Script'),
(27719, 0, 14, 0, 38, 0, 100, 0, 4, 2, 0, 0, 0, 0, 80, 2771942, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - On Data Set 4 2 - Run Script');

-- Quest start actionlists
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2771900, 2771910, 2771920, 2771930, 2771940));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2771900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Store Targetlist'),
(2771900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Store Targetlist'),
(2771900, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Remove Npc Flags Questgiver'),
(2771900, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Say Line 0'),
(2771900, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 27715, 6, 5000, 0, 0, 0, 8, 0, 0, 0, 0, 3242.77, -2340.98, 92.34, 0.98, 'Gurgthock - Actionlist - Summon Creature \'Ironhide\''),
(2771910, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Store Targetlist'),
(2771910, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Store Targetlist'),
(2771910, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Remove Npc Flags Questgiver'),
(2771910, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Say Line 1'),
(2771910, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 27716, 6, 5000, 0, 0, 0, 8, 0, 0, 0, 0, 3242.77, -2340.98, 92.34, 0.98, 'Grennix Shivwiggle - Actionlist - Summon Creature \'Torgg Thundertotem\''),
(2771920, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Store Targetlist'),
(2771920, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Store Targetlist'),
(2771920, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Remove Npc Flags Questgiver'),
(2771920, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Say Line 2'),
(2771920, 9, 4, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 3, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Say Line 3'),
(2771920, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 27717, 6, 5000, 0, 0, 0, 8, 0, 0, 0, 0, 3242.77, -2340.98, 92.34, 0.98, 'Grennix Shivwiggle - Actionlist - Summon Creature \'Rustblood\''),
(2771930, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Store Targetlist'),
(2771930, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Store Targetlist'),
(2771930, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Remove Npc Flags Questgiver'),
(2771930, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 1, 0, 0, 0, 12, 4, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Say Line 4'),
(2771930, 9, 4, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 5, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Say Line 5'),
(2771930, 9, 5, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 1, 6, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Say Line 6'),
(2771930, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 27718, 6, 5000, 0, 0, 0, 8, 0, 0, 0, 0, 3242.77, -2340.98, 92.34, 0.98, 'Grennix Shivwiggle - Actionlist - Summon Creature \'Horgrenn Hellcleave\''),
(2771940, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Store Targetlist'),
(2771940, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Store Targetlist'),
(2771940, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Remove Npc Flags Questgiver'),
(2771940, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 7, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Say Line 7'),
(2771940, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 27727, 6, 5000, 0, 0, 0, 8, 0, 0, 0, 0, 3251.91, -2340.61, 91.86, 3.1, 'Grennix Shivwiggle - Actionlist - Summon Creature \'Conqueror Krenna\'');

-- Quest success and fail actionlists
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (2771901, 2771902, 2771911, 2771912, 2771921, 2771922, 2771931, 2771932, 2771941, 2771942)) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2771901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Add Npc Flags Questgiver'),
(2771901, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 12427, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Quest Credit \'The Conquest Pit: Bear Wrestling!\''),
(2771902, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Add Npc Flags Questgiver'),
(2771902, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 12427, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Fail Quest \'The Conquest Pit: Bear Wrestling!\''),
(2771911, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Add Npc Flags Questgiver'),
(2771911, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 12428, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Quest Credit \'The Conquest Pit: Mad Furbolg Fighting!\''),
(2771912, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Add Npc Flags Questgiver'),
(2771912, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 12428, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Fail Quest \'The Conquest Pit: Mad Furbolg Fighting!\''),
(2771921, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Add Npc Flags Questgiver'),
(2771921, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 12429, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Quest Credit \'The Conquest Pit: Blood and Metal!\''),
(2771922, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Add Npc Flags Questgiver'),
(2771922, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 12429, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Fail Quest \'The Conquest Pit: Blood and Metal!\''),
(2771931, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Add Npc Flags Questgiver'),
(2771931, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 12430, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Quest Credit \'The Conquest Pit: Blood and Metal!\''),
(2771932, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Add Npc Flags Questgiver'),
(2771932, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 12430, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Fail Quest \'The Conquest Pit: Blood and Metal!\''),
(2771941, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 12431, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Quest Credit \'The Conquest Pit: Final Showdown!\''),
(2771941, 9, 1, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Add Npc Flags Questgiver'),
(2771942, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Add Npc Flags Questgiver'),
(2771942, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 12431, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Grennix Shivwiggle - Actionlist - Fail Quest \'The Conquest Pit: Final Showdown!\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (27715, 27716, 27717, 27718, 27727));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27715, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 102451, 27719, 0, 0, 0, 0, 0, 0, 'Ironhide - On Just Died - Set Data 0 1 on Grennix'),
(27715, 0, 1, 2, 1, 0, 100, 1, 30000, 30000, 0, 0, 0, 0, 45, 0, 2, 0, 0, 0, 0, 10, 102451, 27719, 0, 0, 0, 0, 0, 0, 'Ironhide - Out of Combat - Set Data 0 2 on Grennix (No Repeat)'),
(27715, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironhide - Out of Combat - Despawn Instant (No Repeat)'),
(27715, 0, 3, 0, 9, 0, 100, 0, 0, 0, 17000, 24000, 8, 25, 11, 32323, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironhide - Within 8-25 Range - Cast \'Charge\''),
(27715, 0, 4, 0, 0, 0, 100, 0, 5000, 7000, 7000, 9000, 0, 0, 11, 34298, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironhide - In Combat - Cast \'Maul\''),
(27715, 0, 5, 0, 9, 0, 100, 0, 0, 0, 7000, 11000, 0, 5, 11, 31279, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironhide - Within 0-5 Range - Cast \'Swipe\''),
(27716, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 102451, 27719, 0, 0, 0, 0, 0, 0, 'Torgg Thundertotem - On Just Died - Set Data 1 1 on Grennix'),
(27716, 0, 1, 2, 1, 0, 100, 1, 30000, 30000, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 10, 102451, 27719, 0, 0, 0, 0, 0, 0, 'Torgg Thundertotem - Out of Combat - Set Data 1 2 on Grennix (No Repeat)'),
(27716, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Torgg Thundertotem - Out of Combat - Despawn Instant (No Repeat)'),
(27716, 0, 3, 0, 0, 0, 100, 0, 1000, 3000, 6000, 8000, 0, 0, 11, 16033, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Torgg Thundertotem - In Combat - Cast \'Chain Lightning\''),
(27716, 0, 4, 0, 2, 0, 100, 0, 0, 30, 15000, 25000, 0, 0, 11, 15982, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Torgg Thundertotem - Between 0-30% Health - Cast \'Healing Wave\''),
(27716, 0, 5, 0, 0, 0, 100, 0, 0, 0, 21000, 21000, 0, 0, 11, 31991, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Torgg Thundertotem - In Combat - Cast \'Corrupted Nova Totem\''),
(27716, 0, 6, 0, 0, 0, 100, 0, 4000, 4000, 12000, 12000, 0, 0, 11, 15501, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Torgg Thundertotem - In Combat - Cast \'Earth Shock\''),
(27717, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 1, 0, 0, 0, 0, 10, 102451, 27719, 0, 0, 0, 0, 0, 0, 'Rustblood - On Just Died - Set Data 2 1 on Grennix'),
(27717, 0, 1, 2, 1, 0, 100, 1, 30000, 30000, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 10, 102451, 27719, 0, 0, 0, 0, 0, 0, 'Rustblood - Out of Combat - Set Data 2 2 on Grennix (No Repeat)'),
(27717, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rustblood - Out of Combat - Despawn Instant (No Repeat)'),
(27717, 0, 3, 0, 0, 0, 100, 0, 5000, 7000, 5000, 7000, 0, 0, 11, 42746, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rustblood - In Combat - Cast \'Cleave\''),
(27717, 0, 4, 0, 9, 0, 100, 0, 0, 0, 22000, 30000, 0, 5, 11, 49398, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rustblood - Within 0-5 Range - Cast \'Knockback\''),
(27717, 0, 5, 0, 0, 0, 100, 0, 12000, 15000, 18000, 21000, 0, 0, 11, 14102, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rustblood - In Combat - Cast \'Head Smash\''),
(27717, 0, 6, 0, 0, 0, 100, 0, 0, 3000, 12000, 12000, 0, 0, 11, 61893, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rustblood - In Combat - Cast \'Lightning Bolt\''),
(27718, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 3, 1, 0, 0, 0, 0, 10, 102451, 27719, 0, 0, 0, 0, 0, 0, 'Horgrenn Hellcleave - On Just Died - Set Data 3 1 on Grennix'),
(27718, 0, 1, 2, 1, 0, 100, 1, 30000, 30000, 0, 0, 0, 0, 45, 3, 2, 0, 0, 0, 0, 10, 102451, 27719, 0, 0, 0, 0, 0, 0, 'Horgrenn Hellcleave - Out of Combat - Set Data 3 2 on Grennix (No Repeat)'),
(27718, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Horgrenn Hellcleave - Out of Combat - Despawn Instant (No Repeat)'),
(27718, 0, 3, 0, 9, 1, 100, 0, 0, 0, 21000, 29000, 0, 10, 11, 16508, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Horgrenn Hellcleave - Within 0-10 Range - Cast \'Intimidating Roar\' (Phase 1)'),
(27718, 0, 4, 0, 0, 1, 100, 0, 3000, 6000, 8000, 12000, 0, 0, 11, 15572, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Horgrenn Hellcleave - In Combat - Cast \'Sunder Armor\' (Phase 1)'),
(27718, 0, 5, 0, 0, 1, 100, 0, 9000, 12000, 12000, 16000, 0, 0, 11, 39171, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Horgrenn Hellcleave - In Combat - Cast \'Mortal Strike\' (Phase 1)'),
(27718, 0, 6, 0, 0, 1, 100, 0, 13000, 15000, 13000, 18000, 0, 0, 11, 38618, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Horgrenn Hellcleave - In Combat - Cast \'Whirlwind\' (Phase 1)'),
(27718, 0, 7, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2771800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Horgrenn Hellcleave - On Initialize - Run Script'),
(27727, 0, 0, 9, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 4, 1, 0, 0, 0, 0, 10, 102451, 27719, 0, 0, 0, 0, 0, 0, 'Conqueror Krenna - On Just Died - Set Data 4 1 on Grennix'),
(27727, 0, 1, 2, 1, 0, 100, 1, 60000, 60000, 0, 0, 0, 0, 45, 4, 2, 0, 0, 0, 0, 10, 102451, 27719, 0, 0, 0, 0, 0, 0, 'Conqueror Krenna - Out of Combat - Set Data 4 2 on Grennix (No Repeat)'),
(27727, 0, 2, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Conqueror Krenna - Out of Combat - Despawn Instant (No Repeat)'),
(27727, 0, 3, 0, 9, 1, 100, 0, 0, 0, 7000, 9000, 0, 5, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Conqueror Krenna - Within 0-5 Range - Cast \'Cleave\' (Phase 1)'),
(27727, 0, 4, 0, 0, 1, 100, 0, 9000, 12000, 12000, 17000, 0, 0, 11, 11430, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Conqueror Krenna - In Combat - Cast \'Slam\' (Phase 1)'),
(27727, 0, 5, 0, 105, 1, 100, 0, 14000, 17000, 14000, 17000, 0, 5, 11, 12555, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Conqueror Krenna - On Hostile Casting in Range - Cast \'Pummel\' (Phase 1)'),
(27727, 0, 6, 0, 13, 1, 100, 0, 3000, 6000, 6000, 0, 0, 0, 11, 34719, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Conqueror Krenna - On Victim Casting \'Open Wound\' - Cast \'Fixate\' (Phase 1)'),
(27727, 0, 7, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2772700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Conqueror Krenna - On Initialize - Run Script'),
(27727, 0, 8, 0, 52, 0, 100, 0, 2, 27726, 0, 0, 0, 0, 80, 2772701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Conqueror Krenna - On Text 2 Over - Run Script'),
(27727, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 204, 27726, 0, 0, 0, 0, 0, 0, 0, 'Conqueror Krenna - On Just Died - Set Data 1 1'),
(27727, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 204, 27726, 0, 0, 0, 0, 0, 0, 0, 'Conqueror Krenna - Out of Combat - Set Data 1 2 (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2771800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2771800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Horgrenn Hellcleave - Actionlist - Set Flags Immune To Players'),
(2771800, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 48350, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Horgrenn Hellcleave - Actionlist - Cast \'Emote Roar\''),
(2771800, 9, 2, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Horgrenn Hellcleave - Actionlist - Remove Flags Immune To Players'),
(2771800, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Horgrenn Hellcleave - Actionlist - Set Event Phase 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2772700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2772700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 27726, 3, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 3244.5, -2340.56, 92.14, 6.27, 'Conqueror Krenna - Actionlist - Summon Creature \'Gorgonna\''),
(2772700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Conqueror Krenna - Actionlist - Say Line 0'),
(2772700, 9, 2, 0, 0, 0, 100, 0, 18000, 18000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Conqueror Krenna - Actionlist - Say Line 1'),
(2772700, 9, 3, 0, 0, 0, 100, 0, 18000, 18000, 0, 0, 0, 0, 2, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Conqueror Krenna - Actionlist - Set Faction 4'),
(2772700, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Conqueror Krenna - Actionlist - Set Event Phase 1'),
(2772700, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 11, 27726, 40, 1, 0, 0, 0, 0, 0, 'Conqueror Krenna - Actionlist - Start Attacking');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27726);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27726, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2772600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorgonna - On Initialize - Run Script'),
(27726, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 80, 2772601, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorgonna - On Data Set 1 1 - Run Script'),
(27726, 0, 2, 0, 38, 0, 100, 0, 1, 2, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorgonna - On Data Set 1 2 - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2772600, 2772601));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2772600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorgonna - Actionlist - Remove Npc Flags Questgiver'),
(2772600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 117, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorgonna - Actionlist - Disable Evade'),
(2772600, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorgonna - Actionlist - Say Line 0'),
(2772600, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorgonna - Actionlist - Say Line 1'),
(2772600, 9, 4, 0, 0, 0, 100, 0, 18000, 18000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorgonna - Actionlist - Say Line 2'),
(2772601, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorgonna - Actionlist - Set Npc Flags Questgiver'),
(2772601, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorgonna - Actionlist - Set Flag Standstate Kneel'),
(2772601, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorgonna - Actionlist - Despawn In 25000 ms'),
(2772601, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorgonna - Actionlist - Say Line 2');

DELETE FROM `creature_text` WHERE (`CreatureID` = 27719);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27719, 0, 0, 'Ladies and gentlemen, gather round the Conquest Pit!  Witness the battle of $r versus bear and place your bets with confidence!', 14, 0, 100, 0, 0, 0, 27017, 0, 'Grennix Shivwiggle - Quest Accepted'),
(27719, 1, 0, 'Just when you think you\'ve seen it all!  $n will square off with an authentic Grizzly Hills crazed furbolg in front of your very eyes here at the Conquest Pit!  Place your bets, folks!', 14, 0, 100, 0, 0, 0, 27018, 0, 'Grennix Shivwiggle - Quest Accepted'),
(27719, 2, 0, 'Gather round, folks!  Grab a warm drink and find a good seat for you\'re about to witness a showdown between $r and machine!', 14, 0, 100, 0, 0, 0, 27019, 0, 'Grennix Shivwiggle - Quest Accepted'),
(27719, 3, 0, 'Straight out of Thor Modan and made of 100 percent authentic... metal... here is Rustblood, the lightning-powered iron golem!', 14, 0, 100, 0, 0, 0, 27020, 0, 'Grennix Shivwiggle - Spawn'),
(27719, 4, 0, 'Ladies and gentlemen... gather round the pit!', 14, 0, 100, 0, 0, 0, 27014, 0, 'Grennix Shivwiggle - Quest Accepted'),
(27719, 5, 0, 'In one corner we have... $n, truly a world class $c.  Slayer of reptiles, mammals, mechanical constructs and the odd dragon...kin.  You\'ve never seen another $r like $g him : her;.', 14, 0, 100, 0, 0, 0, 27015, 0, 'Grennix Shivwiggle - Spawn'),
(27719, 6, 0, 'In the other corner, a serial killer, mass defenestrator, sentenced to death multiple times by noose and by blunt instrument!  Horgrenn... Hellcleave!  Ladies and gentlemen... place your bets!', 14, 0, 100, 0, 0, 0, 27016, 0, 'Grennix Shivwiggle - Spawn'),
(27719, 7, 0, 'Ladies and gentlemen!  Well... let\'s just say you don\'t want to miss this one!', 14, 0, 100, 0, 0, 0, 27032, 0, 'Grennix Shivwiggle - Quest Accepted');

UPDATE `creature_template` SET `npcflag` = `npcflag` | 2 WHERE (`entry` = 27726);
DELETE FROM `creature_questender` WHERE (`id` = 27726 AND `quest` = 12431);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(27726, 12431);

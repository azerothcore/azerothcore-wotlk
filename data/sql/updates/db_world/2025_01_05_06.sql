-- DB update 2025_01_05_05 -> 2025_01_05_06
--
-- Scarlet Medic
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28608) AND (`source_type` = 0) AND (`id` IN (3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28608, 0, 3, 0, 0, 0, 100, 0, 0, 0, 3400, 4800, 0, 0, 11, 15498, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Medic - In Combat - Cast \'Holy Smite\''),
(28608, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Medic - Between 0-15% Health - Flee For Assist (No Repeat)');
-- Phantasmal ogre
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27647) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27647, 0, 0, 0, 2, 0, 100, 0, 0, 30, 20000, 24000, 0, 0, 11, 50730, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phantasmal Ogre - Between 0-30% Health - Cast \'Bloodlust\'');
-- Halfdan the Ice-Hearted
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23671) AND (`source_type` = 0) AND (`id` IN (9, 10, 11));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23671, 0, 9, 10, 2, 0, 100, 1, 25, 75, 120000, 120000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Halfdan the Ice-Hearted - Between 25-75% Health - Say Line 2 (No Repeat)'),
(23671, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Halfdan the Ice-Hearted - Between 25-75% Health - Cast \'Enrage\' (No Repeat)'),
(23671, 0, 11, 0, 2, 0, 100, 1, 0, 25, 120000, 120000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Halfdan the Ice-Hearted - Between 0-25% Health - Say Line 3 (No Repeat)');
-- Dalaran Spellscribe
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1920) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1920, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Spellscribe - Between 0-15% Health - Flee For Assist (No Repeat)');
-- Makrinni Scrabbler
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 6370) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6370, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 12548, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Makrinni Scrabbler - On Aggro - Cast \'Frost Shock\''),
(6370, 0, 1, 0, 0, 0, 100, 0, 2100, 2300, 6100, 6300, 0, 0, 11, 20822, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Makrinni Scrabbler - In Combat - Cast \'Frostbolt\''),
(6370, 0, 2, 0, 2, 0, 100, 1, 0, 20, 0, 0, 0, 0, 11, 11642, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Makrinni Scrabbler - Between 0-20% Health - Cast \'Heal\' (No Repeat)');
-- Alexandra Blazen
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8378) AND (`source_type` = 0) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8378, 0, 3, 0, 2, 0, 100, 0, 0, 20, 20000, 20000, 0, 0, 11, 11640, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alexandra Blazen - Between 0-20% Health - Cast \'Renew\'');

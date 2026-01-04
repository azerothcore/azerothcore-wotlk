-- DB update 2026_01_03_00 -> 2026_01_03_01
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30830);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30830, 0, 0, 0, 8, 0, 100, 1, 57906, 0, 0, 0, 0, 0, 80, 3083000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underking Talonox - On Spellhit \'War Horn of Acherus\' - Start Script'),
(30830, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 2000, 7000, 0, 0, 11, 60802, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Underking Talonox - In Combat - Cast \'Mandible Crush\''),
(30830, 0, 2, 0, 0, 0, 100, 0, 1500, 2000, 10000, 15000, 0, 0, 11, 50283, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Underking Talonox - In Combat - Cast \'Blinding Swarm\''),
(30830, 0, 3, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 33, 30830, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 0, 'Underking Talonox - On Just Died - Quest Credit');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3083000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3083000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Underking Talonox - Actionlist - Start Attacking'),
(3083000, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 57890, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underking Talonox - Actionlist - Cast \'Death Gate\''),
(3083000, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 86, 57892, 2, 19, 30841, 100, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underking Talonox - Actionlist - Cross Cast \'Death Gate\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30831);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30831, 0, 0, 0, 8, 0, 100, 1, 57906, 0, 0, 0, 0, 0, 80, 3083100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yath\'amon - On Spellhit \'War Horn of Acherus\' - Run Script (No Repeat)'),
(30831, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 6000, 8000, 0, 0, 11, 61705, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yath\'amon - In Combat - Cast \'Venomous Bite\''),
(30831, 0, 2, 0, 0, 0, 100, 0, 2000, 7000, 10000, 20000, 0, 0, 11, 4962, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yath\'amon - In Combat - Cast \'Encasing Webs\''),
(30831, 0, 3, 0, 0, 0, 100, 0, 2000, 7000, 8000, 20000, 0, 0, 11, 38243, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yath\'amon - In Combat - Cast \'Mind Flay\''),
(30831, 0, 4, 0, 0, 0, 100, 0, 10000, 15000, 30000, 35000, 0, 0, 11, 34322, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yath\'amon - In Combat - Cast \'Psychic Scream\''),
(30831, 0, 5, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 33, 30831, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yath\'amon - On Just Died - Quest Credit');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3083100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3083100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yath\'amon - Actionlist - Start Attacking'),
(3083100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 57916, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yath\'amon - Actionlist - Cast \'Death Gate\''),
(3083100, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 86, 57917, 2, 19, 30852, 100, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yath\'amon - Actionlist - Cross Cast \'Death Gate\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30829);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30829, 0, 0, 0, 8, 0, 100, 1, 57906, 0, 0, 0, 0, 0, 80, 3082900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - On Spellhit \'War Horn of Acherus\' - Run Script (No Repeat)'),
(30829, 0, 1, 0, 60, 0, 100, 0, 3600, 3600, 3600, 3600, 0, 0, 11, 18100, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - On Update - Cast \'Frost Armor\''),
(30829, 0, 2, 0, 0, 0, 100, 0, 2000, 6000, 4000, 8000, 0, 0, 11, 15242, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - In Combat - Cast \'Fireball\''),
(30829, 0, 3, 0, 0, 0, 100, 0, 15000, 20000, 15000, 20000, 0, 0, 11, 15244, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - In Combat - Cast \'Cone of Cold\''),
(30829, 0, 4, 0, 105, 0, 100, 0, 25000, 26000, 25000, 26000, 0, 30, 11, 15122, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - On Hostile Casting in Range - Cast \'Counterspell\''),
(30829, 0, 5, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 33, 30829, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - On Just Died - Quest Credit');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3082900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3082900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - Actionlist - Start Attacking'),
(3082900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 57910, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - Actionlist - Cast \'Death Gate\''),
(3082900, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 86, 57911, 2, 19, 30850, 100, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - Actionlist - Cross Cast \'Death Gate\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30839) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30839, 0, 0, 0, 60, 0, 100, 257, 2000, 2000, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 30831, 50, 0, 0, 0, 0, 0, 0, 'Jayde - On Update - Start Attacking (No Repeat)'),
(30839, 0, 1, 2, 4, 0, 100, 513, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 19, 30852, 50, 0, 0, 0, 0, 0, 0, 'Jayde - On Aggro - Despawn In 5000 ms (No Repeat)'),
(30839, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jayde - On Aggro - Say Line 1 (No Repeat)'),
(30839, 0, 3, 0, 0, 0, 100, 512, 4000, 6000, 19000, 20000, 0, 0, 11, 52372, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Jayde - In Combat - Cast \'Icy Touch\''),
(30839, 0, 4, 0, 0, 0, 100, 512, 4000, 8000, 10500, 11000, 0, 0, 11, 52373, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Jayde - In Combat - Cast \'Plague Strike\''),
(30839, 0, 5, 0, 0, 0, 100, 0, 4000, 7000, 2000, 2500, 0, 0, 11, 52374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Jayde - In Combat - Cast \'Blood Strike\''),
(30839, 0, 6, 7, 21, 0, 100, 1, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jayde - On Reached Home - Say Line 2 (No Repeat)'),
(30839, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 57916, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jayde - On Reached Home - Cast \'Death Gate\' (No Repeat)'),
(30839, 0, 8, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jayde - On Reached Home - Create Timed Event (No Repeat)'),
(30839, 0, 9, 10, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 19, 30852, 50, 0, 0, 0, 0, 0, 0, 'Jayde - On Timed Event 1 Triggered - Move To Closest Creature \'Death Gate (Jayde)\''),
(30839, 0, 10, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jayde - On Timed Event 1 Triggered - Despawn In 3000 ms');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30840) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30840, 0, 0, 0, 60, 0, 100, 257, 2000, 2000, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 30829, 50, 0, 0, 0, 0, 0, 0, 'Munch - On Update - Start Attacking (No Repeat)'),
(30840, 0, 1, 2, 4, 0, 100, 513, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 19, 30850, 50, 0, 0, 0, 0, 0, 0, 'Munch - On Aggro - Despawn In 5000 ms (No Repeat)'),
(30840, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Munch - On Aggro - Say Line 1 (No Repeat)'),
(30840, 0, 3, 4, 0, 0, 100, 1, 4000, 4000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Munch - In Combat - Say Line 2 (No Repeat)'),
(30840, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 57913, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Munch - In Combat - Cast \'Summon Ghoul\' (No Repeat)'),
(30840, 0, 5, 0, 0, 0, 100, 512, 4000, 6000, 19000, 20000, 0, 0, 11, 52372, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Munch - In Combat - Cast \'Icy Touch\''),
(30840, 0, 6, 0, 0, 0, 100, 512, 4000, 8000, 10000, 11000, 0, 0, 11, 52373, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Munch - In Combat - Cast \'Plague Strike\''),
(30840, 0, 7, 0, 0, 0, 100, 0, 4000, 7000, 2000, 3000, 0, 0, 11, 52374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Munch - In Combat - Cast \'Blood Strike\''),
(30840, 0, 8, 9, 21, 0, 100, 1, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Munch - On Reached Home - Say Line 3 (No Repeat)'),
(30840, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 57910, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Munch - On Reached Home - Cast \'Death Gate\' (No Repeat)'),
(30840, 0, 10, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Munch - On Reached Home - Create Timed Event (No Repeat)'),
(30840, 0, 11, 12, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 19, 30850, 50, 0, 0, 0, 0, 0, 0, 'Munch - On Timed Event 1 Triggered - Move To Closest Creature \'Death Gate (Munch)\''),
(30840, 0, 12, 13, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Munch - On Timed Event 1 Triggered - Despawn In 3000 ms'),
(30840, 0, 13, 0, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 30851, 50, 0, 0, 0, 0, 0, 0, 'Munch - On Timed Event 1 Triggered - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30838) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30838, 0, 0, 0, 60, 0, 100, 257, 2000, 2000, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 30830, 50, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Update - Start Attacking (No Repeat)'),
(30838, 0, 1, 2, 4, 0, 100, 513, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 19, 30841, 50, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Aggro - Despawn In 5000 ms (No Repeat)'),
(30838, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Aggro - Say Line 1 (No Repeat)'),
(30838, 0, 3, 0, 0, 0, 100, 512, 4000, 6000, 19000, 20000, 0, 0, 11, 52372, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - In Combat - Cast \'Icy Touch\''),
(30838, 0, 4, 0, 0, 0, 100, 512, 4000, 8000, 10000, 11000, 0, 0, 11, 52373, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - In Combat - Cast \'Plague Strike\''),
(30838, 0, 5, 0, 0, 0, 100, 0, 4000, 7000, 5000, 5000, 0, 0, 11, 49020, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - In Combat - Cast \'Obliterate\''),
(30838, 0, 6, 7, 21, 0, 100, 1, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Reached Home - Say Line 2 (No Repeat)'),
(30838, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 57890, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Reached Home - Cast \'Death Gate\' (No Repeat)'),
(30838, 0, 8, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Reached Home - Create Timed Event (No Repeat)'),
(30838, 0, 9, 10, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 19, 30841, 50, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Timed Event 1 Triggered - Move To Closest Creature \'Death Gate (Mograine)\''),
(30838, 0, 10, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Timed Event 1 Triggered - Despawn In 3000 ms');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30851;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30851);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30851, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 30829, 40, 0, 0, 0, 0, 0, 0, 'Melt - On Respawn - Start Attacking');

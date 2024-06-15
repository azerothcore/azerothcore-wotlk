-- DB update 2023_03_23_01 -> 2023_03_23_02
--
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (40331,35106,34449,37272,37252);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(40331, 40331, 40332),
(35106, 35106, 37856),
(34449, 34449, 37924),
(37272, 37272, 37862),
(37252, 37252, 39412);

UPDATE `creature_text` SET `BroadcastTextId` = 16711 WHERE `Text`='By Nazjatar\'s Depths!';
UPDATE `creature_text` SET `BroadcastTextId` = 16710 WHERE `Text`='Die, warmblood!';
UPDATE `creature_text` SET `BroadcastTextId` = 16708 WHERE `Text`='For the Master!';
UPDATE `creature_text` SET `BroadcastTextId` = 16709 WHERE `Text`='Illidan reigns!';
UPDATE `creature_text` SET `BroadcastTextId` = 16712 WHERE `Text`='My blood is like venom!';

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17721 AND `source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17721, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Engineer - On Aggro - Say Line 0'),
(17721, 0, 1, 0, 0, 0, 100, 0, 6000, 8000, 9000, 13000, 0, 11, 40331, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Engineer - In Combat - Cast \'Bomb\''),
(17721, 0, 2, 0, 0, 0, 100, 0, 11000, 16000, 5000, 7000, 0, 11, 6533, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Engineer - In Combat - Cast \'Net\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17722 AND `source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17722, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Sorceress - On Aggro - Say Line 0'),
(17722, 0, 1, 0, 0, 0, 100, 2, 0, 0, 2400, 3800, 0, 11, 12675, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Sorceress - In Combat - Cast \'Frostbolt\' (Normal Dungeon)'),
(17722, 0, 2, 0, 0, 0, 100, 4, 0, 0, 2400, 3800, 0, 11, 37930, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Sorceress - In Combat - Cast \'Frostbolt\' (Heroic Dungeon)'),
(17722, 0, 3, 0, 9, 0, 100, 2, 0, 8, 13000, 18000, 1, 11, 15063, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Sorceress - Within 0-8 Range - Cast \'Frost Nova\' (Normal Dungeon)'),
(17722, 0, 4, 0, 9, 0, 100, 4, 0, 8, 13000, 18000, 1, 11, 15531, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Sorceress - Within 0-8 Range - Cast \'Frost Nova\' (Heroic Dungeon)'),
(17722, 0, 5, 0, 0, 0, 100, 2, 18000, 20000, 25000, 27000, 0, 11, 39416, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Sorceress - In Combat - Cast \'Blizzard\' (Normal Dungeon)'),
(17722, 0, 6, 0, 0, 0, 100, 4, 18000, 20000, 25000, 27000, 0, 11, 31581, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Sorceress - In Combat - Cast \'Blizzard\' (Heroic Dungeon)');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17800 AND `source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17800, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Myrmidon - On Aggro - Say Line 0'),
(17800, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 5000, 7000, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Myrmidon - In Combat - Cast \'Cleave\''),
(17800, 0, 2, 0, 12, 0, 100, 0, 0, 20, 10000, 10000, 0, 11, 7160, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Myrmidon - Target Between 0-20% Health - Cast \'Execute\''),
(17800, 0, 3, 0, 0, 0, 100, 0, 15000, 30000, 30000, 30000, 0, 11, 18765, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Myrmidon - In Combat - Cast \'Sweeping Strikes\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17801);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17801, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Siren - On Aggro - Say Line 0'),
(17801, 0, 1, 0, 0, 0, 100, 2, 0, 0, 3400, 4500, 0, 11, 15234, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Siren - In Combat - Cast \'Lightning Bolt\' (Normal Dungeon)'),
(17801, 0, 2, 0, 0, 0, 100, 4, 0, 0, 3400, 4500, 0, 11, 37664, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Siren - In Combat - Cast \'Lightning Bolt\' (Heroic Dungeon)'),
(17801, 0, 3, 0, 0, 0, 100, 0, 9000, 12000, 10000, 17000, 0, 11, 35106, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Siren - In Combat - Cast \'Arcane Flare\''),
(17801, 0, 5, 0, 0, 0, 100, 0, 10000, 14000, 18000, 18000, 0, 11, 38660, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Siren - In Combat - Cast \'Fear\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17803 AND `source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17803, 0, 0, 0, 0, 0, 100, 2, 5000, 8000, 13000, 16000, 0, 11, 22582, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Oracle - In Combat - Cast \'Frost Shock\' (Normal Dungeon)'),
(17803, 0, 1, 0, 0, 0, 100, 4, 5000, 8000, 13000, 16000, 0, 11, 37865, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Oracle - In Combat - Cast \'Frost Shock\' (Heroic Dungeon)'),
(17803, 0, 2, 0, 74, 0, 100, 2, 0, 40, 9000, 14000, 40, 11, 22883, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Oracle - On Friendly Between 0-40% Health - Cast \'Heal\' (Normal Dungeon)'),
(17803, 0, 3, 0, 74, 0, 100, 4, 0, 40, 9000, 14000, 40, 11, 31730, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Oracle - On Friendly Between 0-40% Health - Cast \'Heal\' (Heroic Dungeon)'),
(17803, 0, 4, 0, 0, 0, 100, 0, 9000, 12000, 14000, 18000, 0, 11, 8281, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Oracle - In Combat - Cast \'Sonic Burst\''),
(17803, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Oracle - On Aggro - Say Line 0');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17917);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17917, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 7000, 12000, 0, 11, 34449, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Water Elemental - In Combat - Cast Water Bolt Volley');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21338);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21338, 0, 0, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 31, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - On Aggro - Set Phase Random Between 1-3'),
(21338, 0, 1, 0, 74, 1, 100, 2, 0, 40, 10000, 11000, 40, 11, 11642, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - Friendly Below 40% HP - Cast \'Heal\' (Phase 1) (Normal Dungeon)'),
(21338, 0, 2, 0, 74, 1, 100, 4, 0, 40, 10000, 11000, 40, 11, 15586, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - Friendly Below 40% HP - Cast \'Heal\' (Phase 1) (Heroic Dungeon)'),
(21338, 0, 3, 0, 0, 2, 100, 0, 4000, 6000, 7000, 8000, 0, 11, 13446, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - In Combat - Cast \'Strike\' (Phase 2)'),
(21338, 0, 4, 0, 0, 2, 100, 0, 3000, 7000, 10000, 15000, 0, 11, 13444, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - In Combat - Cast \'Sunder Armor\' (Phase 2)'),
(21338, 0, 5, 0, 0, 2, 100, 0, 9000, 14000, 12000, 15000, 0, 11, 40505, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - In Combat - Cast \'Cleave\' (Phase 2)'),
(21338, 0, 6, 0, 0, 4, 100, 2, 4000, 6000, 9000, 10000, 0, 11, 13339, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - In Combat - Cast \'Fire Blast\' (Phase 3) (Normal Dungeon)'),
(21338, 0, 7, 0, 0, 4, 100, 4, 4000, 6000, 9000, 10000, 0, 11, 14145, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - In Combat - Cast \'Fire Blast\' (Phase 3) (Heroic Dungeon)'),
(21338, 0, 8, 0, 0, 4, 100, 2, 0, 0, 3000, 3000, 0, 11, 9613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - In Combat - Cast \'Shadow Bolt\' (Phase 3) (Normal Dungeon)'),
(21338, 0, 9, 0, 0, 4, 100, 4, 0, 0, 3000, 3000, 0, 11, 12739, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - In Combat - Cast \'Shadow Bolt\' (Phase 3) (Heroic Dungeon)');

DELETE FROM `creature_template_addon` WHERE (`entry` IN (21694, 21914));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(21694, 0, 0, 0, 1, 0, 0, '37266'),
(21914, 0, 0, 0, 1, 0, 0, '37863');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21694) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21694, 0, 0, 0, 1, 0, 100, 0, 2000, 5000, 12000, 19000, 0, 11, 34158, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bog Overlord - Out of Combat - Cast \'Fungal Decay\''),
(21694, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 5000, 7000, 0, 11, 37272, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Bog Overlord - In Combat - Cast \'Poison Bolt\''),
(21694, 0, 2, 0, 0, 0, 100, 0, 7000, 10000, 12000, 15000, 0, 11, 40340, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bog Overlord - In Combat - Cast \'Trample\''),
(21694, 0, 3, 0, 0, 0, 100, 0, 7000, 9500, 12000, 15000, 0, 11, 40340, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bog Overlord - In Combat - Cast \'Trample\''),
(21694, 0, 4, 5, 2, 0, 100, 1, 0, 20, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bog Overlord - Between 0-20% Health - Cast \'Enrage\' (No Repeat)'),
(21694, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bog Overlord - Between 0-20% Health - Say Line 0 (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21695);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21695, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 14000, 18000, 0, 11, 37250, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidal Surger - In Combat - Cast \'Water Spout\''),
(21695, 0, 1, 0, 9, 0, 100, 0, 0, 10, 9000, 14000, 1, 11, 15531, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidal Surger - Within 0-10 Range - Cast \'Frost Nova\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21696);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21696, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 11000, 14000, 0, 11, 37252, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Steam Surger - In Combat - Cast \'Water Bolt\'');

-- DB update 2023_05_03_03 -> 2023_05_09_00
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (32191, 32193, 15234, 34944, 17139, 34945);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(32191, 32191, 37666),
(32193, 32193, 37665),
(15234, 15234, 37664),
(34944, 34944, 37669),
(17139, 17139, 36052),
(34945, 34945, 39378);

-- Small Updates
UPDATE `smart_scripts` SET `event_param1` = 3600, `event_param2` = 9750, `event_param3` = 6050, `event_param4` = 9750 WHERE (`entryorguid` = 17964) AND (`source_type` = 0) AND (`id` IN (0, 1)); -- Wastewalker Worker
UPDATE `smart_scripts` SET `event_param1` = 6150, `event_param2` = 15800, `event_param3` = 19400, `event_param4` = 25500 WHERE (`entryorguid` = 17959) AND (`source_type` = 0) AND (`id` IN (1)); -- Coilfang Slavehandler
UPDATE `smart_scripts` SET `event_param1` = 12150, `event_param2` = 24250, `event_param3` = 24250, `event_param4` = 27900 WHERE (`entryorguid` = 17959) AND (`source_type` = 0) AND (`id` IN (2)); -- Coilfang Slavehandler

-- Complete Rewrites
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (17816, 17940, 17817, 17960, 17938, 17958, 17962, 21128, 17961, 21126, 21127));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17816, 0, 0, 0, 0, 0, 100, 0, 6100, 18100, 1200, 24250, 0, 11, 31551, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bogstrok - In Combat - Cast \'Piercing Jab\''),
(17940, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Technician - On Aggro - Say Line 0'),
(17940, 0, 1, 0, 0, 0, 100, 2, 10750, 26500, 10750, 26500, 0, 87, 1794000, 1794001, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Technician - In Combat - Cast Random Spell (Normal Dungeon)'),
(17940, 0, 2, 0, 0, 0, 100, 4, 10750, 26500, 10750, 26500, 0, 87, 1794002, 1794003, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Technician - In Combat - Cast Random Spell (Heroic Dungeon)'),
(17817, 0, 0, 0, 0, 0, 100, 0, 6150, 15750, 10950, 21750, 0, 11, 35760, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Greater Bogstrok - In Combat - Cast \'Decayed Strength\''),
(17960, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Soothsayer - On Aggro - Say Line 0'),
(17960, 0, 1, 0, 0, 0, 100, 0, 9950, 12150, 23100, 24300, 0, 11, 15790, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Soothsayer - In Combat - Cast \'Arcane Missiles\''),
(17960, 0, 2, 0, 0, 0, 100, 0, 19400, 27600, 26500, 42300, 0, 11, 31555, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Soothsayer - In Combat - Cast \'Decayed Intellect\''),
(17960, 0, 3, 0, 0, 0, 100, 0, 20650, 25500, 23100, 24300, 0, 11, 30923, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Soothsayer - In Combat - Cast \'Domination\''),
(17938, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Observer - On Aggro - Say Line 0'),
(17938, 0, 1, 0, 0, 0, 100, 2, 11750, 16350, 7300, 12150, 0, 11, 32191, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Observer - In Combat - Cast \'Heavy Dynamite\' (Normal Dungeon)'),
(17938, 0, 2, 0, 0, 0, 100, 2, 11250, 15400, 25500, 26750, 0, 11, 17883, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Observer - In Combat - Cast \'Immolate\' (Normal Dungeon)'),
(17938, 0, 3, 0, 0, 0, 100, 4, 11250, 15400, 25500, 26750, 0, 11, 37668, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Observer - In Combat - Cast \'Immolate\' (Heroic Dungeon)'),
(17958, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Defender - On Aggro - Say Line 0'),
(17958, 0, 1, 0, 0, 0, 100, 0, 7300, 13350, 10900, 21850, 0, 11, 15655, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Defender - In Combat - Cast \'Shield Slam\''),
(17958, 0, 2, 0, 0, 0, 100, 0, 13000, 17000, 18200, 29100, 0, 11, 31554, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Defender - In Combat - Cast \'Spell Reflection\''),
(17962, 0, 0, 0, 0, 0, 100, 0, 12100, 19350, 13350, 19700, 0, 11, 33787, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Collaborator - In Combat - Cast \'Cripple\''),
(17962, 0, 1, 0, 0, 0, 100, 0, 20100, 26200, 20000, 26000, 0, 11, 19130, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Collaborator - In Combat - Cast \'Revenge\''),
(17962, 0, 2, 3, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Collaborator - Between 0-30% Health - Cast \'Frenzy\''),
(17962, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Collaborator - Linked - Say Line 0'),
(21128, 0, 0, 0, 0, 0, 100, 0, 4900, 11750, 12150, 25750, 0, 11, 34984, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Ray - In Combat - Cast \'Psychic Horror\''),
(17961, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Enchantress - On Aggro - Say Line 0'),
(17961, 0, 1, 0, 0, 0, 100, 0, 13350, 19700, 19450, 27900, 0, 11, 32173, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Enchantress - In Combat - Cast \'Entangling Roots\''),
(17961, 0, 2, 0, 0, 0, 100, 0, 7300, 12150, 21450, 31600, 0, 11, 15234, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Enchantress - In Combat - Cast \'Lightning Bolt\''),
(17961, 0, 4, 0, 0, 0, 100, 0, 14850, 21200, 19450, 27900, 0, 11, 32193, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Enchantress - In Combat - Cast \'Lightning Cloud\''),
(21126, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Scale-Healer - On Aggro - Say Line 0'),
(21126, 0, 1, 0, 74, 0, 100, 0, 0, 65, 12000, 16000, 40, 11, 34945, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Scale-Healer - On Friendly Between 0-65% Health - Cast \'Heal\''),
(21126, 0, 2, 0, 0, 0, 100, 0, 4250, 8850, 13400, 21900, 0, 11, 34944, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Scale-Healer - In Combat - Cast \'Holy Nova\''),
(21126, 0, 3, 0, 16, 0, 100, 0, 17139, 40, 7200, 13300, 1, 11, 17139, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Scale-Healer - On Friendly Unit Missing Buff \'Power Word: Shield\' - Cast \'Power Word: Shield\''),
(21127, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Tempest - On Aggro - Say Line 0'),
(21127, 0, 1, 0, 0, 0, 100, 0, 10550, 22950, 8500, 17400, 0, 11, 15667, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Tempest - In Combat - Cast \'Sinister Strike\''),
(21127, 0, 2, 0, 0, 0, 100, 0, 10800, 22900, 26900, 44600, 0, 11, 36872, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Tempest - In Combat - Cast \'Deadly Poison\'');

-- Partial Rewrites
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17963) AND (`source_type` = 0) AND (`id` IN (1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17963, 0, 1, 0, 9, 0, 100, 2, 0, 10, 6000, 7700, 1, 11, 32192, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - In Combat - Cast Frost Nova'),
(17963, 0, 2, 0, 9, 0, 100, 4, 0, 10, 6000, 7700, 1, 11, 15531, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - In Combat - Cast Frost Nova'),
(17963, 0, 3, 0, 0, 0, 100, 2, 400, 4950, 3300, 4950, 0, 11, 15497, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - In Combat - Cast Frostbolt'),
(17963, 0, 4, 0, 0, 0, 100, 4, 400, 4950, 3300, 4950, 0, 11, 12675, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - In Combat - Cast Frostbolt');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17957) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17957, 0, 1, 0, 0, 0, 100, 0, 15700, 29100, 21900, 30200, 0, 11, 19134, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Champion - In Combat - Cast \'Frightening Shout\''),
(17957, 0, 2, 0, 0, 0, 100, 0, 7400, 15750, 1200, 28600, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Champion - In Combat - Cast \'Cleave\''),
(17957, 0, 3, 0, 0, 0, 100, 0, 10950, 26050, 10950, 26050, 0, 11, 16145, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Champion - In Combat - Cast \'Sunder Armor\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1794000, 1794001, 1794002, 1794003));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1794000, 9, 0, 0, 0, 0, 100, 2, 0, 0, 0, 0, 0, 11, 16005, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Technician - Actionlist for Random Cast - Cast \'Rain of Fire\' (Normal Dungeon)'),
(1794001, 9, 0, 0, 0, 0, 100, 2, 0, 0, 0, 0, 0, 11, 21096, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Technician - Actionlist for Random Cast - Cast \'Blizzard\' (Normal Dungeon)'),
(1794002, 9, 0, 0, 0, 0, 100, 4, 0, 0, 0, 0, 0, 11, 39376, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Technician - Actionlist for Random Cast - Cast \'Rain of Fire\' (Heroic Dungeon)'),
(1794003, 9, 0, 0, 0, 0, 100, 4, 0, 0, 0, 0, 0, 11, 37671, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Technician - Actionlist for Random Cast - Cast \'Blizzard\' (Heroic Dungeon)');

DELETE FROM `creature_text` WHERE `CreatureID` = 17962;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17962, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 38630, 0, 'Coilfang Collaborator');

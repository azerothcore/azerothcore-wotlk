-- DB update 2023_03_20_07 -> 2023_03_21_00
--
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (36617,36619,36664,36655,36657,36660,36654,36738,36786,36787,36891,36887,36868,36742,36741,36743,36740,36736,36863,36864,36838,36840,37480,37479,36829,36832,36827,35964,35932,36984,36835,38855,36837);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(36617, 36617, 38810),
(36619, 36619, 38811),
(36664, 36664, 38816),
(36655, 36655, 38817),
(36657, 36657, 38818),
(36660, 36660, 38820),
(36654, 36654, 38813),
(36738, 36738, 38835),
(36786, 36786, 38843),
(36787, 36787, 38846),
(36891, 36891, 38849),
(36887, 36887, 38850),
(36868, 36868, 38892),
(36742, 36742, 38836), -- Fireball Volley
(36741, 36741, 38837), -- Frostbolt Volley
(36743, 36743, 38838), -- Holy Bolt Volley
(36740, 36740, 38839), -- Lightning Bolt Volley
(36736, 36736, 38840), -- Spell Shadow Bolt Volley
(36863, 36863, 38851),
(36864, 36864, 38852),
(36838, 36838, 38894),
(36840, 36840, 38896),
(37480, 37480, 38900),
(37479, 37479, 38899),
(36829, 36829, 38917),
(36832, 36832, 38918),
(36827, 36827, 38912),
(35964, 35964, 38942),
(35932, 35932, 38943),
(36984, 36984, 38914),
(36835, 36835, 38911),
(38855, 38855, 38901),
(36837, 36837, 38903);

-- Protean Nightmare
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (20864, -138901, -138902)) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20864, 0, 0, 0, 0, 0, 100, 0, 16900, 17600, 19300, 26500, 0, 11, 36617, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Gaping Maw\''),
(20864, 0, 1, 0, 0, 0, 100, 0, 22900, 26300, 10800, 22900, 0, 11, 36619, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Infectious Poison\''),
(20864, 0, 2, 0, 0, 0, 100, 0, 15200, 21700, 10900, 22900, 0, 11, 36622, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Incubation\''),
(20864, 0, 3, 0, 8, 0, 50, 512, 36327, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - On Spellhit \'Shoot Arcane Explosion Arrow\' - Kill Target'),

(-138901, 0, 0, 0, 0, 0, 100, 0, 16900, 17600, 19300, 26500, 0, 11, 36617, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Gaping Maw\''),
(-138901, 0, 1, 0, 0, 0, 100, 0, 22900, 26300, 10800, 22900, 0, 11, 36619, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Infectious Poison\''),
(-138901, 0, 2, 0, 0, 0, 100, 0, 15200, 21700, 10900, 22900, 0, 11, 36622, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Incubation\''),
(-138901, 0, 3, 0, 8, 0, 50, 512, 36327, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - On Spellhit \'Shoot Arcane Explosion Arrow\' - Kill Target'),

(-138902, 0, 0, 0, 0, 0, 100, 0, 16900, 17600, 19300, 26500, 0, 11, 36617, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Gaping Maw\''),
(-138902, 0, 1, 0, 0, 0, 100, 0, 22900, 26300, 10800, 22900, 0, 11, 36619, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Infectious Poison\''),
(-138902, 0, 2, 0, 0, 0, 100, 0, 15200, 21700, 10900, 22900, 0, 11, 36622, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Incubation\''),
(-138902, 0, 3, 0, 8, 0, 50, 512, 36327, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - On Spellhit \'Shoot Arcane Explosion Arrow\' - Kill Target');

-- Entropic Eye
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (20868, -138930)) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20868, 0, 0, 0, 0, 0, 70, 0, 5000, 10000, 17000, 25000, 0, 11, 36677, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Entropic Eye - In Combat - Cast \'Chaos Breath\''),
(20868, 0, 1, 0, 0, 0, 75, 0, 4000, 7000, 6000, 8000, 0, 11, 36664, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Entropic Eye - In Combat - Cast \'Tentacle Cleave\''),

(-138930, 0, 0, 0, 0, 0, 70, 0, 5000, 10000, 17000, 25000, 0, 11, 36677, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Entropic Eye - In Combat - Cast \'Chaos Breath\''),
(-138930, 0, 1, 0, 0, 0, 75, 0, 4000, 7000, 6000, 8000, 0, 11, 36664, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Entropic Eye - In Combat - Cast \'Tentacle Cleave\'');

-- Death Watcher
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (20867, -138927)) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20867, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 10000, 15000, 0, 11, 36664, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - In Combat - Cast \'Tentacle Cleave\''),
(20867, 0, 1, 0, 2, 0, 100, 0, 0, 70, 15000, 15000, 0, 11, 36655, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - Between 0-70% Health - Cast \'Drain Life\''),
(20867, 0, 2, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 11, 36657, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - Between 0-50% Health - Cast \'Death Count\' (No Repeat)'),
(20867, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36660, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Death - Cast \'Death Count\''),
(20867, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Death - Remove All Auras'),

(-138927, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 10000, 15000, 0, 11, 36664, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - In Combat - Cast \'Tentacle Cleave\''),
(-138927, 0, 1, 0, 2, 0, 100, 0, 0, 70, 15000, 15000, 0, 11, 36655, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - Between 0-70% Health - Cast \'Drain Life\''),
(-138927, 0, 2, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 11, 36657, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - Between 0-50% Health - Cast \'Death Count\' (No Repeat)'),
(-138927, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36660, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Death - Cast \'Death Count\''),
(-138927, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Death - Remove All Auras');

-- Soul Devourer
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20866);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20866, 0, 0, 0, 2, 0, 100, 0, 0, 30, 14000, 21000, 0, 11, 33958, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Soul Devourer - Between 0-30% Health - Cast \'Enrage\''),
(20866, 0, 1, 0, 0, 0, 100, 0, 7000, 11000, 15000, 23000, 0, 11, 36654, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Soul Devourer - In Combat - Cast \'Fel Breath\''),
(20866, 0, 2, 0, 0, 0, 100, 0, 15000, 17000, 120000, 180000, 0, 11, 36644, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Soul Devourer - In Combat - Cast \'Sightless Eye\'');

-- Negaton Screamer
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (20875, -138940) AND `id` BETWEEN 0 AND 20);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20875, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Reset - Set Event Phase 0'),
(20875, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Aggro - Set Event Phase 1'),
(20875, 0, 2, 0, 0, 0, 100, 0, 17000, 25000, 17000, 25000, 0, 11, 13704, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast \'Psychic Scream\''),
(20875, 0, 3, 0, 8, 1, 100, 0, 0, 4, 0, 0, 0, 80, 2087501, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Spellhit \'Fire\' - Run Script Fire (Phase 1)'),
(20875, 0, 4, 0, 8, 1, 100, 0, 0, 16, 0, 0, 0, 80, 2087502, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Spellhit \'Frost\' - Run Script Frost (Phase 1)'),
(20875, 0, 5, 0, 8, 1, 100, 0, 0, 64, 0, 0, 0, 80, 2087503, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Spellhit \'Arcane\' - Run Script Arcane (Phase 1)'),
(20875, 0, 6, 0, 8, 1, 100, 0, 0, 8, 0, 0, 0, 80, 2087504, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Spellhit \'Nature\' - Run Script Nature (Phase 1)'),
(20875, 0, 7, 0, 8, 1, 100, 0, 0, 32, 0, 0, 0, 80, 2087505, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Spellhit \'Shadow\' - Run Script Shadow (Phase 1)'),
(20875, 0, 8, 0, 8, 1, 100, 0, 0, 2, 0, 0, 0, 80, 2087506, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Spellhit \'Holy\' - Run Script Holy (Phase 1)'),

(-138940, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Reset - Set Event Phase 0'),
(-138940, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Aggro - Set Event Phase 1'),
(-138940, 0, 2, 0, 0, 0, 100, 0, 17000, 25000, 17000, 25000, 0, 11, 13704, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast \'Psychic Scream\''),
(-138940, 0, 3, 0, 8, 1, 100, 0, 0, 4, 0, 0, 0, 80, 2087501, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Spellhit \'Fire\' - Run Script Fire (Phase 1)'),
(-138940, 0, 4, 0, 8, 1, 100, 0, 0, 16, 0, 0, 0, 80, 2087502, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Spellhit \'Frost\' - Run Script Frost (Phase 1)'),
(-138940, 0, 5, 0, 8, 1, 100, 0, 0, 64, 0, 0, 0, 80, 2087503, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Spellhit \'Arcane\' - Run Script Arcane (Phase 1)'),
(-138940, 0, 6, 0, 8, 1, 100, 0, 0, 8, 0, 0, 0, 80, 2087504, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Spellhit \'Nature\' - Run Script Nature (Phase 1)'),
(-138940, 0, 7, 0, 8, 1, 100, 0, 0, 32, 0, 0, 0, 80, 2087505, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Spellhit \'Shadow\' - Run Script Shadow (Phase 1)'),
(-138940, 0, 8, 0, 8, 1, 100, 0, 0, 2, 0, 0, 0, 80, 2087506, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Spellhit \'Holy\' - Run Script Holy (Phase 1)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 2087501 AND 2087506);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2087501, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Set Event Phase 2'),
(2087501, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Damage Reduction: Fire\''),
-- (2087501, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34398, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Flame Energy\''),
(2087501, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36733, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Elemental Response\''),
(2087501, 9, 4, 0, 0, 0, 100, 0, 3000, 8000, 0, 0, 0, 11, 36742, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Fireball Volley\''),
(2087501, 9, 5, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Remove All Auras'),
(2087501, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Set Event Phase 1'),

(2087502, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Set Event Phase 2'),
(2087502, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34334, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Damage Reduction: Frost\''),
-- (2087502, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34404, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Frost Energy\''),
(2087502, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36733, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Elemental Response\''),
(2087502, 9, 4, 0, 0, 0, 100, 0, 3000, 8000, 0, 0, 0, 11, 36741, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Frostbolt Volley\''),
(2087502, 9, 5, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Remove All Auras'),
(2087502, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Set Event Phase 1'),

(2087503, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Set Event Phase 2'),
(2087503, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34331, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Damage Reduction: Arcane\''),
-- (2087503, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34401, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Arcane Energy\''),
(2087503, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36733, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Elemental Response\''),
(2087503, 9, 4, 0, 0, 0, 100, 0, 3000, 8000, 0, 0, 0, 11, 36738, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Arcane Volley\''),
(2087503, 9, 5, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Remove All Auras'),
(2087503, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Set Event Phase 1'),

(2087504, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Set Event Phase 2'),
(2087504, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34335, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Damage Reduction: Nature\''),
-- (2087504, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34402, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Nature Energy\''),
(2087504, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36733, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Elemental Response\''),
(2087504, 9, 4, 0, 0, 0, 100, 0, 3000, 8000, 0, 0, 0, 11, 36740, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Lightning Bolt Volley\''),
(2087504, 9, 5, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Remove All Auras'),
(2087504, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Set Event Phase 1'),

(2087505, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Set Event Phase 2'),
(2087505, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34338, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Damage Reduction: Shadow\''),
-- (2087505, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34399, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Shadow Energy\''),
(2087505, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36733, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Elemental Response\''),
(2087505, 9, 4, 0, 0, 0, 100, 0, 3000, 8000, 0, 0, 0, 11, 36736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Shadow Bolt Volley\''),
(2087505, 9, 5, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Remove All Auras'),
(2087505, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Set Event Phase 1'),

(2087506, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Set Event Phase 2'),
(2087506, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34336, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Damage Reduction: Holy\''),
-- (2087506, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34403, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Holy Energy\''),
(2087506, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36733, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Elemental Response\''),
(2087506, 9, 4, 0, 0, 0, 100, 0, 3000, 8000, 0, 0, 0, 11, 36743, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Cast \'Holy Bolt Volley\''),
(2087506, 9, 5, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Remove All Auras'),
(2087506, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Set Event Phase 1');

-- Negatron Warp-Master
DELETE FROM `creature_text` WHERE `CreatureID`=20873;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20873, 0, 0, 'Void energy gathers at the base of the %s!', 16, 0, 100, 0, 0, 0, 19392, 0, 'Negaton Warp-Master');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (20873, -138937, -138938) AND `id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20873, 0, 0, 1, 0, 0, 100, 0, 15000, 22000, 15000, 22000, 0, 11, 36813, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Warp-Master - In Combat - Cast \'Summon Negaton Field\''),
(20873, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Warp-Master - On Link - Say Line 0'),

(-138937, 0, 0, 1, 0, 0, 100, 0, 15000, 22000, 15000, 22000, 0, 11, 36813, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Warp-Master - In Combat - Cast \'Summon Negaton Field\''),
(-138937, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Warp-Master - On Link - Say Line 0'),

(-138938, 0, 0, 1, 0, 0, 100, 0, 15000, 22000, 15000, 22000, 0, 11, 36813, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Warp-Master - In Combat - Cast \'Summon Negaton Field\''),
(-138938, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Warp-Master - On Link - Say Line 0');

-- Eredar Soul-Eater
DELETE FROM `creature_template_addon` WHERE (`entry` IN (21595, 20879));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(20879, 0, 0, 0, 1, 0, 0, '36784'),
(21595, 0, 0, 0, 1, 0, 0, '36784');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20879 AND `id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20879, 0, 0, 0, 0, 0, 100, 0, 6000, 15000, 15000, 22000, 0, 11, 36786, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eredar Soul-Eater - In Combat - Cast \'Soul Chill\''),
(20879, 0, 1, 0, 0, 0, 100, 0, 15000, 17000, 14000, 21000, 0, 11, 36778, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Eredar Soul-Eater - In Combat - Cast \'Soul Steal\''),
(20879, 0, 2, 0, 31, 0, 100, 0, 36778, 0, 0, 0, 0, 11, 36782, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eredar Soul-Eater - On Target Spellhit \'Soul Steal\' - Cast \'Soul Steal\'');

-- Eredar Deathbringer
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '27987 36788' WHERE (`entry` = 20880);
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '38844 38847' WHERE (`entry` = 21594);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 20880) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20880, 0, 0, 0, 0, 0, 100, 0, 6000, 12000, 8000, 14000, 0, 11, 36787, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Eredar Deathbringer - In Combat - Cast \'Forceful Cleave\'');

-- Unbound Devastator
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (20881, -138945)) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20881, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 13000, 22000, 0, 11, 36887, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - In Combat - Cast \'Deafening Roar\''),
(20881, 0, 1, 0, 9, 0, 100, 0, 0, 8, 14000, 21000, 0, 11, 36891, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - Within 0-8 Range - Cast \'Devastate\''),

(-138945, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 13000, 22000, 0, 11, 36887, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - In Combat - Cast \'Deafening Roar\''),
(-138945, 0, 1, 0, 9, 0, 100, 0, 0, 8, 14000, 21000, 0, 11, 36891, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - Within 0-8 Range - Cast \'Devastate\'');

-- Spiteful Temptress
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (20883, -138949)) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20883, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 12000, 16000, 0, 11, 36886, 0, 0, 0, 0, 0, 6, 50, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - In Combat - Cast \'Spiteful Fury\''),
(20883, 0, 1, 0, 0, 0, 100, 0, 14000, 15000, 25000, 25000, 0, 11, 36866, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - In Combat - Cast \'Domination\''),
(20883, 0, 2, 0, 9, 0, 100, 0, 0, 40, 7000, 12000, 0, 11, 36868, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - Within 0-40 Range - Cast \'Shadow Bolt\''),

(-138949, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 12000, 16000, 0, 11, 36886, 0, 0, 0, 0, 0, 6, 50, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - In Combat - Cast \'Spiteful Fury\''),
(-138949, 0, 1, 0, 0, 0, 100, 0, 14000, 15000, 25000, 25000, 0, 11, 36866, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - In Combat - Cast \'Domination\''),
(-138949, 0, 2, 0, 9, 0, 100, 0, 0, 40, 7000, 12000, 0, 11, 36868, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - Within 0-40 Range - Cast \'Shadow Bolt\'');

-- Skulking Witch
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2088200, 2088201));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2088200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36863, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skulking Witch - Actionlist - Cast \'Chastise\''),
(2088201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36864, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skulking Witch - Actionlist - Cast \'Lash of Pain\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 20882) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20882, 0, 0, 0, 0, 0, 100, 0, 4000, 10000, 10000, 20000, 0, 11, 36862, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skulking Witch - In Combat - Cast \'Gouge\''),
(20882, 0, 1, 0, 0, 0, 100, 0, 5000, 8000, 14000, 21000, 0, 87, 2088200, 2088201, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skulking Witch - In Combat - Cast Random Spell');

-- Ethereum Slayer
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 20896) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20896, 0, 0, 0, 0, 0, 100, 0, 8000, 15000, 20000, 25000, 0, 11, 15087, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Slayer - In Combat - Cast \'Evasion\''),
(20896, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 8000, 13000, 0, 11, 36839, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Slayer - In Combat - Cast \'Impairing Poison\''),
(20896, 0, 2, 0, 0, 0, 100, 0, 10000, 15000, 10000, 15000, 0, 11, 36838, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Slayer - In Combat - Cast \'Slaying Strike\'');

-- Ethereum Wave-Caster
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 20897) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20897, 0, 0, 0, 0, 0, 100, 0, 10000, 15000, 19000, 25000, 0, 11, 36840, 32, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Wave-Caster - In Combat - Cast \'Polymorph\''),
(20897, 0, 1, 0, 0, 0, 100, 0, 10000, 20000, 10000, 20000, 0, 11, 32693, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Wave-Caster - In Combat - Cast \'Arcane Haste\''),
(20897, 0, 2, 0, 0, 0, 100, 0, 15000, 19000, 15000, 19000, 0, 11, 38897, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Wave-Caster - In Combat - Cast \'Sonic Boom\'');

-- Ethereum Life-Binder
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21702) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21702, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 15000, 0, 11, 37480, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Life-Binder - In Combat - Cast \'Bind\''),
(21702, 0, 1, 0, 0, 0, 100, 2, 8000, 15000, 10000, 10000, 0, 11, 15654, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Life-Binder - In Combat - Cast \'Shadow Word: Pain\' (Normal Dungeon)'),
(21702, 0, 2, 0, 0, 0, 100, 4, 8000, 15000, 10000, 10000, 0, 11, 34941, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Life-Binder - In Combat - Cast \'Shadow Word: Pain\' (Heroic Dungeon)'),
(21702, 0, 3, 0, 74, 0, 100, 0, 0, 40, 5000, 10000, 40, 11, 37479, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Life-Binder - On Friendly Between 0-40% Health - Cast \'Shadow Mend\'');

-- Sargeron Hellcaller
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 20902) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20902, 0, 0, 0, 0, 0, 100, 0, 7000, 10000, 13000, 20000, 0, 11, 36829, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Hellcaller - In Combat - Cast \'Hell Rain\''),
(20902, 0, 1, 0, 0, 0, 100, 0, 8000, 13000, 11000, 15000, 0, 11, 36832, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Hellcaller - In Combat - Cast \'Incinerate\''),
(20902, 0, 2, 0, 0, 0, 100, 0, 7000, 10000, 16000, 21000, 0, 11, 36831, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Hellcaller - In Combat - Cast \'Curse of the Elements\'');

-- Sargeron Archer
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 20901) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20901, 0, 0, 0, 0, 0, 100, 2, 0, 0, 2400, 4800, 0, 11, 22907, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat CMC - Cast \'Shoot\' (Normal Dungeon)'),
(20901, 0, 1, 0, 0, 0, 100, 4, 0, 0, 2400, 4800, 0, 11, 38940, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat CMC - Cast \'Shoot\' (Heroic Dungeon)'),
(20901, 0, 2, 0, 0, 0, 100, 0, 12000, 18000, 15000, 20000, 0, 11, 36827, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat - Cast \'Hooked Net\''),
(20901, 0, 3, 0, 0, 0, 100, 0, 12000, 15000, 17000, 23000, 0, 87, 2090100, 2090101, 2090102, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat - Cast Random Spell'),
(20901, 0, 4, 0, 0, 0, 100, 0, 13000, 16000, 18000, 22000, 0, 11, 23601, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat - Cast \'Scatter Shot\''),
(20901, 0, 5, 0, 2, 0, 100, 0, 0, 30, 23000, 30000, 0, 11, 36828, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - Between 0-30% Health - Cast \'Rapid Fire\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2090100, 2090101, 2090102));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2090100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35964, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - On Script - Cast \'Frost Arrow\''),
(2090101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35932, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - On Script - Cast \'Immolation Arrow\''),
(2090102, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36984, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - On Script - Cast \'Serpent Sting\'');

-- Unchained Doombringer
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 20900) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20900, 0, 0, 0, 0, 0, 100, 0, 12000, 15000, 24000, 27000, 0, 11, 36835, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unchained Doombringer - In Combat - Cast \'War Stomp\''),
(20900, 0, 1, 0, 0, 0, 100, 0, 10000, 13000, 23000, 30000, 0, 11, 36833, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Unchained Doombringer - In Combat - Cast \'Berserker Charge\''),
(20900, 0, 2, 0, 0, 0, 100, 0, 7000, 9000, 13000, 16000, 0, 11, 36836, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Unchained Doombringer - In Combat - Cast \'Agonizing Armor\'');

-- Gargantuan Abyssal
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 20898) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20898, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 10000, 12000, 0, 11, 38855, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargantuan Abyssal - In Combat - Cast \'Fire Shield\''),
(20898, 0, 1, 0, 0, 0, 100, 0, 7000, 9000, 12000, 17000, 0, 11, 36837, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargantuan Abyssal - In Combat - Cast \'Meteor\'');

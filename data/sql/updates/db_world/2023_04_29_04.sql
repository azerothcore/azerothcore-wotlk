-- DB update 2023_04_29_03 -> 2023_04_29_04
-- Kidney Shot updates
UPDATE `smart_scripts` SET `event_param1` = 6100, `event_param2` = 17200, `event_param3` = 20650, `event_param4` = 26950 WHERE (`entryorguid` = 17264) AND (`source_type` = 0) AND (`id` = 2); -- Bonechewer Ravener
UPDATE `smart_scripts` SET `event_param1` = 5700, `event_param2` = 25050, `event_param3` = 15400, `event_param4` = 25050 WHERE (`entryorguid` = 17517) AND (`source_type` = 0) AND (`id` = 0); -- Hellfire Sentry

-- Complete Rewrites
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (17259, 17271, 17269));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17259, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Hungerer - On Aggro - Say Line 0'),
(17259, 0, 1, 0, 0, 0, 100, 0, 1200, 12050, 10900, 27600, 0, 11, 16244, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Hungerer - In Combat - Cast \'Demoralizing Shout\''),
(17259, 0, 2, 0, 0, 0, 100, 0, 3700, 17400, 6100, 19750, 0, 11, 6713, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Hungerer - In Combat - Cast \'Disarm\''),
(17259, 0, 3, 0, 0, 0, 100, 0, 3700, 23550, 6100, 19750, 0, 11, 14516, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Hungerer - In Combat - Cast \'Strike\''),
(17271, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Destroyer - On Aggro - Say Line 0'),
(17271, 0, 1, 0, 0, 0, 100, 0, 3200, 10900, 6500, 18600, 0, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Destroyer - In Combat - Cast \'Mortal Strike\''),
(17271, 0, 2, 3, 0, 0, 100, 0, 19300, 31400, 11100, 27100, 0, 11, 10101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Destroyer - In Combat - Cast \'Knock Away\''),
(17271, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 13, 0, 35, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Destroyer - In Combat - Set Single Threat 0-35'),
(17269, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster - On Aggro - Say Line 0'),
(17269, 0, 1, 0, 0, 0, 100, 2, 0, 2050, 1750, 2050, 0, 11, 15241, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster - In Combat - Cast \'Scorch\' (Normal Dungeon)'),
(17269, 0, 2, 0, 0, 0, 100, 4, 0, 2050, 1750, 2050, 0, 11, 36807, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster - In Combat - Cast \'Scorch\' (Heroic Dungeon)'),
(17269, 0, 3, 0, 0, 0, 100, 2, 15650, 23000, 20650, 31600, 0, 11, 20754, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster - In Combat - Cast \'Rain of Fire\' (Normal Dungeon)'),
(17269, 0, 4, 0, 0, 0, 100, 4, 15650, 23000, 20650, 31600, 0, 11, 36808, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster - In Combat - Cast \'Rain of Fire\' (Heroic Dungeon)');

-- Partial Rewrites
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17280) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17280, 0, 0, 0, 0, 0, 100, 0, 1050, 9100, 12150, 24350, 0, 11, 30636, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Warhound - In Combat - Cast \'Furious Howl\''),
(17280, 0, 1, 0, 0, 0, 100, 0, 3700, 15800, 3700, 15800, 0, 11, 30639, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Warhound - In Combat - Cast \'Carnivorous Bite\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17478) AND (`source_type` = 0) AND (`id` IN (3, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17478, 0, 3, 0, 0, 0, 100, 2, 800, 1700, 3600, 4700, 0, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Scryer - In Combat - Cast \'Shadow Bolt\' (Normal Dungeon)'),
(17478, 0, 4, 0, 0, 0, 100, 4, 800, 1700, 3600, 4700, 0, 11, 15232, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Scryer - In Combat - Cast \'Shadow Bolt\' (Heroic Dungeon)'),
(17478, 0, 5, 0, 0, 0, 100, 0, 4850, 23500, 15450, 23800, 0, 11, 30615, 1, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Scryer - In Combat - Cast \'Fear\'');

-- DB update 2023_03_20_04 -> 2023_03_20_05
--
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (35012,35243,35261,36340,36348,35265,35267,36345,35056,35057);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(35012, 35012, 38941),
(35243, 35243, 38935),
(35261, 35261, 38936),
(36340, 36340, 38921),
(36348, 36348, 38919),
(35265, 35265, 38933),
(35267, 35267, 38930),
(36345, 36345, 39196),
(35056, 35056, 38923),
(35057, 35057, 38925);

-- Tempest-Forge Patroller
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (19166, -138801, -138803)) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19166, 0, 0, 0, 1, 0, 50, 0, 30000, 120000, 120000, 240000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - Out of Combat - Say Line 0'),
(19166, 0, 1, 0, 0, 0, 100, 0, 6100, 10400, 6800, 16900, 0, 11, 35012, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - In Combat - Cast \'Charged Arcane Missile\''),
(19166, 0, 2, 0, 0, 0, 100, 0, 9700, 16400, 12500, 20500, 0, 11, 35011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - In Combat - Cast \'Knockdown\''),
(19166, 0, 3, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 39, 30, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - Between 0-50% Health - Call For Help (No Repeat)'),

(-138801, 0, 0, 0, 1, 0, 50, 0, 30000, 120000, 120000, 240000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - Out of Combat - Say Line 0'),
(-138801, 0, 1, 0, 0, 0, 100, 0, 6100, 10400, 6800, 16900, 0, 11, 35012, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - In Combat - Cast \'Charged Arcane Missile\''),
(-138801, 0, 2, 0, 0, 0, 100, 0, 9700, 16400, 12500, 20500, 0, 11, 35011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - In Combat - Cast \'Knockdown\''),
(-138801, 0, 3, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 39, 30, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - Between 0-50% Health - Call For Help (No Repeat)'),

(-138803, 0, 0, 0, 1, 0, 50, 0, 30000, 120000, 120000, 240000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - Out of Combat - Say Line 0'),
(-138803, 0, 1, 0, 0, 0, 100, 0, 6100, 10400, 6800, 16900, 0, 11, 35012, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - In Combat - Cast \'Charged Arcane Missile\''),
(-138803, 0, 2, 0, 0, 0, 100, 0, 9700, 16400, 12500, 20500, 0, 11, 35011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - In Combat - Cast \'Knockdown\''),
(-138803, 0, 3, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 39, 30, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - Between 0-50% Health - Call For Help (No Repeat)');

-- Tempest-Forge Destroyer
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19735);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19735, 0, 0, 0, 0, 0, 100, 0, 8400, 16900, 9600, 20500, 0, 11, 36582, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - In Combat - Cast \'Charged Fist\''),
(19735, 0, 1, 0, 0, 0, 100, 0, 9700, 10800, 10900, 22900, 0, 11, 35783, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - In Combat - Cast \'Knockdown\'');

-- Sunseeker Netherbinder
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 20059) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20059, 0, 0, 0, 0, 0, 100, 0, 12100, 19300, 10800, 25300, 0, 11, 35243, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast \'Starfire\''),
(20059, 0, 1, 0, 9, 0, 100, 0, 0, 8, 10800, 25300, 0, 11, 35261, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - Within 0-8 Range - Cast \'Arcane Nova\''),
(20059, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 10000, 10000, 0, 11, 17201, 0, 0, 0, 0, 0, 26, 30, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast \'Dispel Magic\''),
(20059, 0, 3, 4, 0, 0, 100, 0, 14100, 18900, 63200, 68100, 0, 11, 35251, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast \'Summon Arcane Golem\''),
(20059, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35260, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast \'Summon Arcane Golem\'');

-- Bloodwarder Centurion
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (1951000, 1951001, 1951002, 1951003)) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1951000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 1, 29403, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - On Script - Set Mainhand Item'),
(1951000, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35186, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - On Script - Cast \'Melt Armor Proc\''),
(1951001, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 1, 29404, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - On Script - Set Mainhand Item'),
(1951001, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35187, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - On Script - Cast \'Arcane Explosion Proc\''),
(1951002, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 1, 29405, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - On Script - Set Mainhand Item'),
(1951002, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35188, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - On Script - Cast \'Chilling Touch\''),
(1951003, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 1, 29406, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - On Script - Set Mainhand Item'),
(1951003, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35184, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - On Script - Cast \'Unstable Affliction Proc\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19510) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19510, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 88, 1951000, 1951003, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - On Aggro - Run Random Script'),
(19510, 0, 1, 0, 0, 0, 100, 0, 6200, 19300, 12100, 16900, 0, 11, 35178, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - In Combat - Cast \'Shield Bash\'');

UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '' WHERE (`entry` IN (19510, 21522));

-- Bloodwarder Physician
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 20990) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20990, 0, 0, 0, 0, 0, 100, 0, 8400, 19300, 7200, 19300, 0, 11, 36340, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - In Combat - Cast \'Holy Shock\''),
(20990, 0, 1, 0, 74, 0, 100, 0, 0, 75, 10000, 16000, 15, 11, 36348, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Friendly Between 0-75% Health - Cast \'Bandage\''),
(20990, 0, 2, 0, 0, 0, 100, 0, 9000, 14000, 12000, 16000, 0, 11, 36333, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - In Combat - Cast \'Anesthetic\'');

-- Bloodwarder Slayer
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (1916700, 1916701, 1916702, 1916703)) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1916700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Script - Set Event Phase 1'),
(1916700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 1, 29407, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Script - Set Mainhand Item'),
(1916700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 28, 35191, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Script - Remove Aura \'Arcane Explosion Proc\''),
(1916700, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35192, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Script - Cast \'Melt Armor Proc\''),
(1916701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Script - Set Event Phase 2'),
(1916701, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 1, 29408, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Script - Set Mainhand Item'),
(1916701, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 28, 35191, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Script - Remove Aura \'Arcane Explosion Proc\''),
(1916701, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35193, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Script - Cast \'Seed of Corruption Proc\''),
(1916702, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Script - Set Event Phase 3'),
(1916702, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 1, 29409, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Script - Set Mainhand Item'),
(1916702, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 28, 35191, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Script - Remove Aura \'Arcane Explosion Proc\''),
(1916702, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35188, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Script - Cast \'Chilling Touch\''),
(1916703, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Script - Set Event Phase 4'),
(1916703, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 1, 29410, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Script - Set Mainhand Item');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19167) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19167, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35191, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Spawn - Cast \'Arcane Explosion Proc\''),
(19167, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 88, 1916700, 1916703, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - On Aggro - Run Random Script'),
(19167, 0, 2, 0, 0, 3, 100, 0, 7200, 10600, 12100, 22900, 0, 11, 35189, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - In Combat - Cast \'Solar Strike\' (Phase 1, 2)'),
(19167, 0, 3, 0, 0, 12, 100, 0, 7700, 7700, 10900, 21700, 0, 11, 15708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - In Combat - Cast \'Mortal Strike\' (Phase 3, 4)'),
(19167, 0, 4, 0, 0, 0, 100, 0, 9800, 22900, 10900, 26500, 0, 11, 13736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - In Combat - Cast \'Whirlwind\'');

-- Sunseeker Astromage
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19168);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19168, 0, 0, 0, 0, 0, 100, 0, 4800, 16100, 3000, 5000, 0, 11, 35265, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Fire Shield\''),
(19168, 0, 1, 0, 0, 0, 100, 2, 3100, 7600, 12100, 21700, 0, 11, 17195, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Scorch\' (Normal Dungeon)'),
(19168, 0, 2, 0, 0, 0, 100, 4, 3100, 7600, 12100, 21700, 0, 11, 36807, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Scorch\' (Heroic Dungeon)'),
(19168, 0, 3, 0, 0, 0, 100, 0, 4800, 26700, 13200, 27700, 0, 11, 35267, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Solarburn\'');

-- Sunseeker Engineer
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20988);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20988, 0, 0, 0, 0, 0, 100, 0, 1300, 9600, 21700, 30200, 0, 11, 36341, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast \'Super Shrink Ray\''),
(20988, 0, 1, 0, 0, 0, 100, 0, 5100, 16400, 12100, 22900, 0, 11, 36345, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast \'Death Ray\''),
(20988, 0, 2, 0, 16, 0, 100, 0, 36346, 15, 18100, 24100, 0, 11, 36346, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - On Friendly Unit Missing Buff \'Growth Ray\' - Cast \'Growth Ray\'');

-- Mechanar Crusher
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19231);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19231, 0, 0, 0, 0, 0, 100, 0, 11100, 19300, 22900, 28900, 0, 11, 35056, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Crusher - In Combat - Cast \'Glob of Machine Fluid\''),
(19231, 0, 1, 0, 0, 0, 100, 0, 7800, 13200, 13300, 21200, 0, 11, 35055, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Crusher - In Combat - Cast \'The Claw\'');

-- Mechanar Driller
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19712);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19712, 0, 0, 0, 0, 0, 100, 0, 13300, 37400, 21700, 33800, 0, 11, 35056, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Driller - In Combat - Cast \'Glob of Machine Fluid\''),
(19712, 0, 1, 0, 0, 0, 100, 0, 4700, 18100, 7200, 16900, 0, 11, 35047, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Driller - In Combat - Cast \'Drill Armor\'');

-- Mechanar Tinkerer
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19716);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19716, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - On Reset - Set Phase 1'),
(19716, 0, 1, 0, 0, 1, 100, 0, 0, 0, 1200, 1200, 0, 11, 35057, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - In Combat CMC - Cast \'Netherbomb\' (Normal Dungeon) (Phase 1)'),
(19716, 0, 2, 3, 2, 0, 100, 1, 0, 50, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - Between 0-50% Health - Set Phase 2 (No Repeat)'),
(19716, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35062, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - On Link - Cast \'Maniacal Charge\''),
(19716, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - On Link - Set Reactstate Passive'),
(19716, 0, 5, 6, 0, 2, 100, 1, 2000, 2000, 0, 0, 0, 11, 35058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - In Combat - Cast \'Nether Explosion\' (No Repeat) (Phase 2)'),
(19716, 0, 6, 0, 61, 2, 100, 1, 0, 0, 0, 0, 0, 11, 29878, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - On Link - Cast \'Instakill Self\' (No Repeat) (Phase 2)');

-- Mechanar Wrecker
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19713);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19713, 0, 0, 0, 0, 0, 100, 0, 15200, 27700, 21700, 36800, 0, 11, 35056, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Wrecker - In Combat - Cast \'Glob of Machine Fluid\''),
(19713, 0, 1, 0, 0, 0, 100, 0, 15700, 22500, 17300, 26500, 0, 11, 35049, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Wrecker - In Combat - Cast \'Pound\'');

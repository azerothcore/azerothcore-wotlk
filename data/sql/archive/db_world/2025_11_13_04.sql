-- DB update 2025_11_13_03 -> 2025_11_13_04

-- Set Sniffed Unit_flag (Vrykul Harpoon Gun)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~ 4 WHERE (`entry` = 27992);
UPDATE `creature_template` SET `unit_flags` = `unit_flags` |33554432 WHERE (`entry` = 27992);

-- Set Sniffed Movement Flags (Vrykul Harpoon Gun & Dragonflayer Defender)
DELETE FROM `creature_template_movement` WHERE (`CreatureId` IN (24533, 27992));
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(24533, 0, 0, 1, 0, 0, 0, 0),
(27992, 0, 0, 0, 1, 0, 0, 0);

-- Update SmartAI (Vrykul Harpoon Gun)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27992;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27992);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27992, 0, 0, 0, 27, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vrykul Harpoon Gun - On Passenger Boarded - Remove Flags Not Selectable'),
(27992, 0, 1, 0, 28, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vrykul Harpoon Gun - On Passenger Removed - Set Flags Not Selectable'),
(27992, 0, 2, 3, 38, 0, 100, 512, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vrykul Harpoon Gun - On Data Set 1 1 - Say Line 0'),
(27992, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2799200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vrykul Harpoon Gun - On Data Set 1 1 - Run Script'),
(27992, 0, 4, 5, 38, 0, 100, 512, 1, 2, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vrykul Harpoon Gun - On Data Set 1 2 - Say Line 1'),
(27992, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2799201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vrykul Harpoon Gun - On Data Set 1 2 - Run Script'),
(27992, 0, 6, 7, 38, 0, 100, 512, 1, 3, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vrykul Harpoon Gun - On Data Set 1 3 - Say Line 2'),
(27992, 0, 7, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2799202, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vrykul Harpoon Gun - On Data Set 1 3 - Run Script'),
(27992, 0, 8, 0, 31, 0, 100, 512, 43997, 0, 0, 0, 0, 0, 11, 43998, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vrykul Harpoon Gun - On Target Spellhit \'Fiery Lance\' - Cast \'Fiery Lance\'');

-- Update Action Lists (sniffed Spawn Points)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2799200, 2799201, 2799202));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2799200, 9, 0, 0, 0, 0, 100, 512, 3000, 3000, 0, 0, 0, 0, 12, 24533, 4, 60000, 0, 1, 0, 8, 0, 0, 0, 0, 1055.92, -5139.29, 177.646, 4.2569, 'Vrykul Harpoon Gun - Actionlist - Summon Creature \'Dragonflayer Defender\''),
(2799200, 9, 1, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 12, 24533, 4, 60000, 0, 1, 0, 8, 0, 0, 0, 0, 1011.96, -5124.65, 185.217, 4.2505, 'Vrykul Harpoon Gun - Actionlist - Summon Creature \'Dragonflayer Defender\''),
(2799200, 9, 2, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 12, 24533, 4, 60000, 0, 1, 0, 8, 0, 0, 0, 0, 1073.53, -5130.63, 209.704, 4.0369, 'Vrykul Harpoon Gun - Actionlist - Summon Creature \'Dragonflayer Defender\''),
(2799200, 9, 3, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 12, 24533, 4, 60000, 0, 1, 0, 8, 0, 0, 0, 0, 1127.55, -5177.06, 212.394, 4.1176, 'Vrykul Harpoon Gun - Actionlist - Summon Creature \'Dragonflayer Defender\''),
(2799201, 9, 0, 0, 0, 0, 100, 512, 3000, 3000, 0, 0, 0, 0, 12, 24533, 4, 60000, 0, 1, 0, 8, 0, 0, 0, 0, 1091.66, -5150.43, 121.44, 4.0841, 'Vrykul Harpoon Gun - Actionlist - Summon Creature \'Dragonflayer Defender\''),
(2799201, 9, 1, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 12, 24533, 4, 60000, 0, 1, 0, 8, 0, 0, 0, 0, 1024.17, -5117.84, 141.756, 4.1904, 'Vrykul Harpoon Gun - Actionlist - Summon Creature \'Dragonflayer Defender\''),
(2799201, 9, 2, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 12, 24533, 4, 60000, 0, 1, 0, 8, 0, 0, 0, 0, 964.811, -5123.2, 111.064, 3.997, 'Vrykul Harpoon Gun - Actionlist - Summon Creature \'Dragonflayer Defender\''),
(2799202, 9, 0, 0, 0, 0, 100, 512, 3000, 3000, 0, 0, 0, 0, 12, 24533, 4, 60000, 0, 1, 0, 8, 0, 0, 0, 0, 1132.96, -5170, 261.992, 3.9751, 'Vrykul Harpoon Gun - Actionlist - Summon Creature \'Dragonflayer Defender\''),
(2799202, 9, 1, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 12, 24533, 4, 60000, 0, 1, 0, 8, 0, 0, 0, 0, 1115.01, -5161.58, 207.852, 4.3169, 'Vrykul Harpoon Gun - Actionlist - Summon Creature \'Dragonflayer Defender\''),
(2799202, 9, 2, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 12, 24533, 4, 60000, 0, 1, 0, 8, 0, 0, 0, 0, 1168.37, -5220.4, 243.869, 3.7683, 'Vrykul Harpoon Gun - Actionlist - Summon Creature \'Dragonflayer Defender\'');

-- Set SmartAI (Dragonflayer Defender)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24533;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24533);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24533, 0, 0, 0, 0, 0, 100, 0, 500, 1000, 2000, 2000, 0, 0, 11, 44188, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Defender - In Combat - Cast \'Harpoon Toss\''),
(24533, 0, 1, 0, 8, 0, 100, 0, 43997, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Defender - On Spellhit \'Fiery Lance\' - Kill Self'),
(24533, 0, 2, 3, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 117, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Defender - On Just Summoned - Disable Evade'),
(24533, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 25, 0, 1, 0, 1, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Defender - On Just Summoned - Move To Owner Or Summoner'),
(24533, 0, 4, 5, 34, 0, 100, 0, 0, 25, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Defender - On Reached Point 25 - Set Home Position'),
(24533, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Defender - On Reached Point 25 - Enable Evade'),
(24533, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Defender - On Reached Point 25 - Start Attacking');

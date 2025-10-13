-- DB update 2025_09_12_00 -> 2025_09_12_01
--
-- Shadowstalker Getry
-- Generate comments (all) with Keira
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25729) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25729, 0, 0, 1, 19, 0, 100, 512, 11705, 0, 0, 0, 0, 0, 53, 0, 25729, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - On Quest \'Foolish Endeavors\' Taken - Start Waypoint Path 25729'),
(25729, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - On Quest \'Foolish Endeavors\' Taken - Say Line 0'),
(25729, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 25729, 0, 0, 0, 0, 0, 19, 25618, 150, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - On Quest \'Foolish Endeavors\' Taken - Set Data 25729 0'),
(25729, 0, 3, 0, 40, 0, 100, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - On Point 1 of Path Any Reached - Say Line 1'),
(25729, 0, 4, 5, 40, 0, 100, 0, 14, 0, 0, 0, 0, 0, 11, 58506, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - On Point 14 of Path Any Reached - Cast \'Stealth\''),
(25729, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - On Point 14 of Path Any Reached - Set Reactstate Passive'),
(25729, 0, 6, 7, 8, 0, 100, 512, 45923, 0, 0, 0, 0, 0, 28, 58506, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - On Spellhit \'Shadow Prison\' - Remove Aura \'Stealth\''),
(25729, 0, 7, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - On Spellhit \'Shadow Prison\' - Set Home Position'),
(25729, 0, 8, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2572901, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - On Spellhit \'Shadow Prison\' - Run Script'),
(25729, 0, 9, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 0, 80, 2572900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - On Data Set 1 1 - Run Script');
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2572900) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2572900, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - Actionlist - Say Line 2'),
(2572900, 9, 1, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - Actionlist - Say Line 3'),
(2572900, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 25751, 30, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - Actionlist - Say Line 5'),
(2572900, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25751, 30, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - Actionlist - Despawn Instant'),
(2572900, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - Actionlist - Despawn Instant');
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2572901) AND (`source_type` = 9) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2572901, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 45922, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - Actionlist - Cast \'Shadow Prison\'');

-- Varidus the Flenser
-- Generate comments (all) with Keira
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25618) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25618, 0, 0, 1, 38, 0, 100, 512, 25729, 0, 0, 0, 0, 0, 80, 2561800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - On Data Set 25729 0 - Run Script'),
(25618, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - On Data Set 25729 0 - Set Flags Not Attackable & Immune To Players & Immune To NPC\'s'),
(25618, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 10000, 10000, 0, 0, 11, 32711, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - In Combat - Cast \'Shadow Nova\''),
(25618, 0, 3, 4, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 15, 11705, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - On Just Died - Quest Credit \'Foolish Endeavors\''),
(25618, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 25729, 40, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - On Just Died - Set Data 1 1');
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2561800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2561800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45908, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Cast \'Shield of Suffering\''),
(2561800, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Set Run Off'),
(2561800, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3125, 6534, 80.1, 0, 'Varidus the Flenser - Actionlist - Move To Position'),
(2561800, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.11, 'Varidus the Flenser - Actionlist - Set Orientation 4.11'),
(2561800, 9, 4, 0, 0, 0, 100, 0, 32000, 32000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Say Line 0'),
(2561800, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.52, 'Varidus the Flenser - Actionlist - Set Orientation 1.52'),
(2561800, 9, 6, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Say Line 1'),
(2561800, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Set Home Position'),
(2561800, 9, 8, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 45923, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Cast \'Shadow Prison\''),
(2561800, 9, 9, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 12, 25730, 4, 120000, 0, 0, 0, 8, 0, 0, 0, 0, 3149, 6527, 80.84, 2.6, 'Varidus the Flenser - Actionlist - Summon Creature \'En\'kilah Necrolord\''),
(2561800, 9, 10, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Say Line 2'),
(2561800, 9, 11, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Say Line 3'),
(2561800, 9, 12, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Say Line 4'),
(2561800, 9, 13, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Say Line 5'),
(2561800, 9, 14, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Say Line 6'),
(2561800, 9, 15, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Say Line 7'),
(2561800, 9, 16, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Say Line 8'),
(2561800, 9, 17, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Say Line 9'),
(2561800, 9, 18, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Say Line 10'),
(2561800, 9, 19, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 19, 770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Remove Flags Not Attackable & Immune To Players & Immune To NPC\'s'),
(2561800, 9, 20, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Remove Aura \'null\''),
(2561800, 9, 21, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 50329, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Cast \'Shield of Suffering\''),
(2561800, 9, 22, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Remove Flags Not Attackable & Immune To Players & Immune To NPC\'s'),
(2561800, 9, 23, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 25751, 30, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Start Attacking'),
(2561800, 9, 24, 0, 0, 0, 100, 0, 100000, 100000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25729, 100, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Despawn Instant'),
(2561800, 9, 25, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25751, 100, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Despawn Instant'),
(2561800, 9, 26, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Despawn Instant');

-- En'kilah Necrolord
-- Generate comments (all) with Keira
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25730) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25730, 0, 0, 0, 37, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2573000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - On Initialize - Run Script'),
(25730, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 10000, 10000, 0, 0, 11, 24573, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - In Combat - Cast \'Mortal Strike\''),
(25730, 0, 2, 0, 0, 0, 100, 0, 2000, 2000, 11000, 11000, 0, 0, 11, 16044, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - In Combat - Cast \'Cleave\''),
(25730, 0, 3, 0, 0, 0, 100, 0, 10000, 10000, 30000, 40000, 0, 0, 11, 41097, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - In Combat - Cast \'Whirlwind\'');
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2573000) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2573000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Set Faction 14'),
(2573000, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(2573000, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Set Run Off'),
(2573000, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3126, 6539, 80.05, 0, 'En\'kilah Necrolord - Actionlist - Move To Position'),
(2573000, 9, 4, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.52, 'En\'kilah Necrolord - Actionlist - Set Orientation 1.52'),
(2573000, 9, 5, 0, 0, 0, 100, 0, 24000, 24000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.11, 'En\'kilah Necrolord - Actionlist - Set Orientation 4.11'),
(2573000, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 36, 25751, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Update Template To \'High Overlord Saurfang\''),
(2573000, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(2573000, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 1979, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Set Faction 1979'),
(2573000, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Say Line 0'),
(2573000, 9, 10, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Say Line 1'),
(2573000, 9, 11, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Say Line 2'),
(2573000, 9, 12, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Say Line 3'),
(2573000, 9, 13, 0, 0, 0, 100, 0, 14000, 14000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Say Line 4'),
(2573000, 9, 14, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 11, 45950, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Cast \'Saurfang`s Rage\''),
(2573000, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(2573000, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45949, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Cast \'Release Aberration\''),
(2573000, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Set Home Position');

-- Varidus the Flenser
-- Set target nearest player for Talk
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2561800) AND (`source_type` = 9) AND (`id` IN (14));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2561800, 9, 14, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Say Line 6');

-- Varidus the Flenser
-- Increase forced despawn timer from 100s to 180s
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2561800) AND (`source_type` = 9) AND (`id` IN (24));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2561800, 9, 24, 0, 0, 0, 100, 0, 180000, 180000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25729, 100, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Despawn Instant');

-- Update template to High Overlord Saurfang
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2573000) AND (`source_type` = 9) AND (`id` IN (6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2573000, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 36, 25749, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - Actionlist - Update Template To \'High Overlord Saurfang\'');

-- Shadowstalker Getry
-- Talk before starting waypoint
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25729) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25729, 0, 0, 1, 19, 0, 100, 512, 11705, 0, 0, 0, 0, 0, 1, 0, 3000, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - On Quest \'Foolish Endeavors\' Taken - Say Line 0'),
(25729, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 25729, 0, 0, 0, 0, 0, 19, 25618, 150, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - On Quest \'Foolish Endeavors\' Taken - Set Data 25729 0'),
(25729, 0, 2, 3, 52, 0, 100, 512, 0, 25729, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - On Text 0 Over - Say Line 1'),
(25729, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 0, 25729, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - On Text 0 Over - Start Waypoint Path 25729');

-- High Overlord Saurfang
-- Copy texts from 25751 to 25749
DELETE FROM `creature_text` WHERE (`CreatureID` = 25749) AND (`GroupID` IN (0, 1, 2, 3, 4, 5, 6, 7));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25749, 0, 0, 'I\'ll rip your shriveled heart out with my bare hands before any harm comes to $n, necromancer.', 12, 1, 100, 5, 0, 0, 24918, 0, 'High Overlord Saurfang'),
(25749, 1, 0, 'You were never alone, $n.', 12, 1, 100, 1, 0, 0, 24919, 0, 'High Overlord Saurfang'),
(25749, 2, 0, 'This world that you seek to destroy is our home.', 12, 1, 100, 1, 0, 0, 24920, 0, 'High Overlord Saurfang'),
(25749, 3, 0, 'We will fight you with every fiber of our being - until we are nothing more than dust and debris. We will fight until the end.', 12, 1, 100, 1, 0, 0, 24924, 0, 'High Overlord Saurfang'),
(25749, 4, 0, 'A fool who is about to end you, necrolord. There will be nothing left of you for the Lich King to reanimate!', 12, 1, 100, 397, 0, 0, 24927, 0, 'High Overlord Saurfang'),
(25749, 5, 0, '%s\'s eyes glow red for a brief moment.', 16, 0, 100, 0, 0, 0, 11563, 0, 'High Overlord Saurfang'),
(25749, 6, 0, 'Is that the best you can do?', 12, 0, 100, 0, 0, 0, 13130, 0, 'High Overlord Saurfang'),
(25749, 7, 0, 'You\'ll make no mention of me. Either of you!', 12, 1, 100, 0, 0, 0, 24938, 0, 'High Overlord Saurfang');

-- Shadowstalker Getry
-- Update id to 25749
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2572900) AND (`source_type` = 9) AND (`id` IN (2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2572900, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 25749, 30, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - Actionlist - Say Line 5'),
(2572900, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25749, 30, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - Actionlist - Despawn Instant');
-- Varidus the Flenser
-- Update id to 25749
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2561800) AND (`source_type` = 9) AND (`id` IN (23, 25));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2561800, 9, 23, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 25749, 30, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Start Attacking'),
(2561800, 9, 25, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25749, 100, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Despawn Instant');

-- Shadowstalker Getry
-- add '%s nods.'
DELETE FROM `creature_text` WHERE (`CreatureID` = 25729) AND (`GroupID` IN (5));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25729, 5, 0, '%s nods.', 16, 0, 0, 273, 0, 0, 24935, 0, '');
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2572900) AND (`source_type` = 9) AND (`id` IN (2, 3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2572900, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 19, 25749, 30, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - Actionlist - Say Line 7'),
(2572900, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - Actionlist - Say Line 5'),
(2572900, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - Actionlist - Say Line 4'),
(2572900, 9, 5, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25749, 30, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - Actionlist - Despawn Instant'),
(2572900, 9, 6, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - Actionlist - Despawn Instant');

-- Varidus the Flenser
-- Set unit_flags to 770 (not attackable, immune to players, immune to NPC)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | (2 | 256 | 512)  WHERE (`entry` = 25618);

-- Shadowstalker Getry attack Varidus the Flenser
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25729) AND (`source_type` = 0) AND (`id` IN (10));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25729, 0, 10, 0, 38, 0, 100, 512, 25618, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 25618, 30, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - On Data Set 25618 1 - Start Attacking');
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2561800) AND (`source_type` = 9) AND (`id` IN (24, 25, 26, 27));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2561800, 9, 24, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 45, 25618, 1, 0, 0, 0, 0, 19, 25729, 30, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Set Data 25618 1'),
(2561800, 9, 25, 0, 0, 0, 100, 0, 180000, 180000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25729, 100, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Despawn Instant'),
(2561800, 9, 26, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25749, 100, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Despawn Instant'),
(2561800, 9, 27, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Despawn Instant');

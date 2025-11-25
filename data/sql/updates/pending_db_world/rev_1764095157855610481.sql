-- Heb'Jin's Drum (gameobject)
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 190695;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 190695) AND (`source_type` = 1) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(190695, 1, 0, 1, 70, 0, 100, 0, 2, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Drum - On Gameobject State Changed - Store Targetlist'),
(190695, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 36, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Drum - On Gameobject State Changed - Play Emote 36'),
(190695, 1, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4, 7294, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Drum - On Gameobject State Changed - Play Sound 7294'),
(190695, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 19069500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Drum - On Gameobject State Changed - Run Script');

-- Drum timed script
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19069500) AND (`source_type` = 9) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19069500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 98562, 23837, 0, 0, 0, 0, 0, 0, ' - Actionlist - Set Data 1 1'),
(19069500, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 28636, 100, 0, 0, 0, 0, 0, 0, ' - Actionlist - Send Target 1');

-- Heb'Jin (creature)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28636;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28636) AND (`source_type` = 0) AND (`id` IN (1, 2, 3, 4, 5, 6, 7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28636, 0, 1, 2, 38, 0, 100, 0, 0, 1, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - On Data Set 0 1 - Say Line 2'),
(28636, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - On Data Set 0 1 - Set Home Position'),
(28636, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - On Data Set 0 1 - Remove Flags Immune To Players'),
(28636, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - On Data Set 0 1 - Start Attacking'),
(28636, 0, 5, 0, 0, 0, 100, 0, 1000, 1000, 7000, 8000, 0, 0, 11, 12734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - In Combat - Cast \'Ground Smash\''),
(28636, 0, 6, 0, 0, 0, 100, 0, 5000, 5000, 10000, 12000, 0, 0, 11, 15548, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - In Combat - Cast \'Thunderclap\''),
(28636, 0, 7, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - On Evade - Despawn Instant');

-- Heb'Jin timed script
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2863600) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2863600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52353, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Cast \'Script Effect - Creature Capture GUID to Dot Variable\''),
(2863600, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Say Line 0'),
(2863600, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Say Line 1'),
(2863600, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 12, 28639, 2, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 5984.55, -3882.62, 417.438, 1.91986, 'Heb\'Jin - Actionlist - Summon Creature \'Heb\'Jin\'s Bat\''),
(2863600, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 28639, 100, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Send Target 1'),
(2863600, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 43671, 0, 0, 0, 0, 0, 19, 28639, 100, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Cast \'Ride Vehicle\'');

-- Heb'Jin's Bat (creature)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28639;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28639) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28639, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Respawn - Set Flags Not Selectable'),
(28639, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Respawn - Remove FlagStandstate Dead'),
(28639, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52353, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Respawn - Cast \'Script Effect - Creature Capture GUID to Dot Variable\''),
(28639, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4, 10892, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Respawn - Play Sound 10892'),
(28639, 0, 4, 0, 27, 0, 100, 1, 0, 0, 0, 0, 0, 0, 53, 2, 28639, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Passenger Boarded - Start Waypoint Path 28639 (No Repeat)'),
(28639, 0, 5, 6, 40, 0, 100, 0, 4, 28639, 0, 0, 0, 0, 28, 43671, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Point 4 of Path 28639 Reached - Remove Aura \'Ride Vehicle\''),
(28639, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 19, 28636, 100, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Point 4 of Path 28639 Reached - Set Data 0 1'),
(28639, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2863900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Point 4 of Path 28639 Reached - Run Script'),
(28639, 0, 8, 9, 8, 0, 100, 0, 52151, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Spellhit \'Bat Net\' - Set Flags Immune To Players'),
(28639, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Spellhit \'Bat Net\' - Set Flag Standstate Dead'),
(28639, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Spellhit \'Bat Net\' - Despawn In 5000 ms'),
(28639, 0, 11, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Evade - Despawn Instant');

-- Bat delayed attack script
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2863900) AND (`source_type` = 9) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2863900, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - Actionlist - Remove Flags Not Selectable'),
(2863900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - Actionlist - Remove Flags Immune To Players'),
(2863900, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - Actionlist - Start Attacking');

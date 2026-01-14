-- DB update 2026_01_13_03 -> 2026_01_14_00
-- Gryphon
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27886;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27886);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27886, 0, 0, 0, 27, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2788600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Gryphon - On Passenger Boarded - Run Script'),
(27886, 0, 1, 0, 108, 0, 100, 0, 15, 278861, 0, 0, 0, 0, 80, 2788601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Gryphon - On Point 15 of Path 278861 Reached - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2788600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2788600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Gryphon - Actionlist - Say Line 0'),
(2788600, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 11, 49303, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Gryphon - Actionlist - Cast \'Flight + Speed\''),
(2788600, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 278861, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Gryphon - Actionlist - Start Path 278861');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2788601);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2788601, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45472, 2, 0, 0, 0, 0, 29, 1, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Gryphon - Actionlist - Cast \'Parachute\''),
(2788601, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 62539, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Gryphon - Actionlist - Cast \'Eject Passenger 2\''),
(2788601, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Gryphon - Actionlist - Say Line 1'),
(2788601, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valgarde Gryphon - Actionlist - Despawn Instant');

DELETE FROM `vehicle_template_accessory` WHERE `entry`=27886 AND `seat_id`=0;
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES (27886, 27887, 0, 1, 'Valgarde Gryphon', 5, 0);

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=27886 AND `spell_id`=48365;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES (27886, 48365, 1, 1);

DELETE FROM `waypoint_data` WHERE `id` = 278861;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`) VALUES
(278861, 1, 611.694, -5049.68, 24.2361, NULL, 0, 2),
(278861, 2, 645.473, -5088.02, 30.9664, NULL, 0, 2),
(278861, 3, 712.811, -5091.94, 35.1508, NULL, 0, 2),
(278861, 4, 943.165, -5001.23, 51.6465, NULL, 0, 2),
(278861, 5, 1043.21, -4975.55, 42.5367, NULL, 0, 2),
(278861, 6, 1105.99, -4981.37, 44.6164, NULL, 0, 2),
(278861, 7, 1168.69, -4956.15, 43.58, NULL, 0, 2),
(278861, 8, 1188.28, -4949.07, 43.8891, NULL, 0, 2),
(278861, 9, 1224.69, -5034.33, 45.4934, NULL, 0, 2),
(278861, 10, 1284.04, -5064.89, 70.9363, NULL, 0, 2),
(278861, 11, 1299.86, -5123.96, 92.313, NULL, 0, 2),
(278861, 12, 1268.89, -5172.31, 125.225, NULL, 0, 2),
(278861, 13, 1204.63, -5202.03, 162.438, NULL, 0, 2),
(278861, 14, 1264.15, -5293.07, 194.687, NULL, 0, 2),
(278861, 15, 1250.92, -5318.65, 202.334, NULL, 0, 2),
(278861, 16, 1100.08, -5329.92, 227.263, NULL, 0, 2);

-- Zorek
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23728);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23728, 0, 0, 0, 10, 0, 100, 512, 1, 50, 120000, 300000, 0, 0, 80, 2372800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guard Captain Zorek - Within 1-50 Range Out of Combat LoS - Run Script'),
(23728, 0, 1, 0, 19, 0, 100, 0, 11427, 0, 0, 0, 0, 0, 134, 49845, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guard Captain Zorek - On Quest \'Meet Lieutenant Icehammer...\' Taken - Invoker Cast \'Call Valgarde Gryphon\'');

DELETE FROM `spell_target_position` WHERE `ID` = 49845;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(49845, 0, 571, 603.603, -5034.4, 1.1338, 0.694764, 0);

-- Rider
DELETE FROM `creature_text` WHERE `CreatureID` = 27887;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27887, 0, 0, 'Off we go!', 12, 7, 100, 0, 0, 0, 27225, 0, 'Valgarde Gryphon Rider'),
(27887, 1, 0, 'Here ya go, friend! Icehammer is right inside that vrykul building! Give \'em hell!', 12, 7, 100, 0, 0, 0, 27228, 0, 'Valgarde Gryphon Rider');

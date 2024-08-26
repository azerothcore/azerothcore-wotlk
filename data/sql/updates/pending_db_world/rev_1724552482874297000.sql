-- Pilot Bellowfiz Smart Ai

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1378;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 1378);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1378, 0, 0, 0, 1, 0, 100, 0, 240000, 240000, 240000, 240000, 0, 0, 63, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Pilot Bellowfiz - Out of Combat - Add 1 to Counter Id 1'),
(1378, 0, 1, 0, 77, 0, 100, 0, 1, 1, 0, 0, 0, 0, 80, 137800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Pilot Bellowfiz - On Counter 1 Set To 1 - Run Script'),
(1378, 0, 2, 0, 77, 0, 100, 0, 1, 2, 0, 0, 0, 0, 80, 137801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Pilot Bellowfiz - On Counter 1 Set To 2 - Run Script'),
(1378, 0, 3, 0, 77, 0, 100, 0, 1, 3, 0, 0, 0, 0, 80, 137802, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Pilot Bellowfiz - On Counter 1 Set To 3 - Run Script'),
(1378, 0, 4, 0, 77, 0, 100, 0, 1, 4, 0, 0, 0, 0, 80, 137803, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Pilot Bellowfiz - On Counter 1 Set To 4 - Run Script'),
(1378, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On reset - Self: Set script counter_1 to 0');


DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 137800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(137800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Self: Talk 0 to invoker'),
(137800, 9, 1, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 1377, 15, 0, 0, 0, 0, 0, 0, ' Closest alive creature Pilot Stonegear (1377) in 15 yards: Talk 0 to invoker'),
(137800, 9, 2, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Self: Talk 1 to invoker'),
(137800, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 1377, 15, 0, 0, 0, 0, 0, 0, 'Closest alive creature Pilot Stonegear (1377) in 15 yards: Talk 1 to invoker'),
(137800, 9, 4, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Self: Talk 2 to invoker');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 137801);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(137801, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 1377, 15, 0, 0, 0, 0, 0, 0, 'Closest alive creature Pilot Stonegear (1377) in 10 yards: Talk 2 to invoker'),
(137801, 9, 1, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Self: Talk 3 to invoker'),
(137801, 9, 2, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 1377, 15, 0, 0, 0, 0, 0, 0, 'Closest alive creature Pilot Stonegear (1377) in 15 yards: Talk 3 to invoker'),
(137801, 9, 3, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Self: Talk 4 to invoker'),
(137801, 9, 4, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 1377, 15, 0, 0, 0, 0, 0, 0, 'Closest alive creature Pilot Stonegear (1377) in 15 yards: Talk 4 to invoker');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 137802);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(137802, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Self: Talk 5 to invoker'),
(137802, 9, 1, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 1377, 15, 0, 0, 0, 0, 0, 0, 'Closest alive creature Pilot Stonegear (1377) in 15 yards: Talk 5 to invoker'),
(137802, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Self: Talk 6 to invoker'),
(137802, 9, 3, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 1377, 15, 0, 0, 0, 0, 0, 0, 'Closest alive creature Pilot Stonegear (1377) in 15 yards: Talk 6 to invoker'),
(137802, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Self: Talk 7 to invoker'),
(137802, 9, 5, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 19, 1377, 15, 0, 0, 0, 0, 0, 0, 'Closest alive creature Pilot Stonegear (1377) in 15 yards: Talk 7 to invoker');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 137803);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(137803, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Self: Talk 8 to invoker'),
(137803, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 19, 1377, 15, 0, 0, 0, 0, 0, 0, 'Closest alive creature Pilot Stonegear (1377) in 15 yards: Talk 8 to invoker'),
(137803, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Self: Talk 9 to invoker'),
(137803, 9, 3, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 19, 1377, 15, 0, 0, 0, 0, 0, 0, 'Closest alive creature Pilot Stonegear (1377) in 15 yards: Talk 9 to invoker'),
(137803, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Self: Set script counter_1 to 0');

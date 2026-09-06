-- DB update 2025_10_24_05 -> 2025_10_25_00

-- Delete old Waypoint and add new ones
DELETE FROM `waypoints` WHERE (`entry` IN (28948));

DELETE FROM `waypoint_data` WHERE (`id` IN (2894800, 2894801, 2894802, 2894803, 2894804, 2894805));
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(2894800, 1, 6232.341, -1965.3967, 484.76993, NULL, 0, 0, 0, 100, 0),
(2894800, 2, 6218.6577, -1962.0309, 484.85934, NULL, 0, 0, 0, 100, 0),
(2894801, 1, 6191.6187, -1930.0017, 485.06897, NULL, 0, 0, 0, 100, 0),
(2894801, 2, 6175.131, -1934.6721, 484.8741, NULL, 0, 0, 0, 100, 0),
(2894801, 3, 6156.749, -1953.0284, 484.90906, NULL, 0, 0, 0, 100, 0),
(2894802, 1, 6119.237, -1976.635, 484.8796, NULL, 0, 0, 0, 100, 0),
(2894802, 2, 6093.954, -1990.4447, 484.8646, NULL, 0, 0, 0, 100, 0),
(2894802, 3, 6089.3467, -2014.2975, 484.85828, NULL, 0, 0, 0, 100, 0),
(2894802, 4, 6113.093, -2041.1102, 484.8815, NULL, 0, 0, 0, 100, 0),
(2894802, 5, 6108.405, -2060.9314, 484.76993, NULL, 0, 0, 0, 100, 0),
(2894803, 1, 6136.712, -2078.5974, 484.86215, NULL, 0, 0, 0, 100, 0),
(2894803, 2, 6157.7085, -2107.486, 485.07727, NULL, 0, 0, 0, 100, 0),
(2894803, 3, 6156.6816, -2122.8438, 485.18344, NULL, 0, 0, 0, 100, 0),
(2894803, 4, 6141.0166, -2128.8904, 485.348, NULL, 0, 0, 0, 100, 0),
(2894803, 5, 6143.3594, -2127.986, 485.39215, NULL, 0, 0, 0, 100, 0),
(2894803, 6, 6118.48, -2123.0764, 473.51685, NULL, 0, 0, 0, 100, 0),
(2894803, 7, 6121.2275, -2108.0781, 473.54965, NULL, 0, 0, 0, 100, 0),
(2894803, 8, 6146.223, -2111.0583, 461.30115, NULL, 0, 0, 0, 100, 0),
(2894803, 9, 6156.9985, -2110.611, 461.30157, NULL, 0, 0, 0, 100, 0),
(2894803, 10, 6160.259, -2087.5088, 461.30212, NULL, 0, 0, 0, 100, 0),
(2894803, 11, 6148.678, -2072.7812, 461.303, NULL, 0, 0, 0, 100, 0),
(2894804, 1, 6144.377, -2044.998, 460.9487, NULL, 0, 0, 0, 100, 0),
(2894804, 2, 6139.7783, -2046.457, 461.30005, NULL, 0, 0, 0, 100, 0),
(2894805, 1, 6161.379, -2028.9777, 458.94113, NULL, 0, 0, 0, 100, 0),
(2894805, 2, 6172.3604, -2019.7084, 455.11356, NULL, 0, 0, 0, 100, 0);

-- Change Emotes
UPDATE `creature_text` SET `Emote` = 4 WHERE (`CreatureID` = 28948) AND (`GroupID` IN (0));
UPDATE `creature_text` SET `Emote` = 396 WHERE (`CreatureID` = 28948) AND (`GroupID` IN (1));
UPDATE `creature_text` SET `Emote` = 5 WHERE (`CreatureID` = 28948) AND (`GroupID` IN (3, 12));
UPDATE `creature_text` SET `Emote` = 2 WHERE (`CreatureID` = 28948) AND (`GroupID` IN (14));

-- Set SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28948;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28948);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28948, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 25, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - On Just Summoned - Store Targetlist'),
(28948, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2894800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - On Just Summoned - Run Script'),
(28948, 0, 2, 0, 109, 0, 100, 0, 0, 2894800, 0, 0, 0, 0, 80, 2894801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - On Path 2894800 Finished - Run Script'),
(28948, 0, 3, 0, 109, 0, 100, 0, 0, 2894801, 0, 0, 0, 0, 80, 2894802, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - On Path 2894801 Finished - Run Script'),
(28948, 0, 4, 0, 109, 0, 100, 0, 0, 2894802, 0, 0, 0, 0, 80, 2894803, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - On Path 2894802 Finished - Run Script'),
(28948, 0, 5, 0, 109, 0, 100, 0, 0, 2894803, 0, 0, 0, 0, 80, 2894804, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - On Path 2894803 Finished - Run Script'),
(28948, 0, 6, 0, 109, 0, 100, 0, 0, 2894804, 0, 0, 0, 0, 80, 2894805, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - On Path 2894804 Finished - Run Script'),
(28948, 0, 7, 0, 109, 0, 100, 0, 0, 2894805, 0, 0, 0, 0, 80, 2894806, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - On Path 2894805 Finished - Run Script');

-- Set Action Lists
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2894800, 2894801, 2894802, 2894803, 2894804, 2894805, 2894806));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2894800, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Set Orientation Stored'),
(2894800, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Say Line 0'),
(2894800, 9, 2, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Say Line 1'),
(2894800, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 232, 2894800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Start Path 2894800'),
(2894801, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Set Orientation Stored'),
(2894801, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Say Line 2'),
(2894801, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 232, 2894801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Start Path 2894801'),
(2894802, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Set Orientation Stored'),
(2894802, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Say Line 3'),
(2894802, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 232, 2894802, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Start Path 2894802'),
(2894803, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Say Line 4'),
(2894803, 9, 1, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Set Orientation Stored'),
(2894803, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Say Line 5'),
(2894803, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 232, 2894803, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Start Path 2894803'),
(2894804, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Say Line 6'),
(2894804, 9, 1, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Set Orientation Stored'),
(2894804, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Say Line 7'),
(2894804, 9, 3, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 232, 2894804, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Start Path 2894804'),
(2894805, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Say Line 8'),
(2894805, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Set Orientation Stored'),
(2894805, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Say Line 9'),
(2894805, 9, 3, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 28931, 30, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Set Orientation Closest Creature \'Blightblood Troll\''),
(2894805, 9, 4, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Say Line 10'),
(2894805, 9, 5, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 11, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Say Line 11'),
(2894805, 9, 6, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 232, 2894805, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Start Path 2894805'),
(2894806, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Set Orientation Stored'),
(2894806, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 1, 12, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Say Line 12'),
(2894806, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 13, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Say Line 13'),
(2894806, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 14, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Say Line 14'),
(2894806, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 53101, 2, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Cast \'Kill Credit\''),
(2894806, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malmortis - Actionlist - Despawn In 2000 ms');

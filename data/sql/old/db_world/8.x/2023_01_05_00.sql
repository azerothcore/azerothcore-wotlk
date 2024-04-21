-- DB update 2023_01_04_02 -> 2023_01_05_00
-- Pathing for Kel'Thuzad Entry: 20350
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=1777.6586,`position_y`=1058.5917,`position_z`=7.1008496 WHERE `id1`=20350; -- Kel'Thuzad
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=1777.6586,`position_y`=1058.5917,`position_z`=7.1008496 WHERE `id1`=20353; -- Helcular
DELETE FROM `waypoints` WHERE `entry`=20350;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(20350,1,1777.6586,1058.5917,7.1008496,NULL,0,'Kel\'Thuzad'),
(20350,2,1785.8223,1057.3224,7.46938,NULL,0,'Kel\'Thuzad'),
(20350,3,1802.3959,1061.4431,8.593266,NULL,0,'Kel\'Thuzad'),
(20350,4,1816.5465,1069.8398,10.483082,NULL,0,'Kel\'Thuzad'),
(20350,5,1829.2474,1075.3346,11.50713,NULL,0,'Kel\'Thuzad'),
(20350,6,1840.346,1076.9652,13.023953,NULL,0,'Kel\'Thuzad'),
(20350,7,1854.4879,1072.2803,15.144437,NULL,0,'Kel\'Thuzad'),
(20350,8,1864.5223,1065.2603,15.909603,NULL,0,'Kel\'Thuzad'),
(20350,9,1883.5319,1056.9219,18.170403,NULL,0,'Kel\'Thuzad'),
(20350,10,1896.4857,1052.8398,17.920403,NULL,0,'Kel\'Thuzad'),
(20350,11,1917.8785,1051.4784,19.08978,NULL,0,'Kel\'Thuzad'),
(20350,12,1930.2494,1051.6864,19.907164,NULL,0,'Kel\'Thuzad'),
(20350,13,1947.8518,1045.3527,21.082039,NULL,0,'Kel\'Thuzad'),
(20350,14,1958.8525,1035.1572,23.207039,NULL,0,'Kel\'Thuzad'),
(20350,15,1969.4431,1028.3741,24.45784,NULL,0,'Kel\'Thuzad'),
(20350,16,1980.2985,1028.6941,25.294388,NULL,0,'Kel\'Thuzad'),
(20350,17,1969.4431,1028.3741,24.45784,NULL,0,'Kel\'Thuzad'),
(20350,18,1958.8616,1035.1549,23.17591,NULL,0,'Kel\'Thuzad'),
(20350,19,1947.8604,1045.3506,20.957039,NULL,0,'Kel\'Thuzad'),
(20350,20,1930.2494,1051.6864,19.907164,NULL,0,'Kel\'Thuzad'),
(20350,21,1917.8785,1051.4784,19.08978,NULL,0,'Kel\'Thuzad'),
(20350,22,1896.4857,1052.8398,17.920403,NULL,0,'Kel\'Thuzad'),
(20350,23,1883.5319,1056.9219,18.170403,NULL,0,'Kel\'Thuzad'),
(20350,24,1864.5223,1065.2603,15.909603,NULL,0,'Kel\'Thuzad'),
(20350,25,1854.4879,1072.2803,15.144437,NULL,0,'Kel\'Thuzad'),
(20350,26,1840.346,1076.9652,13.023953,NULL,0,'Kel\'Thuzad'),
(20350,27,1829.2474,1075.3346,11.50713,NULL,0,'Kel\'Thuzad'),
(20350,28,1816.5465,1069.8398,10.483082,NULL,0,'Kel\'Thuzad'),
(20350,29,1802.3959,1061.4431,8.593266,NULL,0,'Kel\'Thuzad'),
(20350,30,1785.8223,1057.3224,7.46938,NULL,0,'Kel\'Thuzad');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20350);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20350, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 20350, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - On Reset - Start Waypoint'),
(20350, 0, 1, 0, 40, 0, 2, 0, 0, 20350, 0, 0, 0, 80, 2035000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - On Waypoint 0 Reached - Run Script (2% Chance)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2035000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2035000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 49200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - On Script - Pause Waypoint'),
(2035000, 9, 1, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 20353, 10, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - On Script - Set Data 1 1'), -- Intentionally delayed so that Helcular can catch up and Orientation is set correctly
(2035000, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 20353, 10, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - On Script - Set Orientation Closest Creature \'Helcular\''),
(2035000, 9, 3, 0, 0, 0, 100, 0, 2600, 2600, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - On Script - Say Line 0'),
(2035000, 9, 4, 0, 0, 0, 100, 0, 8400, 8400, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - On Script - Say Line 1'),
(2035000, 9, 5, 0, 0, 0, 100, 0, 12000, 12000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - On Script - Say Line 2'),
(2035000, 9, 6, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - On Script - Say Line 3'),
(2035000, 9, 7, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - On Script - Say Line 4'),
(2035000, 9, 8, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - On Script - Say Line 5');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20353);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20353, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 29, 0.05, 90, 0, 0, 0, 0, 19, 20350, 10, 0, 0, 0, 0, 0, 0, 'Helcular - On Reset - Start Follow Closest Creature \'Kel\'Thuzad\''),
(20353, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 2035300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helcular - On Data Set 1 1 - Run Script');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2035300) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2035300, 9, 0, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 20350, 10, 0, 0, 0, 0, 0, 0, 'Helcular - On Script - Set Orientation Closest Creature \'Kel\'Thuzad\''),
(2035300, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helcular - On Script - Say Line 0'),
(2035300, 9, 2, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helcular - On Script - Say Line 1'),
(2035300, 9, 3, 0, 0, 0, 100, 0, 8400, 8400, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helcular - On Script - Say Line 2'),
(2035300, 9, 4, 0, 0, 0, 100, 0, 17000, 17000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helcular - On Script - Say Line 3'),
(2035300, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helcular - On Script - Set Data 1 0');

DELETE FROM `creature_text` WHERE `CreatureID`=20350;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20350, 0, 0, 'Keep your voice down, Helcular. Strangers abound...', 12, 0, 100, 1, 0, 0, 18033, 0, 'Kel\'Thuzad'),
(20350, 1, 0, 'Necromancy. It is called necromancy. And yes, I have it within my power to bless you with this gift.', 12, 0, 100, 1, 0, 0, 18042, 0, 'Kel\'Thuzad'),
(20350, 2, 0, 'That is none of your concern, Helcular, as you are neither Kirin Tor nor a necromancer.', 12, 0, 100, 274, 0, 0, 18044, 0, 'Kel\'Thuzad'),
(20350, 3, 0, 'But to be perfectly frank, I do not give a damn what the Kirin Tor think! They are fools, set in their archaic ways.', 12, 0, 100, 1, 0, 0, 18050, 0, 'Kel\'Thuzad'),
(20350, 4, 0, '%s nods.', 16, 0, 100, 0, 0, 0, 18034, 0, 'Kel\'Thuzad'),
(20350, 5, 0, 'In due time, Helcular... All in due time...', 12, 0, 100, 1, 0, 0, 18052, 0, 'Kel\'Thuzad');

DELETE FROM `creature_text` WHERE `CreatureID`=20353;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20353, 0, 0, '%s nods.', 16, 0, 100, 273, 0, 0, 18034, 0, 'Helcular'),
(20353, 1, 0, 'So you can teach me this... this...', 12, 0, 100, 6, 0, 0, 18041, 0, 'Helcular'),
(20353, 2, 0, 'And the Kirin Tor? What have they to say of necromancy?', 12, 0, 100, 6, 0, 0, 18043, 0, 'Helcular'),
(20353, 3, 0, 'Then teach me, Kel\'Thuzad. Teach me everything you know...', 12, 0, 100, 1, 0, 0, 18051, 0, 'Helcular');

-- DB update 2023_01_25_02 -> 2023_01_25_03
--
-- Pathing for Caretaker Smithers Entry: 20363
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=1919.8694,`position_y`=1014.0391,`position_z`=20.042213 WHERE `id1`=20363;
DELETE FROM `waypoints` WHERE `entry`=20363;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(20363,1 ,1919.8694,1014.0391,20.042213,NULL,0,'Caretaker Smithers'), -- Gather scene
(20363,2 ,1920.5603,999.7766,19.011696,NULL,0,'Caretaker Smithers'),
(20363,3 ,1924.5566,995.5218,19.71006,NULL,0,'Caretaker Smithers'), -- Gather scene
(20363,4 ,1935.6606,984.0484,21.123981,NULL,0,'Caretaker Smithers'),
(20363,5 ,1943.4469,975.2496,21.252644,NULL,0,'Caretaker Smithers'),
(20363,6 ,1949.0729,980.20294,22.772175,NULL,0,'Caretaker Smithers'), -- Exclaim scene
(20363,7 ,1945.2955,982.9886,22.528156,NULL,0,'Caretaker Smithers'),
(20363,8 ,1939.2311,989.23114,22.174519,NULL,0,'Caretaker Smithers'), -- Gather scene
(20363,9 ,1938.1833,998,22.798054,NULL,0,'Caretaker Smithers'),
(20363,10,1944.8545,991.9531,23.633991,NULL,0,'Caretaker Smithers'),
(20363,11,1951.4713,984.99426,23.759968,NULL,0,'Caretaker Smithers'),
(20363,12,1953.829,987.2497,24.585407,NULL,0,'Caretaker Smithers'),
(20363,13,1954.8463,989.21277,24.921223,NULL,0,'Caretaker Smithers'),
(20363,14,1951.3962,993.43414,24.868855,NULL,0,'Caretaker Smithers'), -- Gather scene
(20363,15,1951.9707,999.4053,25.383991,NULL,0,'Caretaker Smithers'),
(20363,16,1956.5465,997.03485,25.95528,NULL,0,'Caretaker Smithers'),
(20363,17,1961.9579,989.9653,26.100544,NULL,0,'Caretaker Smithers'),
(20363,18,1967.4908,988.8749,26.474886,NULL,0,'Caretaker Smithers'),
(20363,19,1970.9928,993.5809,27.716585,NULL,0,'Caretaker Smithers'),
(20363,20,1970.8381,1003.7231,28.175247,NULL,0,'Caretaker Smithers'),
(20363,21,1969.6588,1012.2213,27.550247,NULL,0,'Caretaker Smithers'),
(20363,22,1961.2242,1026.4314,25.099794,NULL,0,'Caretaker Smithers'),
(20363,23,1950.4635,1034.7577,23.537117,NULL,0,'Caretaker Smithers'),
(20363,24,1934.9088,1047.05,20.748543,NULL,0,'Caretaker Smithers'),
(20363,25,1924.6755,1043.0906,21.203306,NULL,0,'Caretaker Smithers'),
(20363,26,1914.0985,1036.8203,20.454527,NULL,0,'Caretaker Smithers'),
(20363,27,1913.6925,1027.6425,19.6876,NULL,0,'Caretaker Smithers'), -- Exclaim scene
(20363,28,1921.0701,1023.8725,21.260475,NULL,0,'Caretaker Smithers'); -- Sleep scene
-- 0x204214460013E2C000618C0000233C56 .go xyz 1919.8694 1014.0391 20.042213

-- Change equipment to Pitchfork (Previously Fishing Rod 1117)
UPDATE `creature_equip_template` SET `ItemID1` = 1485 WHERE (`CreatureID` = 20363);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20363;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20363);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20363, 0, 0, 0, 40, 0, 100, 0, 1, 20363, 0, 0, 0, 80, 2036300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Waypoint 1 Reached - Run Script'),
(20363, 0, 1, 0, 40, 0, 100, 0, 3, 20363, 0, 0, 0, 80, 2036300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Waypoint 3 Reached - Run Script'),
(20363, 0, 2, 0, 40, 0, 100, 0, 6, 20363, 0, 0, 0, 80, 2036301, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Waypoint 6 Reached - Run Script'),
(20363, 0, 3, 0, 40, 0, 100, 0, 8, 20363, 0, 0, 0, 80, 2036300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Waypoint 8 Reached - Run Script'),
(20363, 0, 4, 0, 40, 0, 100, 0, 14, 20363, 0, 0, 0, 80, 2036300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Waypoint 14 Reached - Run Script'),
(20363, 0, 5, 0, 40, 0, 100, 0, 27, 20363, 0, 0, 0, 80, 2036301, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Waypoint 27 Reached - Run Script'),
(20363, 0, 6, 0, 40, 0, 100, 0, 28, 20363, 0, 0, 0, 80, 2036302, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Waypoint 28 Reached - Run Script'),
(20363, 0, 7, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 20363, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Reset - Start Waypoint');

-- Gather Scene
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2036300) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2036300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Pause Waypoint'),
(2036300, 9, 1, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 5, 381, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Play Emote 381'),
(2036300, 9, 2, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Say Line 0');

-- Exclaim Scene
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2036301) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2036301, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 18000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Pause Waypoint'),
(2036301, 9, 1, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Say Line 1'),
(2036301, 9, 2, 0, 0, 0, 100, 0, 2200, 2200, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.049163818359375, 'Caretaker Smithers - On Script - Set Orientation 4.049163818359375'),
(2036301, 9, 3, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Play Emote 5'),
(2036301, 9, 4, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0.9424777626991272, 'Caretaker Smithers - On Script - Set Orientation 0.9424777626991272'),
(2036301, 9, 5, 0, 0, 0, 100, 0, 4800, 4800, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Play Emote 14');

-- Sleep Scene
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2036302);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2036302, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 222200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Pause Waypoint'),
(2036302, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Play Emote 1'),
(2036302, 9, 2, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Say Line 2'),
(2036302, 9, 3, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 11, 14915, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Cast \'Self Visual - Sleep Until Cancelled (DND)\''),
(2036302, 9, 4, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Say Line 3'),
(2036302, 9, 5, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 90, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Play Emote 12'),
(2036302, 9, 6, 0, 0, 0, 100, 0, 210000, 210000, 0, 0, 0, 28, 14915, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Remove Aura \'Self Visual - Sleep Until Cancelled (DND)\''),
(2036302, 9, 7, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 91, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Play Emote 13'),
(2036302, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 90, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Play Emote 13'),
(2036302, 9, 9, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Say Line 4'),
(2036302, 9, 10, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 91, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Play Emote 26'),
(2036302, 9, 11, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 90, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caretaker Smithers - On Script - Play Emote 26');

DELETE FROM `creature_text` WHERE `CreatureID` = 20363;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20363, 0, 0, '%s collects some vegetables.', 16, 0, 100, 0, 0, 0, 17997, 0, 'Caretaker Smithers'),
(20363, 0, 1, '%s digs into the dirt.', 16, 0, 100, 0, 0, 0, 17998, 0, 'Caretaker Smithers'),
(20363, 0, 2, '%s moves a rock.', 16, 0, 100, 0, 0, 0, 17999, 0, 'Caretaker Smithers'),
(20363, 1, 0, 'I hate this place and everyone in it! Smithers do this! Smithers do that! Oh so I\'m a farmer now, eh? So I\'m gonna have to harvest stuff, eh? I hope one day this whole place becomes one big graveyard and all the loud-mouths are buried right damned here!', 12, 0, 100, 5, 0, 0, 17996, 0, 'Caretaker Smithers'),
(20363, 2, 0, 'Time for old Smithers to take a break...', 12, 0, 100, 0, 0, 0, 18009, 0, 'Caretaker Smithers'),
(20363, 3, 0, '%s yawns.', 16, 0, 100, 0, 0, 0, 18011, 0, 'Caretaker Smithers'),
(20363, 4, 0, 'Welp, back to the grind.', 12, 0, 100, 1, 0, 0, 18012, 0, 'Caretaker Smithers');

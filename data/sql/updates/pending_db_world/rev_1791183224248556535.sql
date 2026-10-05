--
SET @MAIEV := 21699;
SET @GUID := 84636;
SET @PATH := @GUID * 10;
UPDATE `creature` SET `wander_distance` = 0, `currentwaypoint` = 0, `MovementType` = 2 WHERE `guid` = @GUID AND `id` = @MAIEV;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@GUID, @PATH, 0, 0, 0, 0, 0, NULL);
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 2, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 3, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 4, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 5, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 6, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 7, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 8, -3697.09, 1028.91, 57.14, NULL, 0),
(@PATH, 9, -3708.71, 1028.62, 56.3771, NULL, 15000),
(@PATH, 10, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 11, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 12, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 13, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 14, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 15, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 16, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 17, -3697.09, 1028.91, 57.14, NULL, 0),
(@PATH, 18, -3708.71, 1028.62, 56.3771, NULL, 15000),
(@PATH, 19, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 20, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 21, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 22, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 23, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 24, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 25, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 26, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 27, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 28, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 29, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 30, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 31, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 32, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 33, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 34, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 35, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 36, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 37, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 38, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 39, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 40, -3697.14, 1023.41, 57.14, NULL, 0),
(@PATH, 41, -3697.57, 1035.3, 57.14, NULL, 0),
(@PATH, 42, -3697.14, 1023.41, 57.14, NULL, 0);

DELETE FROM `smart_scripts` WHERE `entryorguid` = @MAIEV AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@MAIEV*100, @MAIEV*100+1) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@MAIEV, 0, 0, 0, 108, 0, 100, 0, 9, @PATH, 0, 0, 0, 0, 80, @MAIEV*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - On Waypoint 9 Reached - Run Script'),
(@MAIEV, 0, 1, 0, 108, 0, 100, 0, 18, @PATH, 0, 0, 0, 0, 80, @MAIEV*100+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - On Waypoint 18 Reached - Run Script'),
(@MAIEV, 0, 2, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 21700, 30, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - On Data Set 1 1 - Face Akama'),
(@MAIEV*100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - On Script - Say Line 0'),
(@MAIEV*100+1, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - On Script - Say Line 3'),
(@MAIEV*100+1, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 5, 60, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - On Script - Play Emote 60');

DELETE FROM `creature_text` WHERE `CreatureID` = @MAIEV AND `GroupID` = 3;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(@MAIEV, 3, 0, 'This cell won''t hold me for long.  I will have Illidan''s head one way or another.', 12, 0, 100, 0, 0, 0, 19394, 0, 'Maiev Shadowsong');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2170000, 2170002) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2170000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - Set NPC Flags'),
(2170000, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 107, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - Summon Group'),
(2170000, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 21768, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - Say Line 0 on Vagath'),
(2170000, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.53073, 'Akama - Script - Set Orientation'),
(2170000, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - Say Line 0'),
(2170000, 9, 5, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 11, 37448, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - Cast Chain Lightning'),
(2170000, 9, 6, 0, 0, 0, 100, 0, 50, 50, 0, 0, 0, 0, 134, 37493, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - InVoker Cast Feign Death'),
(2170000, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - Say Line 1'),
(2170000, 9, 8, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 21768, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - Say Line 1 on Vagath'),
(2170000, 9, 9, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - Say Line 2'),
(2170000, 9, 10, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 37449, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - Cast Resurrect'),
(2170000, 9, 11, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 28, 37493, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - Remove Aura Feign Death'),
(2170000, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 1, 1, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - Set Unit Flags 2 on Player'),
(2170000, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - Set Npc Flags'),
(2170000, 9, 14, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 235, 0, 0, 0, 0, 0, 0, 10, 84636, 21699, 0, 0, 0, 0, 0, 0, 'Akama - Script - Pause Movement on Maiev Shadowsong'),
(2170000, 9, 15, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 84636, 21699, 0, 0, 0, 0, 0, 0, 'Akama - Script - Set Data 1 1 on Maiev Shadowsong'),
(2170000, 9, 16, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 21699, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - Say Line 1 on Maiev Shadowsong '),
(2170000, 9, 17, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - Say Line 3'),
(2170000, 9, 18, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 21699, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script - Say Line 2 on Maiev Shadowsong '),
(2170000, 9, 19, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 236, 0, 0, 0, 0, 0, 0, 10, 84636, 21699, 0, 0, 0, 0, 0, 0, 'Akama - Script - Resume Movement on Maiev Shadowsong'),
(2170002, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Set NPC Flags'),
(2170002, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 235, 0, 0, 0, 0, 0, 0, 10, 84636, 21699, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Pause Movement on Maiev Shadowsong'),
(2170002, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 22820, 1, 180000, 0, 0, 0, 8, 0, 0, 0, 0, -3726.36, 1040.71, 56.0398, 5.84685, 'Akama - Script 3 - Summon Seer Olum'),
(2170002, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 22820, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 0 on Seer Olum'),
(2170002, 9, 4, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 8'),
(2170002, 9, 5, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 22820, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 1 on Seer Olum'),
(2170002, 9, 6, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 9'),
(2170002, 9, 7, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 22820, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 2 on Seer Olum'),
(2170002, 9, 8, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 10'),
(2170002, 9, 9, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 22820, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 3 on Seer Olum'),
(2170002, 9, 10, 0, 0, 0, 100, 0, 13000, 13000, 0, 0, 0, 0, 1, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 11'),
(2170002, 9, 11, 0, 0, 0, 100, 0, 14000, 14000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 22820, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 4 on Seer Olum'),
(2170002, 9, 12, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 0, 0, 11, 39552, 0, 0, 0, 0, 0, 19, 22820, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Cast Olums Sacrifice'),
(2170002, 9, 13, 0, 0, 0, 100, 0, 14000, 14000, 0, 0, 0, 0, 1, 12, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 12'),
(2170002, 9, 14, 0, 0, 0, 100, 0, 21000, 21000, 0, 0, 0, 0, 1, 13, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 13'),
(2170002, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Set Bytes 1'),
(2170002, 9, 16, 0, 0, 0, 100, 0, 300, 300, 0, 0, 0, 0, 12, 22865, 1, 86000, 0, 0, 0, 8, 0, 0, 0, 0, -3721.87, 1029.5, 56.0393, 0.0349066, 'Akama - Script 3 - Summon Illidans Presence'),
(2170002, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 50, 185520, 86, 0, 0, 0, 0, 8, 0, 0, 0, 0, -3721.87, 1029.5, 56.0393, 0.0349066, 'Akama - Script 3 - Summon Fel Fire (GO)'),
(2170002, 9, 18, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 22865, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 0 on Illidans Presence'),
(2170002, 9, 19, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 22865, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Set Data 1 1 on Illidans Presence'),
(2170002, 9, 20, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 22820, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Despawn Seer Olum'),
(2170002, 9, 21, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Set Bytes 1'),
(2170002, 9, 22, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 14'),
(2170002, 9, 23, 0, 0, 0, 100, 0, 16000, 16000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 22865, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 1 on Illidans Presence'),
(2170002, 9, 24, 0, 0, 0, 100, 0, 23000, 23000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 22865, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 2 on Illidans Presence'),
(2170002, 9, 25, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 22865, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Set Data 2 2 on Illidans Presence'),
(2170002, 9, 26, 0, 0, 0, 100, 0, 17000, 17000, 0, 0, 0, 0, 1, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 15'),
(2170002, 9, 27, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Say Line 15'),
(2170002, 9, 28, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 236, 0, 0, 0, 0, 0, 0, 10, 84636, 21699, 0, 0, 0, 0, 0, 0, 'Akama - Script 3 - Resume Movement on Maiev Shadowsong');

-- DB update 2023_01_05_00 -> 2023_01_05_01
-- Set correct spawn pos
UPDATE `creature` SET `position_x`=1815.927978515625, `position_y`=1020.21331787109375, `position_z`=11.68548202514648437, `orientation`=4.817108631134033203, `equipment_id`=1, `VerifiedBuild`=47187 WHERE `id1`=20351;
UPDATE `creature` SET `position_x`=1814.1473388671875, `position_y`=1018.730712890625, `position_z`=11.68548202514648437, `orientation`=6.2657318115234375, `equipment_id`=1, `VerifiedBuild`=47187 WHERE `id1`=20400;

-- Set Equipment (previously empty)
DELETE FROM `creature_equip_template` WHERE (`CreatureID` IN (20351, 20400));
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(20351, 1, 2704, 0, 0, 0),
(20400, 1, 2704, 0, 0, 0);

DELETE FROM `creature_template_addon` WHERE (`entry` IN (20351, 20400));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(20351, 0, 0, 0, 1, 0, 0, ''),
(20400, 0, 0, 0, 1, 0, 0, '');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20351;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20351);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20351, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Reset - Set Event Phase 1'),
(20351, 0, 1, 0, 60, 1, 100, 0, 3600, 3600, 3600, 3600, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Update - Play Emote 92 (Phase 1)'),
(20351, 0, 2, 3, 60, 1, 100, 0, 180000, 180000, 180000, 180000, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Update - Set Event Phase 0 (Phase 1)'),
(20351, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 80, 2035100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Update - Run Script'),
(20351, 0, 4, 0, 40, 0, 100, 0, 11, 20351, 0, 0, 0, 80, 2035101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Waypoint 11 Reached - Run Script'),
(20351, 0, 5, 0, 40, 0, 100, 0, 14, 20351, 0, 0, 0, 80, 2035102, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Waypoint 14 Reached - Run Script'),
(20351, 0, 6, 0, 58, 0, 100, 0, 29, 20351, 0, 0, 0, 80, 2035103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Waypoint Finished - Run Script');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20400;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20400, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Reset - Set Event Phase 1'),
(20400, 0, 1, 0, 60, 1, 100, 0, 3600, 3600, 3600, 3600, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Update - Play Emote 92 (Phase 1)'),
(20400, 0, 2, 3, 38, 0, 100, 0, 1, 1, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Data Set 1 1 - Set Event Phase 0'),
(20400, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 80, 2040000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Data Set 1 1 - Run Script'),
(20400, 0, 4, 0, 38, 0, 100, 0, 1, 2, 0, 0, 0, 80, 2040001, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Data Set 1 2 - Run Script'),
(20400, 0, 5, 0, 38, 0, 100, 0, 1, 3, 0, 0, 0, 80, 2040002, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Data Set 1 3 - Run Script'),
(20400, 0, 6, 0, 38, 0, 100, 0, 1, 4, 0, 0, 0, 80, 2040003, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Data Set 1 4 - Run Script');

-- Pathing for Captain Sanders Entry: 20351
DELETE FROM `waypoints` WHERE `entry`=20351;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(20351,1,1811.1932,1025.7975,11.685483,NULL,0,'Captain Sanders'),
(20351,2,1811.046,1035.7515,11.413217,NULL,0,'Captain Sanders'),
(20351,3,1810.3229,1043.4323,11.685482,NULL,0,'Captain Sanders'),
(20351,4,1817.0609,1043.4369,11.67465,NULL,0,'Captain Sanders'),
(20351,5,1817.4949,1053.8794,11.11829,NULL,0,'Captain Sanders'),
(20351,6,1811.2274,1060.154,9.906864,NULL,0,'Captain Sanders'),
(20351,7,1800.7808,1061.7118,8.49329,NULL,0,'Captain Sanders'),
(20351,8,1791.0525,1057.8472,7.8332715,NULL,0,'Captain Sanders'),
(20351,9,1787.0084,1046.652,9.74416,NULL,0,'Captain Sanders'),
(20351,10,1781.4646,1033.0979,9.537182,NULL,0,'Captain Sanders'),
(20351,11,1775.1431,1014.3824,6.5410886,NULL,0,'Captain Sanders'), -- Intermediate Event
(20351,12,1758.1819,1016.2374,5.8595204,NULL,0,'Captain Sanders'),
(20351,13,1739.5063,1016.105,2.416039,NULL,0,'Captain Sanders'),
(20351,14,1731.3119,1014.4211,1.5693786,NULL,0,'Captain Sanders'), -- Boat Scene
(20351,15,1757.7401,1016.1464,5.8391347,NULL,0,'Captain Sanders'),
(20351,16,1768.027,1016.7231,6.1815915,NULL,0,'Captain Sanders'),
(20351,17,1775.2412,1017.6554,6.0808835,NULL,0,'Captain Sanders'),
(20351,18,1784.6741,1026.9069,10.753368,NULL,0,'Captain Sanders'),
(20351,19,1790.1174,1049.2361,9.626728,NULL,0,'Captain Sanders'),
(20351,20,1799.3375,1057.9951,8.322407,NULL,0,'Captain Sanders'),
(20351,21,1810.4957,1058.3661,10.12952,NULL,0,'Captain Sanders'),
(20351,22,1816.9808,1056.8551,11.11829,NULL,0,'Captain Sanders'),
(20351,23,1817.2922,1043.6241,11.674123,NULL,0,'Captain Sanders'),
(20351,24,1810.0059,1042.9373,11.685482,NULL,0,'Captain Sanders'),
(20351,25,1809.8413,1038.6426,11.685481,NULL,0,'Captain Sanders'),
(20351,26,1811.0175,1032.7227,11.060482,NULL,0,'Captain Sanders'),
(20351,27,1811.5898,1024.587,11.685483,NULL,0,'Captain Sanders'),
(20351,28,1814.4944,1020.6591,11.685482,NULL,0,'Captain Sanders'),
(20351,29,1815.928,1020.2133,11.685482,NULL,0,'Captain Sanders'); -- End
-- 0x204214460013DFC000618C0000233C55 .go xyz 1811.1932 1025.7975 11.685483

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2035100) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2035100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Set Event Phase 0'),
(2035100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Set Data 1 1'),
(2035100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Set Orientation Closest Creature \'Captain Edward Hanes\''),
(2035100, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Say Line 0'),
(2035100, 9, 4, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 53, 0, 20351, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Start Waypoint');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2040000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2040000, 9, 0, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 20351, 10, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Set Orientation Closest Creature \'Captain Sanders\''),
(2040000, 9, 1, 0, 0, 0, 100, 0, 7500, 7500, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 19, 20351, 10, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Say Line 0'),
(2040000, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 29, 1, 180, 0, 0, 0, 0, 19, 20351, 10, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Start Follow Closest Creature \'Captain Sanders\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2035101);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2035101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 14000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Pause Waypoint'),
(2035101, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Set Data 1 2'),
(2035101, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.0995573997497559, 'Captain Sanders - On Script - Set Orientation 1.0995573997497559'),
(2035101, 9, 3, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 5.777040004730225, 'Captain Sanders - On Script - Set Orientation 5.777040004730225'),
(2035101, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Set Orientation Closest Creature \'Captain Edward Hanes\''),
(2035101, 9, 5, 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Say Line 1'),
(2035101, 9, 6, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Say Line 2');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2040001) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2040001, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Start Follow Self'),
(2040001, 9, 1, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 20351, 10, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Set Orientation Closest Creature \'Captain Sanders\''),
(2040001, 9, 2, 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 19, 20351, 10, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Say Line 1'),
(2040001, 9, 3, 0, 0, 0, 100, 0, 8600, 8600, 0, 0, 0, 5, 273, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Play Emote 273'),
(2040001, 9, 4, 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 29, 1, 180, 0, 0, 0, 0, 19, 20351, 10, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Start Follow Closest Creature \'Captain Sanders\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2040002) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2040002, 9, 0 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Start Follow Self'),
(2040002, 9, 1 , 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1729.3556, 1014.00525, 1.151654, 1.7166426181793213, 'Captain Edward Hanes - On Script - Move To Position'),
(2040002, 9, 2 , 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 19, 20351, 1, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Say Line 2'),
(2040002, 9, 3 , 0, 0, 0, 100, 0, 9700, 9700, 0, 0, 0, 1, 3, 0, 1, 0, 0, 0, 19, 20351, 10, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Say Line 3'),
(2040002, 9, 4 , 0, 0, 0, 100, 0, 9600, 9600, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.8274333477020264, 'Captain Edward Hanes - On Script - Set Orientation 2.8274333477020264'),
(2040002, 9, 5 , 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 1, 4, 0, 1, 0, 0, 0, 19, 20351, 10, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Say Line 4'),
(2040002, 9, 6 , 0, 0, 0, 100, 0, 10600, 10600, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 20351, 10, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Set Orientation Closest Creature \'Captain Sanders\''),
(2040002, 9, 7 , 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Say Line 5'),
(2040002, 9, 8 , 0, 0, 0, 100, 0, 23000, 23000, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Say Line 6'),
(2040002, 9, 9 , 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 1, 7, 0, 1, 0, 0, 0, 19, 20351, 10, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Say Line 7'),
(2040002, 9, 10, 0, 0, 0, 100, 0, 9500, 9500, 0, 0, 0, 5, 273, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Play Emote 273'),
(2040002, 9, 11, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 29, 1, 180, 0, 0, 0, 0, 19, 20351, 10, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Start Follow Closest Creature \'Captain Sanders\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2035102);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2035102, 9, 0 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Set Data 1 3'),
(2035102, 9, 1 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 84900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Pause Waypoint'),
(2035102, 9, 2 , 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.4434609413146973, 'Captain Sanders - On Script - Set Orientation 2.4434609413146973'),
(2035102, 9, 3 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 3, 0, 1, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Say Line 3'),
(2035102, 9, 4 , 0, 0, 0, 100, 0, 2100, 2100, 0, 0, 0, 5, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Play Emote 6'),
(2035102, 9, 5 , 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Play Emote 92'),
(2035102, 9, 6 , 0, 0, 0, 100, 0, 4900, 4900, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.780235767364502, 'Captain Sanders - On Script - Set Orientation 1.780235767364502'),
(2035102, 9, 7 , 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 1, 4, 0, 1, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Say Line 4'),
(2035102, 9, 8 , 0, 0, 0, 100, 0, 2200, 2200, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Play Emote 5'),
(2035102, 9, 9 , 0, 0, 0, 100, 0, 7400, 7400, 0, 0, 0, 1, 5, 0, 1, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Say Line 5'),
(2035102, 9, 10, 0, 0, 0, 100, 0, 9600, 9600, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.9146997928619385, 'Captain Sanders - On Script - Set Orientation 2.9146997928619385'),
(2035102, 9, 11, 0, 0, 0, 100, 0, 3800, 3800, 0, 0, 0, 1, 6, 0, 1, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Say Line 6'),
(2035102, 9, 12, 0, 0, 0, 100, 0, 7300, 7300, 0, 0, 0, 1, 7, 0, 1, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Say Line 7'),
(2035102, 9, 13, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 8, 0, 1, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Say Line 8'),
(2035102, 9, 14, 0, 0, 0, 100, 0, 7300, 7300, 0, 0, 0, 1, 9, 0, 1, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Say Line 9'),
(2035102, 9, 15, 0, 0, 0, 100, 0, 2200, 2200, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Play Emote 5'),
(2035102, 9, 16, 0, 0, 0, 100, 0, 6300, 6300, 0, 0, 0, 1, 10, 0, 1, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Say Line 10'),
(2035102, 9, 17, 0, 0, 0, 100, 0, 13300, 13300, 0, 0, 0, 1, 11, 0, 1, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Say Line 11'),
(2035102, 9, 18, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 5, 273, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Play Emote 273');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2035103) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2035103, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 4, 0, 0, 0, 0, 19, 20400, 10, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Set Data 1 4'),
(2035103, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1815.927978515625, 1020.2133178710938, 11.685482025146484, 4.817108631134033, 'Captain Sanders - On Script - Move To Position'),
(2035103, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Sanders - On Script - Set Event Phase 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2040003);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2040003, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Start Follow Self'),
(2040003, 9, 1, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1814.1473388671875, 1018.730712890625, 11.685482025146484, 6.2657318115234375, 'Captain Edward Hanes - On Script - Move To Position'),
(2040003, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Set Data 1 0'),
(2040003, 9, 3, 0, 0, 0, 100, 0, 4800, 4800, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Edward Hanes - On Script - Set Event Phase 1');

DELETE FROM `creature_text` WHERE `CreatureID`=20351;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20351, 0 , 0, 'Avast, Ed! Lemme show ye me ship! *hic*', 12, 0, 100, 1, 0, 0, 18064, 0, 'Captain Sanders'),
(20351, 1 , 0, 'I just be makin\' sure we wasn\'t followed! *hic*', 12, 0, 100, 5, 0, 0, 18067, 0, 'Captain Sanders'),
(20351, 2 , 0, 'It be clear...', 12, 0, 100, 273, 0, 0, 18068, 0, 'Captain Sanders'),
(20351, 3 , 0, 'Thar she be! Ain\'t she a beaut?', 12, 0, 100, 25, 0, 0, 18069, 0, 'Captain Sanders'),
(20351, 4 , 0, 'That thar monster be yers, Ed? Arrr... She\'s a big\'un!', 12, 0, 100, 25, 0, 0, 18071, 0, 'Captain Sanders'),
(20351, 5 , 0, 'Arrr, Ed! She definitely be seaworthy!', 12, 0, 100, 5, 0, 0, 18073, 0, 'Captain Sanders'),
(20351, 6 , 0, 'Can ye keep a secret, Ed? Arr, dead men tell no tales!', 12, 0, 100, 6, 0, 0, 18075, 0, 'Captain Sanders'),
(20351, 7 , 0, 'It be me treasure, Ed. Me life\'s work! Arrr... One white shirt fit fer a pirate king to be wearin\'!', 12, 0, 100, 1, 0, 0, 18077, 0, 'Captain Sanders'),
(20351, 8 , 0, 'One red sash that ye can put on yer head or your britches. Pride o\' the fleet, that sash is...', 12, 0, 100, 1, 0, 0, 18078, 0, 'Captain Sanders'),
(20351, 9 , 0, 'An\' last but certainly not least, one enormous bag! Big enough to fit eight whole apples! Eight, Ed! Can ye believe it!?', 12, 0, 100, 1, 0, 0, 18079, 0, 'Captain Sanders'),
(20351, 10, 0, 'Yarrr! Keep it down, Ed! Thar be scallywags about! Their scallywag ears be listenin\' for gasps like the one that just escaped yer lips!', 12, 0, 100, 1, 0, 0, 18081, 0, 'Captain Sanders'),
(20351, 11, 0, 'It be alright, Ed. Me booty be locked away good in that thar chest. No fool will ever have Cap\'n Sanders\'s treasure! Let\'s go get another drink. The spirits be runnin\' low.', 12, 0, 100, 1, 0, 0, 18083, 0, 'Captain Sanders');

DELETE FROM `creature_text` WHERE `CreatureID`=20400;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20400, 0, 0, 'Lead the way, Sanders!', 12, 0, 100, 1, 0, 0, 18065, 0, 'Captain Edward Hanes'),
(20400, 1, 0, 'What are you doing, Sanders?', 12, 0, 100, 1, 0, 0, 18066, 0, 'Captain Edward Hanes'),
(20400, 2, 0, 'Aye, she\'s a beaut alright. And you parked her right next to my frigate! *hic*', 12, 0, 100, 1, 0, 0, 18070, 0, 'Captain Edward Hanes'),
(20400, 3, 0, 'Ayep! She\'s all mine... I\'m gonna sail her around the world. Across the sea!', 12, 0, 100, 1, 0, 0, 18072, 0, 'Captain Edward Hanes'),
(20400, 4, 0, 'Sanders, what have you got in that chest?', 12, 0, 100, 1, 0, 0, 18074, 0, 'Captain Edward Hanes'),
(20400, 5, 0, '%s nods.', 16, 0, 100, 0, 0, 0, 18076, 0, 'Captain Edward Hanes'),
(20400, 6, 0, '%s gasps.', 16, 0, 100, 0, 0, 0, 18080, 0, 'Captain Edward Hanes'),
(20400, 7, 0, 'I\'m sorry, Sanders. I\'ve just never seen such a bounty. It took me by surprise.', 12, 0, 100, 1, 0, 0, 18082, 0, 'Captain Edward Hanes');

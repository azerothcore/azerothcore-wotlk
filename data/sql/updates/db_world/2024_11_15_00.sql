-- DB update 2024_11_14_05 -> 2024_11_15_00
SET @entry := 17109;
SET @PATH := @entry * 10;
DELETE FROM `waypoints` WHERE `entry`= @PATH;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(@PATH, 0+1, -10465.81, -3315.652, 21.13692, NULL, 0,'Cersei Dusksinger'),
(@PATH, 1+1, -10458.49, -3312.623, 21.13692, NULL, 0,'Cersei Dusksinger'),
(@PATH, 2+1, -10454.86, -3310.604, 21.27058, NULL, 0,'Cersei Dusksinger'),
(@PATH, 3+1, -10448.59, -3301.409, 20.17796, NULL, 0,'Cersei Dusksinger'),
(@PATH, 4+1, -10445.24, -3295.546, 20.17796, NULL, 0,'Cersei Dusksinger'),
(@PATH, 5+1, -10450, -3304.108, 20.17796, NULL, 0,'Cersei Dusksinger'),
(@PATH, 6+1, -10455.22, -3311.379, 21.13692, NULL, 0,'Cersei Dusksinger'),
(@PATH, 7+1, -10454.67, -3319.15, 21.17226, NULL, 0,'Cersei Dusksinger'),
(@PATH, 8+1, -10458.43, -3321.949, 21.13692, NULL, 0,'Cersei Dusksinger'),
(@PATH, 9+1, -10461.03, -3319.802, 21.13692, NULL, 0,'Cersei Dusksinger');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17109;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17109);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17109, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 8722, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - On Reset - Cast \'Summon Succubus\''),
(17109, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - On Reset - Set Event Phase 1'),
(17109, 0, 2, 3, 1, 1, 100, 0, 0, 0, 260688, 260688, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - Out of Combat - Set Event Phase 2 (Phase 1)'),
(17109, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 87, 1710900, 1710900, 1710901, 1710901, 1710901, 1710901, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - Out of Combat - Run Random Script (Phase 1)'),
(17109, 0, 4, 5, 40, 0, 100, 512, 5, 171090, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - On Point 5 of Path 171090 Reached - Pause Waypoint'),
(17109, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 200, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - On Point 5 of Path 171090 Reached - Create Timed Event'),
(17109, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 2, 6450, 6450, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - On Point 5 of Path 171090 Reached - Create Timed Event'),
(17109, 0, 7, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 1, 4, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - On Timed Event 1 Triggered - Say Line 4'),
(17109, 0, 8, 0, 59, 0, 100, 0, 2, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - On Timed Event 2 Triggered - Resume Waypoint'),
(17109, 0, 9, 0, 58, 0, 100, 512, 0, 171090, 0, 0, 0, 0, 67, 3, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - On Path 171090 Finished - Create Timed Event'),
(17109, 0, 10, 11, 59, 0, 100, 0, 3, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0.907571, 'Cersei Dusksinger - On Timed Event 3 Triggered - Set Orientation 0.907571'),
(17109, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - On Timed Event 3 Triggered - Set Event Phase 1'),
(17109, 0, 12, 0, 38, 1, 100, 0, 0, 1, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - On Data Set 0 1 - Set Event Phase 2 (Phase 1)'),
(17109, 0, 13, 0, 38, 2, 100, 0, 0, 2, 0, 0, 0, 0, 80, 1710902, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - On Data Set 0 2 - Run Script (Phase 2)'),
(17109, 0, 14, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 1710903, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - On Reached Point 1 - Run Script'),
(17109, 0, 15, 0, 34, 0, 100, 0, 8, 2, 0, 0, 0, 0, 80, 1710904, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - On Reached Point 2 - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1710900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1710900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.54818, 'Cersei Dusksinger - Actionlist - Set Orientation 2.54818'),
(1710900, 9, 1, 0, 0, 0, 100, 0, 1840, 1840, 0, 0, 0, 0, 1, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - Actionlist - Say Line 3'),
(1710900, 9, 2, 0, 0, 0, 100, 0, 7800, 7800, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 10, 94506, 27705, 0, 0, 0, 0, 0, 0, 'Creature Lorrin Foxfire (27705) with guid 94506 (fetching) - Talk 1 to invoker'),
(1710900, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 171090, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - Actionlist - Start Waypoint Path 171090');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1710901);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1710901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - Actionlist - Say Line 0');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1710902);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1710902, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - Actionlist - Set Event Phase 2'),
(1710902, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - Actionlist - Set Run Off'),
(1710902, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -10469, -3332.55, 25.4708, 0, 'Cersei Dusksinger - Actionlist - Move To Position');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1710903);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1710903, 9, 3, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - Actionlist - Say Line 1'),
(1710903, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.23918, 'Cersei Dusksinger - Actionlist - Set Orientation 1.23918'),
(1710903, 9, 5, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - Actionlist - Say Line 2'),
(1710903, 9, 6, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 10, 34151, 12807, 0, 0, 0, 0, 0, 0, 'Creature Greshka (12807) with guid 34151 (fetching): Play emote ONESHOT_RUDE(DNR) (14)'),
(1710903, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 10, 32091, 988, 0, 0, 0, 0, 0, 0, 'Creature Kartosh (988) with guid 32091 (fetching): Play emote ONESHOT_RUDE(DNR) (14)'),
(1710903, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 10, 31950, 1386, 0, 0, 0, 0, 0, 0, 'Creature Rogvar (1386) with guid 31950 (fetching): Play emote ONESHOT_RUDE(DNR) (14)'),
(1710903, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -10461.1, -3319.65, 20.9641, 0, 'Cersei Dusksinger - Actionlist - Move To Position');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1710904);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1710904, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cersei Dusksinger - Actionlist - Set Event Phase 1');


UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12807;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 12807);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12807, 0, 0, 1, 1, 0, 100, 0, 60000, 60000, 270000, 570000, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 34141, 17109, 0, 0, 0, 0, 0, 0, 'Creature Cersei Dusksinger (17109) with guid 34141 (fetching): Set creature data #0 to 1'),
(12807, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 10, 34141, 17109, 0, 0, 0, 0, 0, 0, 'Self: Talk 0 to Creature Cersei Dusksinger (17109) with guid 34141 (fetching)'),
(12807, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 1280700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greshka - Out of Combat - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1280700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1280700, 9, 0, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 32091, 988, 0, 0, 0, 0, 0, 0, 'Creature Kartosh (988) with guid 32091 (fetching): Talk 0 to invoker'),
(1280700, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 31950, 1386, 0, 0, 0, 0, 0, 0, 'Creature Rogvar (1386) with guid 31950 (fetching): Talk 0 to invoker'),
(1280700, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 45, 0, 2, 0, 0, 0, 0, 10, 34141, 17109, 0, 0, 0, 0, 0, 0, 'Creature Cersei Dusksinger (17109) with guid 34141 (fetching): Set creature data #0 to 2');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27705;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27705);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27705, 0, 0, 1, 1, 0, 100, 0, 15000, 30000, 134878, 314350, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Lorrin Foxfire - Out of Combat - Say Line 0'),
(27705, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Lorrin Foxfire - Out of Combat - Create Timed Event'),
(27705, 0, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 10, 31950, 1386, 0, 0, 0, 0, 0, 0, 'Lorrin Foxfire - On Timed Event 1 Triggered - Say Line 1');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17127;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17127);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17127, 0, 0, 0, 1, 0, 100, 0, 0, 169109, 169109, 241370, 0, 0, 88, 1712700, 1712703, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Every 169.109 - 241.37 seconds (0 - 169.109s initially) (OOC) - Self: Call random timed action list between range Anchorite Avuun #0 (1712700) and Anchorite Avuun #3 (1712703) (update always)');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1712700) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1712700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 34160, 1776, 0, 0, 0, 0, 0, 0, 'Anchorite Avuun - Actionlist - Set Orientation Closest Creature \'Magtoor\''),
(1712700, 9, 1, 0, 0, 0, 100, 0, 3300, 3300, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Avuun - Actionlist - Say Line 0'),
(1712700, 9, 2, 0, 0, 0, 100, 0, 3300, 3300, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 34160, 1776, 0, 0, 0, 0, 0, 0, 'Creature Magtoor (1776) with guid 34160 (fetching): Set creature data #0 to 1'),
(1712700, 9, 3, 0, 0, 0, 100, 0, 27410, 27410, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3.92699, 'Anchorite Avuun - Actionlist - Set Orientation 3.92699');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1712701);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1712701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 34160, 1776, 0, 0, 0, 0, 0, 0, 'Anchorite Avuun - Actionlist - Set Orientation Closest Creature \'Magtoor\''),
(1712701, 9, 1, 0, 0, 0, 100, 0, 3300, 3300, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Avuun - Actionlist - Say Line 1'),
(1712701, 9, 2, 0, 0, 0, 100, 0, 3300, 3300, 0, 0, 0, 0, 45, 0, 2, 0, 0, 0, 0, 10, 34160, 1776, 0, 0, 0, 0, 0, 0, 'Creature Magtoor (1776) with guid 34160 (fetching): Set creature data #0 to 2'),
(1712701, 9, 3, 0, 0, 0, 100, 0, 27410, 27410, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3.92699, 'Anchorite Avuun - Actionlist - Set Orientation 3.92699');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1712702);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1712702, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 34160, 1776, 0, 0, 0, 0, 0, 0, 'Anchorite Avuun - Actionlist - Set Orientation Closest Creature \'Magtoor\''),
(1712702, 9, 1, 0, 0, 0, 100, 0, 3300, 3300, 0, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Avuun - Actionlist - Say Line 2'),
(1712702, 9, 2, 0, 0, 0, 100, 0, 3300, 3300, 0, 0, 0, 0, 45, 0, 3, 0, 0, 0, 0, 10, 34160, 1776, 0, 0, 0, 0, 0, 0, 'Creature Magtoor (1776) with guid 34160 (fetching): Set creature data #0 to 3'),
(1712702, 9, 3, 0, 0, 0, 100, 0, 27410, 27410, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3.92699, 'Anchorite Avuun - Actionlist - Set Orientation 3.92699');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1712703);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1712703, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 34160, 1776, 0, 0, 0, 0, 0, 0, 'Anchorite Avuun - Actionlist - Set Orientation Closest Creature \'Magtoor\''),
(1712703, 9, 1, 0, 0, 0, 100, 0, 3300, 3300, 0, 0, 0, 0, 1, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Avuun - Actionlist - Say Line 3'),
(1712703, 9, 2, 0, 0, 0, 100, 0, 3300, 3300, 0, 0, 0, 0, 45, 0, 4, 0, 0, 0, 0, 10, 34160, 1776, 0, 0, 0, 0, 0, 0, 'Creature Magtoor (1776) with guid 34160 (fetching): Set creature data #0 to 4'),
(1712703, 9, 3, 0, 0, 0, 100, 0, 27410, 27410, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3.92699, 'Anchorite Avuun - Actionlist - Set Orientation 3.92699');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1776;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 1776);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1776, 0, 0, 0, 38, 0, 100, 0, 0, 1, 0, 0, 0, 0, 80, 177600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magtoor - On Data Set 0 1 - Run Script'),
(1776, 0, 1, 0, 38, 0, 100, 0, 0, 2, 0, 0, 0, 0, 80, 177601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magtoor - On Data Set 0 2 - Run Script'),
(1776, 0, 2, 0, 38, 0, 100, 0, 0, 3, 0, 0, 0, 0, 80, 177602, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magtoor - On Data Set 0 3 - Run Script'),
(1776, 0, 3, 0, 38, 0, 100, 0, 0, 4, 0, 0, 0, 0, 80, 177603, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magtoor - On Data Set 0 4 - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 177600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(177600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 32101, 17127, 0, 0, 0, 0, 0, 0, 'Magtoor - Actionlist - Set Orientation Closest Creature \'Anchorite Avuun\''),
(177600, 9, 1, 0, 0, 0, 100, 0, 5590, 5590, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 10, 32101, 17127, 0, 0, 0, 0, 0, 0, 'Magtoor - Actionlist - Say Line 0'),
(177600, 9, 2, 0, 0, 0, 100, 0, 14486, 14486, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3.10669, 'Magtoor - Actionlist - Set Orientation 3.10669');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 177601);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(177601, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 32101, 17127, 0, 0, 0, 0, 0, 0, 'Magtoor - Actionlist - Set Orientation Closest Creature \'Anchorite Avuun\''),
(177601, 9, 1, 0, 0, 0, 100, 0, 5590, 5590, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 10, 32101, 17127, 0, 0, 0, 0, 0, 0, 'Magtoor - Actionlist - Say Line 1'),
(177601, 9, 2, 0, 0, 0, 100, 0, 14486, 14486, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3.10669, 'Magtoor - Actionlist - Set Orientation 3.10669');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 177602);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(177602, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 32101, 17127, 0, 0, 0, 0, 0, 0, 'Magtoor - Actionlist - Set Orientation Closest Creature \'Anchorite Avuun\''),
(177602, 9, 1, 0, 0, 0, 100, 0, 5590, 5590, 0, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 10, 32101, 17127, 0, 0, 0, 0, 0, 0, 'Magtoor - Actionlist - Say Line 2'),
(177602, 9, 2, 0, 0, 0, 100, 0, 14486, 14486, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3.10669, 'Magtoor - Actionlist - Set Orientation 3.10669');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 177603);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(177603, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 32101, 17127, 0, 0, 0, 0, 0, 0, 'Magtoor - Actionlist - Set Orientation Closest Creature \'Anchorite Avuun\''),
(177603, 9, 1, 0, 0, 0, 100, 0, 5590, 5590, 0, 0, 0, 0, 1, 3, 0, 1, 0, 0, 0, 10, 32101, 17127, 0, 0, 0, 0, 0, 0, 'Magtoor - Actionlist - Say Line 3'),
(177603, 9, 2, 0, 0, 0, 100, 0, 14486, 14486, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3.10669, 'Magtoor - Actionlist - Set Orientation 3.10669');

-- page_text_locale
DELETE FROM `page_text_locale` WHERE (`locale`='zhTW' AND `ID` IN (1958,1957,1956,1955,1954,1953,1952,1951,2038,2037,2036,2035,2034,2033,2032,2031,2030,2216,2215,2214,2213,2212,793,792,791,711));
INSERT INTO `page_text_locale` (`ID`, `Text`, `locale`, `VerifiedBuild`) VALUES
(1958, '基爾加丹也意識到部落已經完全準備好了，獸人已經成為燃燒軍團手中最為強大的武器。他把這條消息告訴了他的主人，薩格拉斯也認為他復仇的時刻終於來臨了。', 'zhTW', 53788),
(1957, '幾個月之後，部落幾乎根除了德拉諾大陸上的所有德萊尼人，只有一小部分德萊尼人的倖存者苟延殘喘地躲避獸人那可怕的狂怒。因為勝利而得意的古爾丹整日沉迷於部落的力量和權力之中。然而，他清楚地知道，如果沒有可以殺戮的敵人，獸人部落就會因為自己無法控制的屠殺欲望在無休止的內戰中毀滅。', 'zhTW', 53788),
(1956, '然而，在考慮到某些大酋長比如葛羅·地獄吼和奧格林·末日錘可能會為了最高統帥的地位而互相爭執之後，古爾丹設立了一個傀儡大酋長來統治這個新的部落。『毀滅者』黑手，一個異常墮落和邪惡的督軍，被選中成為了古爾丹的傀儡。在黑手的指揮下，獸人部落開始以純樸的德萊尼人測試自己的戰鬥能力。', 'zhTW', 53788),
(1955, '獸人完全被這個嗜血的詛咒所吞沒，準備將怒氣發洩到任何阻擋他們的人身上。古爾丹覺得時機已經成熟了，就將互相征伐的各個氏族聯合成了一個統一的、無可阻擋的部落。', 'zhTW', 53788),
(1954, '除了杜洛坦之外，所有的氏族酋長都在葛羅·地獄吼的帶領下喝下了狂暴之血，就此將自己的命運徹底交給了惡魔，成為了燃燒軍團的奴隸。在瑪諾洛斯之血的引誘下，酋長們不自覺地將征服的欲望擴散到絕對信任他們的同胞之中。', 'zhTW', 53788),
(1953, '雖然基爾加丹知道獸人氏族已基本做好了準備，但他還是需要確認獸人對他的絕對忠誠。他通過暗影議會秘密召喚了破壞者瑪諾洛斯─一個充滿毀滅欲望的狂暴惡魔。同時古爾丹也將氏族酋長們召集到一起，並使他們確信自己在喝過瑪諾洛斯的狂暴之血後將變得所向無敵。', 'zhTW', 53788),
(1952, '其中霜狼氏族的酋長杜洛坦就告戒說，獸人已經迷失了自我而處於仇恨和狂暴之中。然而，他的警言卻沒有人聽取，一些強大氏族的酋長─例如戰歌氏族的葛羅·地獄吼─卻站出來迎接這個充滿戰爭和征服的新時代。', 'zhTW', 53788),
(1951, '在古爾丹和他的暗影議會的控制下，獸人們變得越來越具有侵略性。他們建造了宏大的競技場，使獸人們在其中磨練殺戮技能並體驗戰爭和死亡。在這段時期裡，一小部分氏族酋長對於種族的墮落表示了強烈的不滿。', 'zhTW', 53788),
(2038, '索爾拿起了末日錘那傳奇般的戰錘，穿上了他的黑色鎧甲，成為了新的部落大酋長。在接下來的幾個月裡，索爾小而靈活的部落掃平了許多收容所，並使聯盟花費了極大精力來應付他精明的戰術。在他最好的朋友兼顧問葛羅·地獄吼的鼓勵下，索爾為了確保沒有獸人再次成為奴隸─無論是人類還是惡魔的─而戰鬥著。', 'zhTW', 53788),
(2037, '作為他的人民所獲得新生的象徵，索爾回到了布拉克摩爾的敦霍爾德城堡並解放了收容所中的獸人。但是，在解放一座收容所的戰鬥中，末日錘戰死了。', 'zhTW', 53788),
(2036, '索爾在旅程中遇到了隱居多年的大酋長奧格林·末日錘。作為索爾的父親最要好的朋友，末日錘決定跟隨年輕有為的索爾並幫助他解放那些被囚禁的氏族。在許多經驗豐富的酋長的幫助下，索爾最終成功地使獸人重新充滿了活力，並為他的人民確立了新的精神信仰。', 'zhTW', 53788),
(2035, '在值得尊敬的薩滿德雷克塔爾的保護下，索爾學習了在古爾丹的邪惡統治下被獸人遺忘的古老薩滿文化。一段時間之後，索爾成為了一位強大的薩滿並成為了霜狼氏族的酋長。在元素的幫助下，索爾決定解放被囚禁的氏族並將他們從惡魔的誘惑中解救出來。', 'zhTW', 53788),
(2034, '為了找尋他自己的氏族，索爾向北方旅行，期望能碰到傳說中的霜狼氏族。索爾瞭解到古爾丹曾經在第一次獸人戰爭早期流放了霜狼氏族，他也瞭解到了他就是獸人英雄杜洛坦─在20年前被謀殺的霜狼氏族的酋長─的唯一子嗣。', 'zhTW', 53788),
(2033, '雖然人類在不斷追捕葛羅，但他仍然保持著獸人旺盛的戰鬥欲望。在他的戰歌氏族的幫助下，地獄吼為解放他那些被壓迫的同胞而不懈戰鬥。不幸的是，地獄吼永遠也找不到解救他們的辦法。索爾被地獄吼的堅定所感動，下定決心要找回獸人的戰鬥傳統。', 'zhTW', 53788),
(2032, '學識豐富但毫無經驗的索爾決定從布拉克摩爾的堡壘中逃跑並尋找他的同胞。在旅途中，索爾訪問了俘虜收容所，並發現他那一度強大的族群變得懶散虛弱，在這裡找不到他希望發現的值得驕傲的戰士。索爾繼續尋找最後的獸人酋長，葛羅·地獄吼。', 'zhTW', 53788),
(2031, '儘管典獄官的養育極其苛刻，年青的索爾仍然成長為一名健壯而聰明的獸人，但他心裡明白自己的一生決不應該作為奴隸度過。當索爾成年以後，他瞭解到了自己的種族，還有那些他從來都沒有見過的、在戰爭中被擊敗的同類們，他們中的大多數都被關入俘虜收容所中。有傳聞說獸人領袖奧格瑞姆·末日錘已經從羅德隆逃走並隱居了起來，只有一個流亡的氏族仍然試圖避開聯盟警惕的目光，秘密地進行著軍事活動。', 'zhTW', 53788),
(2030, '俘虜收容所的大典獄官埃德拉斯·布拉克摩爾在他的監獄堡壘敦霍爾德中監視著被俘的獸人們。有一個特殊的獸人總是引起他的興趣:他在十八年前撿到的那個失去雙親的嬰兒。布拉克摩爾將這個年青的男獸人培養成了一個才華橫溢的奴隸，並給他起名叫索爾。布拉克摩爾將關於戰術、哲學和格鬥的知識傳授給索爾，並將他訓練成為一名角鬥士。自始至終，這個邪惡的典獄官都在致力於將這名獸人青年鑄造成為一件武器。', 'zhTW', 53788),
(2216, '你很幸運，我有一條線索也許可以幫助你對付烏洛克的爪牙:$B$B這個法術是歐莫克用於對付巨魔的，它能一擊殺死他們，即使你殺掉了歐莫克，它也能繼續發揮功效。在你和烏洛克的爪牙作戰時，使用歐莫克的腦袋中蘊含著的力量─如果運氣好的話，歐莫克會擊倒烏洛克的爪牙!$B$B這可真具有諷刺性。', 'zhTW', 53788),
(2215, '到尖石巨魔營地上方那個充滿能量的地方去，就在隧道的旁邊。那裡堆積著曾經挑戰過烏洛克的巨魔的骸骨。你要在那裡插上掛著歐莫克頭顱的長矛!$B$B當你把頭顱安放就位之後，烏洛克必定會到來……但是，首先他會派他的爪牙來對付你。打敗他們，然後烏洛克就會現身了。$B$B殺了他，然後拿回我的魔法。當我奪回我的力量時，你也會得到獎勵的。', 'zhTW', 53788),
(2214, '到裂盾營地去找到一支尖銳的長矛。他們經常把這些長矛堆積在靠近尖石巨魔領地入口的地方，和那些日常用品堆在一起。$B$B當你拿到長矛之後，殺到歐莫克大王那裡，幹掉他，把他的頭顱掛在長矛上。$B$B然後就準備面對真正的挑戰吧。', 'zhTW', 53788),
(2213, '歐莫克大王統治著尖石部族，但是沒有烏洛克的魔法，他是做不到這一點的。烏洛克給歐莫克施加了特殊的魔法，讓他可以打死任何膽敢挑戰他的巨魔。他多次使用過那個法術，並且把那些受害者的頭骨堆在一起，放在歐莫克的房間頂部的一塊地方。$B$B那裡就是你要挑戰烏洛克的地方。', 'zhTW', 53788),
(2212, '啊，我受到了詛咒!我曾經是尖石氏族中的一個偉大的巨魔法師，我向烏洛克發起了挑戰，他偷走了我的魔法，而且還詛咒了我。現在，我只能以這種可笑的樣子在這裡遊蕩!$B$B幫幫我!找到烏洛克，偷回我的魔法!這不是一件簡單的事情，因為烏洛克會藏在暗處，你只有通過了一個極其困難的挑戰才能將其召喚出來。$B$B這個挑戰就是面對烏洛克的親信，歐莫克大王。$B$B繼續讀下去，你會瞭解更多細節的。', 'zhTW', 53788),
(793, '不用說就知道，我們卡加斯衛戍部隊，對能夠被部署在這裡，感到非常高興。我們已經在這裡堅強地紮下了根，因為只要我們略微示弱，就會死在這裡。\n\n在這裡也沒有別的辦法可以生存下去了。\n\n尼卡·血痕\n斥候隊長，卡加斯', 'zhTW', 53788),
(792, '荒蕪之地中滿是我們的敵人。巨魔會從沙中咆哮著突然鑽出，伏擊任何缺乏警惕的冒險者。黑鐵矮人則在卡加斯的東部，建立了一處基地，並和他們那些淺色皮膚的表親，在洛克莫丹北部地方交戰。某種野蠻且原始的、名為穴居怪的種族瘋狂地佔據這裡的每一片土地，並寸步不讓地保護著他們的領地。\n\n那麼荒蕪之地東部的萊瑟羅峽谷呢?它徹底被龍佔據了。我們不知道那裡的龍有多少，也不知道他們有多強大，因為派去那邊偵察的斥候，沒有一個能活著回來的。', 'zhTW', 53788),
(791, '身為卡加斯派出的斥候，我對周圍環境的描述如下:\n\n- 紅色的岩石丘陵與乾燥的平原，只有極少數生物才能在此生存。\n- 陽光熾烈，強風。\n- 沒有湖泊和溪流，也沒有任何池塘。想要找水的話，就必須挖出泥濘的深井，或者從仙人掌與其他針刺類植物中榨水。\n\n簡而言之:燥熱，難以生存。', 'zhTW', 53788),
(711, '赫格拉姆，\n\n無論是誰提議，在荒蕪之地的卡加斯建立一片基地，都將得到我的贊同。這個計畫將使我們在那裡擁有常備的駐軍。那裡的天氣很糟，到處都是兇惡的野生動物與好戰的土著，也沒有什麼補給，惟有我們最好的戰士與斥候，可以在那裡立足。\n\n這計畫很好。幹得漂亮。', 'zhTW', 53788);

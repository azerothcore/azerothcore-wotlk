-- DB update 2025_09_17_00 -> 2025_09_19_00
--
DELETE FROM `waypoints` WHERE `entry`=25742;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(25742, 1, 3511.336426, 4519.295898, -11.937509, 'Alluvius');

DELETE FROM `waypoints` WHERE `entry`=25652;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(25652, 1, 3509.71, 4510.5, -14.6752, 'Nerub\'ar Scarab'),
(25652, 2, 3515.16, 4512.57, -13.4052, 'Nerub\'ar Scarab'),
(25652, 3, 3520.58, 4511.77, -12.5632, 'Nerub\'ar Scarab'),
(25652, 4, 3530.14, 4507.88, -12.9948, 'Nerub\'ar Scarab'),
(25652, 5, 3536.34, 4508.6, -12.9948, 'Nerub\'ar Scarab'),
(25652, 6, 3553.48, 4510.25, -12.9948, 'Nerub\'ar Scarab');

DELETE FROM `event_scripts` WHERE `id` IN (17084, 16929);
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(17084, 0, 10, 25794, 180000, 0, 3521.26, 4550.4, -12.8893, 3.95449),
(17084, 10, 8, 25794, 0, 0, 0.0, 0.0, 0.0, 0.0),
(17084, 15, 10, 25629, 180000, 0, 3454.72, 4511.48, -12.9969, 1.45063),
(16929, 7, 8, 25742, 0, 0, 0.0, 0.0, 0.0, 0.0),
(16929, 0, 10, 25742, 180000, 0, 3517.29, 4538.78, -12.9837, 4.42876),
(16929, 13, 10, 25629, 180000, 0, 3454.72, 4511.48, -12.9969, 1.45063),
(16929, 7, 10, 25652, 360000, 0, 3507.67, 4509.3, -14.7929, 0.94582),
(16929, 7, 10, 25652, 360000, 0, 3505.95, 4506.93, -14.8176, 0.94582),
(16929, 7, 10, 25652, 360000, 0, 3505.3, 4506.02, -14.8372, 0.94582),
(16929, 7, 10, 25652, 360000, 0, 3504.33, 4504.68, -14.8372, 0.94582);

DELETE FROM `waypoints` WHERE `entry`=25629;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(25629, 1, 3456.838379, 4512.561523, -13.007453, 'Lord Kryxix'),
(25629, 2, 3460.417725, 4529.125488, -12.949759, 'Lord Kryxix'),
(25629, 3, 3470.703613, 4542.340332, -12.984859, 'Lord Kryxix'),
(25629, 4, 3480.046143, 4548.960938, -12.982792, 'Lord Kryxix'),
(25629, 5, 3492.488525, 4548.432617, -12.966542, 'Lord Kryxix'),
(25629, 6, 3498.693604, 4544.571777, -12.983426, 'Lord Kryxix');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25652;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25652);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25652, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 53, 0, 25652, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Scarab - On Data Set 1 1 - Start Waypoint Path 25652'),
(25652, 0, 1, 0, 40, 0, 100, 0, 6, 25652, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Scarab - On Point 6 of Path 25652 Reached - Despawn In 1000 ms');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (25629, 25794, 25742) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2574200, 2574201) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25629, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 25629, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Kryxix - On Just Summoned - Start Waypoint Path 25629'),
(25629, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Kryxix - On Just Summoned - Set Flags Immune To Players & Immune To NPC\'s'),
(25629, 0, 2, 3, 40, 0, 100, 0, 6, 25629, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Kryxix - On Point 6 of Path 25629 Reached - Remove Flags Immune To Players & Immune To NPC\'s'),
(25629, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 0, 'Lord Kryxix - On Point 6 of Path 25629 Reached - Start Attacking'),
(25629, 0, 4, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Kryxix - On Evade - Despawn Instant'),
(25794, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shake-n-Quake 5000 - On Just Summoned - Set Run Off'),
(25794, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3496.31, 4539.46, -12.9751, 4.49483, 'Shake-n-Quake 5000 - On Just Summoned - Move To Position'),
(25794, 0, 2, 0, 1, 0, 100, 1, 30000, 30000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shake-n-Quake 5000 - Out of Combat - Despawn Instant (No Repeat)'),
(25794, 0, 3, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 17, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shake-n-Quake 5000 - On Reached Point 1 - Set Emote State 35'),
(25794, 0, 4, 0, 1, 0, 100, 1, 17000, 17000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 25629, 0, 0, 0, 0, 0, 0, 0, 'Shake-n-Quake 5000 - Out of Combat - Say Line 1 (No Repeat)'),
(25742, 0, 0, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 0, 25742, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alluvius - On Just Summoned - Start Waypoint Path 25742'),
(25742, 0, 1, 0, 40, 0, 100, 512, 1, 25742, 0, 0, 0, 0, 80, 2574200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alluvius - On Point 1 of Path 25742 Reached - Run Script'),
(2574200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alluvius - Actionlist - Set Emote State 35'),
(2574200, 9, 1, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 25629, 0, 0, 0, 0, 0, 0, 0, 'Alluvius - Actionlist - Say Line 0'),
(2574200, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 25652, 0, 25, 0, 0, 0, 0, 0, 'Alluvius - Actionlist - Set Data 1 1'),
(2574200, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alluvius - Actionlist - Despawn Instant');

DELETE FROM `creature_text` WHERE `CreatureID`=25629 AND `GroupID`=1;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(25629, 1, 0, 'Feebleminded tinkerer,  do you really think your pathetic creation can stop me?', 14, 0, 100, 0, 0, 0, 24998, 0, 'Lord Kryxix');

DELETE FROM `conditions` WHERE `SourceEntry` IN (46017,45942) AND `SourceTypeOrReferenceId`=17;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`, `ErrorType`, `ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17, 0, 46017, 0, 0, 29, 0, 25629, 70, 0, 1, 0, 0, '', ''),
(17, 0, 46017, 0, 0, 29, 0, 25794, 70, 0, 1, 0, 0, '', ''),
(17, 0, 46017, 0, 0, 29, 0, 25742, 70, 0, 1, 0, 0, '', ''),
(17, 0, 45942, 0, 0, 29, 0, 25629, 70, 0, 1, 0, 0, '', ''),
(17, 0, 45942, 0, 0, 29, 0, 25794, 70, 0, 1, 0, 0, '', ''),
(17, 0, 45942, 0, 0, 29, 0, 25742, 70, 0, 1, 0, 0, '', '');

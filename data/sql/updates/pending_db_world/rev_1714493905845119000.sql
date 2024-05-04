-- Onslaught Raven Priest with guid 102088 smart ai
SET @ENTRY := -102088;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 27202;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 85485, 27210, 0, 0, 0, 0, 0, 'On aggro - Creature High General Abbendis (27210) with guid 85485 (fetching): Set creature data #0 to 1');

-- Onslaught Footman with guid 102193 smart ai
SET @ENTRY := -102193;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 27203;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 85485, 27210, 0, 0, 0, 0, 0, 'On aggro - Creature High General Abbendis (27210) with guid 85485 (fetching): Set creature data #0 to 1');

-- Onslaught Footman with guid 102194 smart ai
SET @ENTRY := -102194;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 27203;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 85485, 27210, 0, 0, 0, 0, 0, 'On aggro - Creature High General Abbendis (27210) with guid 85485 (fetching): Set creature data #0 to 1');

DELETE FROM `creature_text` WHERE `CreatureID` = 27210;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27210, 0, 0, 'Now I\'ll show you the REAL power of the Onslaught!', 12, 0, 100, 0, 0, 14192, 27593, 0, 'High General Abbendis'),
(27210, 1, 0, 'You\'ve come to test the might of the Onslaught?', 14, 0, 100, 6, 0, 14188, 27596, 0, 'High General Abbendis'),
(27210, 1, 1, 'Deal with this intrusion quickly. I don\'t have time for this!', 14, 0, 100, 5, 0, 14189, 27597, 0, 'High General Abbendis'),
(27210, 1, 2, 'You may want to rethink your actions, fool.', 14, 0, 100, 25, 0, 14190, 27598, 0, 'High General Abbendis'),
(27210, 1, 3, 'Am I going to have to deal with this intrusion myself?', 14, 0, 100, 6, 0, 14191, 27599, 0, 'High General Abbendis');

-- High General Abbendis smart ai
SET @ENTRY := 27210;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 50908, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High General Abbendis - On aggro - Cast spell  Seal of Onslaught (50908) on Self'),
(@ENTRY, 0, 1, 0, 0, 0, 100, 0, 4000, 7000, 19000, 23000, 11, 50915, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'High General Abbendis - Cast spell - Raging Consecration (50915) on Victim'),
(@ENTRY, 0, 2, 0, 0, 0, 100, 0, 9000, 12000, 20000, 23000, 11, 50905, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'High General Abbendis-  Cast spell - Judgement of Onslaught  (50905) on Victim'),
(@ENTRY, 0, 3, 4, 2, 0, 100, 1, 0, 20, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'When health between 0%-20%% (once) - Set event phase to phase 1'),
(@ENTRY, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'When health between 0%-20%% (once) - Self: Talk 0 to Self'),
(@ENTRY, 0, 5, 0, 0, 1, 100, 0, 0, 0, 6000, 6000, 11, 50921, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High General Abbendis - Cast spell - Reckless Onslaught (50921) on Self'),
(@ENTRY, 0, 6, 0, 6, 0, 100, 512, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 85322, 27951, 0, 0, 0, 0, 0, 'High General Abbendis - On death - Creature Admiral Barean Westwind (27951) with guid 85322 (fetching): Set creature data #1 to 1'),
(@ENTRY, 0, 7, 0, 4, 0, 100, 512, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 19, 27951, 10, 0, 0, 0, 0, 0, 'High General Abbendis - On aggro - Closest alive creature Admiral Barean Westwind (27951) in 10 yards: Set creature data #0 to 1'),
(@ENTRY, 0, 8, 0, 11, 0, 100, 512, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, 85322, 27951, 0, 0, 0, 0, 0, 'High General Abbendis - On respawn - Creature Admiral Barean Westwind (27951) with guid 85322 (fetching): Set respawn timer to 0 ms'),
(@ENTRY, 0, 9, 0, 25, 0, 100, 512, 0, 0, 0, 0, 45, 0, 2, 0, 0, 0, 0, 10, 85322, 27951, 0, 0, 0, 0, 0, 'High General Abbendis - On reset - Creature Admiral Barean Westwind (27951) with guid 85322 (fetching): Set creature data #0 to 2'),
(@ENTRY, 0, 10, 0, 38, 0, 100, 0, 0, 1, 5000, 5000, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On data[0] set to 1 (wait 5000 - 5000 ms before next event trigger) - Self: Talk 1 to invoker'),
(@ENTRY, 0, 11, 0, 38, 0, 100, 0, 0, 2, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 'On data[0] set to 2 - Self: Attack storedTarget[0]');

-- Admiral Barean Westwind smart ai
SET @ENTRY := 27951;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryOrGuid` IN (@ENTRY * 100, @ENTRY * 100 + 1, @ENTRY * 100 + 2, @ENTRY * 100 + 3, @ENTRY * 100 + 4);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 1, 11, 0, 100, 512, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On respawn - Set react state to Defensive'),
(@ENTRY, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On respawn - Unset active'),
(@ENTRY, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On respawn - Remove UNIT_FLAGS to IMMUNE_TO_PC'),
(@ENTRY, 0, 3, 4, 4, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On aggro - Remove all auras'),
(@ENTRY, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 64, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On aggro - storedTarget[0] = Attacked unit'),
(@ENTRY, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 10, 85485, 27210, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On aggro - Send stored target storedTarget[0] to Creature High General Abbendis (27210) with guid 85485 (fetching)'),
(@ENTRY, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 45, 0, 2, 0, 0, 0, 0, 19, 27210, 10, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On aggro - Closest alive creature High General Abbendis (27210) in 10 yards: Set creature data #0 to 2'),
(@ENTRY, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On aggro - Evade'),
(@ENTRY, 0, 8, 0, 21, 0, 100, 512, 0, 0, 0, 0, 80, 2795100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind On home reached - Self: Start timed action list id #Admiral Barean Westwind #0 (2795100) (update always) // -inline'),
(@ENTRY * 100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Set react state to Passive'),
(@ENTRY * 100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Set UNIT_FLAGS to IMMUNE_TO_PC'),
(@ENTRY * 100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 524288, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Remove UNIT_FLAGS to IN_COMBAT'),
(@ENTRY * 100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 50161, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Cast spell Protection Sphere (50161) on Self'),
(@ENTRY * 100, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 27210, 50, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Look at Closest alive creature High General Abbendis (27210) in 50 yards'),
(@ENTRY * 100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 11, 27210, 50, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Talk 0 to Creature High General Abbendis (27210) in 50 yd'),
(@ENTRY * 100, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Set orientation to home position orientation'),
(@ENTRY, 0, 9, 10, 38, 0, 100, 512, 1, 1, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On data[1] set to 1 - Set active'),
(@ENTRY, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 2795101, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On data[1] set to 1 - Start timed action list id #Admiral Barean Westwind #1 (2795101) (update always) // -inline'),
(@ENTRY * 100 + 1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Talk 1 to invoker'),
(@ENTRY * 100 + 1, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Set walk'),
(@ENTRY * 100 + 1, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 1, 0, 0, 19, 27210, 50, 1, 0, 0, 0, 0, 'Admiral Barean Westwind - Move to Closest dead creature High General Abbendis (27210) in 50 yards in 1 yd distance (point id 1)'),
(@ENTRY, 0, 11, 0, 34, 0, 100, 0, 8, 1, 0, 0, 80, 2795102, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On movement of type POINT_MOTION_TYPE inform, point 1 - Self: Start timed action list id #Admiral Barean Westwind #2 (2795102) (update out of combat) // -inline_wp'),
(@ENTRY * 100 + 2, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Set stand state to KNEEL'),
(@ENTRY * 100 + 2, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Talk 2 to invoker'),
(@ENTRY * 100 + 2, 9, 5, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Remove stand state KNEEL'),
(@ENTRY * 100 + 2, 9, 6, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0.139626, 'Admiral Barean Westwind - Set orientation to 0.139626'),
(@ENTRY * 100 + 2, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 5, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Play emote ONESHOT_LAUGH (11)'),
(@ENTRY * 100 + 2, 9, 8, 0, 0, 0, 100, 0, 3225, 3225, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Talk 3 to invoker'),
(@ENTRY * 100 + 2, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 53, 0, 27951, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Start path #27951, walk, do not repeat, Passive'),
(@ENTRY, 0, 12, 13, 38, 0, 100, 512, 0, 2, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On data[0] set to 2 - Self: Remove all auras'),
(@ENTRY, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On data[0] set to 2 - Self: Remove UNIT_FLAGS to IMMUNE_TO_PC'),
(@ENTRY, 0, 14, 15, 58, 0, 100, 512, 4, 27951, 0, 0, 55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On waypoint 4 of path 27951 ended - Self: Stop path, despawn instantly'),
(@ENTRY, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 2795103, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On waypoint 4 of path 27951 ended - Self: Start timed action list id #Admiral Barean Westwind #3 (2795103) (update always) // -inline'),
(@ENTRY * 100 + 3, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 11, 34427, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Cast spell Ethereal Teleport(34427) on Self'),
(@ENTRY * 100 + 3, 9, 1, 0, 0, 0, 100, 0, 1700, 1700, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Self: Despawn instantly'),
(@ENTRY, 0, 16, 0, 38, 0, 100, 0, 0, 1, 0, 0, 80, 2795104, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - On data[0] set to 1 - Self: Start timed action list id #Admiral Barean Westwind #4 (2795104) (update always) // -inline'),
(@ENTRY * 100 + 4, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Set UNIT_FLAGS to IMMUNE_TO_PC'),
(@ENTRY * 100 + 4, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 524288, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Remove UNIT_FLAGS to IN_COMBAT'),
(@ENTRY * 100 + 4, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 50161, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Cast spell  Protection Sphere (50161) on Self'),
(@ENTRY * 100 + 4, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 27210, 50, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Look at Closest alive creature High General Abbendis (27210) in 50 yards'),
(@ENTRY * 100 + 4, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 11, 27210, 50, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Talk 0 to Creature High General Abbendis (27210) in 50 yd'),
(@ENTRY * 100 + 4, 9, 5, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Admiral Barean Westwind - Set orientation to home position orientation');

DELETE FROM `waypoints` WHERE `entry`=27951;
INSERT INTO `waypoints` VALUES (27951, 1, 2711.5, -352.357, 141.363, NULL, 0, 'Admiral Barean Westwind');
INSERT INTO `waypoints` VALUES (27951, 2, 2718.2, -351.358, 141.363, NULL, 0, 'Admiral Barean Westwind');
INSERT INTO `waypoints` VALUES (27951, 3, 2721.99, -358.182, 141.363, NULL, 0, 'Admiral Barean Westwind');
INSERT INTO `waypoints` VALUES (27951, 4, 2738.1, -355.936, 141.363, NULL, 0, 'Admiral Barean Westwind');

DELETE FROM `creature_text` WHERE `CreatureID` = 27211;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27211, 0, 0, 'About time!', 12, 0, 100, 0, 0, 0, 26292, 0, 'Onslaught Executioner'),
(27211, 1, 0, 'Any last words you impure mongrel?', 12, 0, 100, 0, 0, 0, 26293, 0, 'Onslaught Executioner'),
(27211, 2, 0, 'On second thought, I don\'t care.  Burn in hell wretch!', 12, 0, 100, 0, 0, 0, 26294, 0, 'Onslaught Executioner'),
(27211, 3, 0, 'Hah!  That never gets old.', 12, 0, 100, 0, 0, 0, 26295, 0, 'Onslaught Executioner');

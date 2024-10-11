-- DB update 2024_06_06_00 -> 2024_06_07_00
DELETE FROM `waypoints` WHERE `entry`=104350;
INSERT INTO `waypoints` VALUES 
(104350, 1, 3684.35, -3605.47, 137.872, NULL, 0, NULL),
(104350, 2, 3700.3, -3604.13, 139.578, NULL, 0, NULL),
(104350, 3, 3723.08, -3600.48, 142.359, NULL, 0, NULL),
(104350, 4, 3723.08, -3600.48, 142.359, NULL, 0, NULL);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10435;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 10435);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10435, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 2000, 6000, 0, 0, 11, 16791, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - In Combat - Cast \'Furious Anger\''),
(10435, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 12000, 21000, 0, 0, 11, 10887, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - In Combat - Cast \'Crowd Pummel\''),
(10435, 0, 2, 0, 0, 0, 100, 0, 11000, 12000, 15000, 15000, 0, 0, 11, 14099, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - In Combat - Cast \'Mighty Blow\''),
(10435, 0, 3, 0, 0, 0, 100, 0, 4000, 4000, 12000, 15000, 0, 0, 11, 16793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - In Combat - Cast \'Draining Blow\''),
(10435, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 16794, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On Just Died - Cast \'Transformation\''),
(10435, 0, 5, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 16794, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On Initialize - Cast \'Transformation\''),
(10435, 0, 6, 7, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 20, 175377, 70, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas  - On aggro - Set Closest gameobject  (175377) to GO_STATE_READY'),
(10435, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 20, 175372, 90, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas  - On aggro - Set Closest gameobject (175372) to GO_STATE_READY'),
(10435, 0, 8, 9, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 20, 175377, 70, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On death - Set Closest gameobject (175377)  to GO_STATE_ACTIVE_ALTERNATIVE'),
(10435, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 20, 175372, 90, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas  - On death -  Set Closest gameobject (175372) to GO_STATE_ACTIVE_ALTERNATIVE'),
(10435, 0, 10, 11, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 20, 175377, 70, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas  -  On reset -  Set Closest gameobject (175377) to GO_STATE_ACTIVE_ALTERNATIVE'),
(10435, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 20, 175372, 90, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On reset - Set Closest gameobject (175372) to GO_STATE_ACTIVE_ALTERNATIVE'),
(10435, 0, 12, 13, 38, 0, 100, 0, 0, 1, 0, 0, 0, 0, 53, 1, 104350, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On data[0] set to 1 - Self: Start path #104350, run, do not repeat, Aggressive'),
(10435, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On data[0] set to 1 - Self: Talk 0 to invoker'),
(10435, 0, 14, 0, 40, 0, 100, 0, 2, 104350, 0, 0, 0, 0, 54, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On wapoint 2 of path 104350 reached - Self: Pause path for 1000 ms'),
(10435, 0, 15, 0, 58, 0, 100, 0, 0, 104350, 0, 0, 0, 0, 67, 1, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On any waypoint of path 104350 ended - Trigger timed event timedEvent[1] in 100 - 100 ms // -meta_wait'),
(10435, 0, 16, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 34, 6, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On timed event timedEvent[1] triggered - Set instance data #6 to 3'),
(10435, 0, 17, 18, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 62, 329, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 4068.74, -3535.97, 122.825, 2.47837, 'On respawn - Self: Teleport to (4068.74, -3535.97, 122.825, 2.47837) on map stratholme (329)'),
(10435, 0, 18, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On respawn - Self: Set home position to current position');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 10435 AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES 
(22, 6, 10435, 0, 0, 36, 0, 0, 0, 0, 1, 'Action invoker is dead'),
(22, 13, 10435, 0, 0, 21, 1, 16384, 0, 0, 1, 'Object doesn\'t have unit state UNIT_STATE_ATTACK_PLAYER'),
(22, 18, 10435, 0, 0, 13, 1, 6, 3, 0, 0, 'instance data 6 equals 3');

 -- Service Entrance Gate smart ai
SET @ENTRY := -6851;
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 1 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 54237, 10435, 0, 0, 0, 0, 0, 'On player opened gossip - Creature Magistrate Barthilas (10435) with guid 54237 (fetching): Set creature data #0 to 1'),
(@ENTRY, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 34, 6, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On player opened gossip - Set instance data #6 to 1');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = -6851 AND `SourceId` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES 
(22, 1, -6851, 1, 0, 13, 0, 6, 0, 0, 0, 'instance data 6 equals 0');

-- Aurius
-- Added Combat AI ready to fix the Aurius event to help players kill the baron Rivendare
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10917;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 10917);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10917, 0, 0, 0, 9, 0, 100, 0, 0, 5, 6000, 9000, 0, 11, 14517, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aurius - Cast Crusader Strike'),
(10917, 0, 1, 0, 0, 0, 100, 0, 6000, 14000, 8000, 11000, 0, 11, 17149, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Aurius - Cast Exorcism'),
(10917, 0, 2, 0, 14, 0, 100, 0, 3000, 40, 12000, 16000, 0, 11, 13952, 0, 0, 0, 0, 0, 26, 40, 0, 0, 0, 0, 0, 0, 0, 'Aurius - Cast Holy Light on Friendly Missing HP'),
(10917, 0, 3, 0, 2, 0, 100, 0, 0, 50, 21000, 28000, 0, 11, 13874, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aurius - Cast Divine Shield at 50% HP'),

-- Entering the dungeon near Aurius he will stand up - turn around - salute
(10917, 0, 4, 0, 101, 0, 100, 1, 1, 15, 0, 500, 500, 80, 1091700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aurius -Play_Emote - Emot Event');
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1091700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1091700, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aurius - UNIT_STAND_STATE_STAND'),
(1091700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aurius - SHEATH_STATE_UNARMED'),
(1091700, 9, 2, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 66, 14, 0, 0, 0, 0, 0, 21, 14, 0, 0, 0, 0, 0, 0, 0, 'Aurius - SetFacing To Player'),
(1091700, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aurius - EMOTE_ONESHOT_BOW'),
(1091700, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aurius - SHEATH_STATE_MELEE');

-- say --

-- Crimson Gallant
DELETE FROM `creature_text` WHERE `CreatureID`=10424;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(10424, 0, 0, 'They have broken into the Hall of Lights!  We must stop the intruders!', 14, 7, 100, 0, 0, 0, 6379, 0, 'Crimson Gallant'),
(10424, 1, 0, 'The Scourge have broken through in all wings!  May the light defeat these foul creatures!  We shall fight to the last!', 14, 7, 100, 0, 0, 0, 6439, 0, 'Crimson Gallant');

-- Crimson Monk
DELETE FROM `creature_text` WHERE `CreatureID` = 11043;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11043, 0, 0, 'You carry the taint of the Scourge.  Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 2625, 0, 'Crimson Monk'),
(11043, 0, 1, 'There is no escape for you.  The Crusade shall destroy all who carry the Scourge\'s taint.', 12, 7, 100, 0, 0, 0, 2626, 0, 'Crimson Monk'),
(11043, 0, 2, 'The Light condemns all who harbor evil.  Now you will die!', 12, 7, 100, 0, 0, 0, 2627, 0, 'Crimson Monk'),
(11043, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 2628, 0, 'Crimson Monk'),
(11043, 1, 0, 'This will not be the end of the Scarlet Crusade!  You will not break our line!', 14, 7, 100, 0, 0, 0, 6380, 0, 'Crimson Monk');

-- Grand Crusader Dathrohan
DELETE FROM `creature_text` WHERE `CreatureID`=10812;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(10812, 0, 0, 'Today you have unmade what took me years to create! For this you shall all die by my hand!', 14, 0, 100, 0, 0, 0, 6441, 0, 'Grand Crusader Dathrohan'),
-- This text must be inserted, otherwise the server will start with an error
(10812, 1, 0, 'You fools think you can defeat me so easily? Face the true might of the Nathrezim!', 14, 0, 100, 0, 0, 0, 6447, 0, 'Grand Crusader Dathrohan'),
(10812, 2, 0, 'Damn you mortals! All my plans of revenge, all my hate...I will be avenged...', 12, 0, 100, 0, 0, 0, 6442, 0, 'Grand Crusader Dathrohan');

DELETE FROM `creature_text` WHERE `CreatureID`=10813;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(10813, 1, 0, 'You fools think you can defeat me so easily? Face the true might of the Nathrezim!', 14, 0, 100, 0, 0, 0, 6447, 0, 'Grand Crusader Dathrohan'),
(10813, 2, 0, 'Damn you mortals! All my plans of revenge, all my hate...I will be avenged...', 12, 0, 100, 0, 0, 0, 6442, 0, 'Grand Crusader Dathrohan');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10812;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10812) AND (`source_type` = 0) AND (`id` IN (9,15));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10812, 0, 9, 0, 0, 2, 100, 1, 1000, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - In Combat - Balnazzar Say Line 0'),
(10812, 0, 15, 16, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - On Death - Say Line 1');

-- Baron Rivendare add Broadcast*TextId
UPDATE `creature_text` SET `BroadcastTextId`=11812 WHERE `CreatureID`=10440 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=6289 WHERE `CreatureID`=10440 AND `GroupID`=1 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=11813 WHERE `CreatureID`=10440 AND `GroupID`=2 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=11815 WHERE `CreatureID`=10440 AND `GroupID`=3 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=11814 WHERE `CreatureID`=10440 AND `GroupID`=4 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=6398 WHERE `CreatureID`=10440 AND `GroupID`=5 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=6401 WHERE `CreatureID`=10440 AND `GroupID`=6 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=6511 WHERE `CreatureID`=10440 AND `GroupID`=7 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=6512 WHERE `CreatureID`=10440 AND `GroupID`=8 AND `ID`=0;

-- Bile Spewer
DELETE FROM `creature_text` WHERE `CreatureID`=10416 AND `GroupID`=0 AND `ID`=0;
INSERT INTO `creature_text` VALUES (10416, 0, 0, '%s belches out a disgusting Bile Slime!', 16, 0, 100, 0, 0, 0, 6258, 0, 'Bile Spewer');

-- Ysida Harmon  What is the same text content as GroupID 0 and 1?
UPDATE `creature_text` SET `BroadcastTextId`=11931 WHERE `CreatureID`=16031 AND `GroupID`=1 AND `ID`=0;

-- Crimson Gallant
DELETE FROM `creature_text` WHERE `CreatureID`=10424;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(10424, 0, 0, 'They have broken into the Hall of Lights!  We must stop the intruders!', 14, 7, 100, 0, 0, 0, 6379, 0, 'Crimson Gallant'),
(10424, 1, 0, 'The Scourge have broken through in all wings!  May the light defeat these foul creatures!  We shall fight to the last!', 14, 7, 100, 0, 0, 0, 6439, 0, 'Crimson Gallant');

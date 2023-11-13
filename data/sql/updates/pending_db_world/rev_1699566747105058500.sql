-- Magistrate Barthilas
-- move Position
DELETE FROM `waypoint_data` WHERE `id`=104350;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (104350, 1, 3696.79, -3605.93, 139.041, NULL, 1000, 1, 0, 100, 0),
(104350, 2, 3725.58, -3599.48, 142.367, NULL, 1000, 1, 104350, 100, 0);

-- Teleport after moving to the gate
DELETE FROM `waypoint_scripts` WHERE `guid`=938;
INSERT INTO `waypoint_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`, `guid`) VALUES 
(104350, 1, 6, 329, 1, 0, 4068.28, -3535.68, 122.771, 2.5, 938);



-- magistrate barthilas
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10435;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 10435);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10435, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 2000, 6000, 0, 0, 11, 16791, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - In Combat - Cast Furious Anger'),
(10435, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 12000, 21000, 0, 0, 11, 10887, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - In Combat - Cast Crowd Pummel'),
(10435, 0, 2, 0, 0, 0, 100, 0, 11000, 12000, 15000, 15000, 0, 0, 11, 14099, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - In Combat - Cast Might Blow'),
(10435, 0, 3, 0, 0, 0, 100, 0, 4000, 4000, 12000, 15000, 0, 0, 11, 16793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - In Combat - Cast Drain Blow'),
(10435, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 16794, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On Death - Cast Transformation'),
(10435, 0, 5, 6, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 15, 175377, 70, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On aggro - Gameobject ID 175377: Set gameobject state to ready'),
(10435, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 15, 175372, 90, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On aggro - Gameobject ID 175372: Set gameobject state to ready'),
(10435, 0, 7, 8, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 14, 11165, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On death - Gameobject with guid 11165: Set gameobject state to active'),
(10435, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 14, 6852, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On death - Gameobject with guid 6852: Set gameobject state to active'),
(10435, 0, 9, 10, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 14, 11165, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On reset - Gameobject with guid 11165 : Set gameobject state to active'),
(10435, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 14, 6852, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On reset - Gameobject with guid 6852: Set gameobject state to active');



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



-- bile spewer
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10416;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10416) AND (`source_type` = 0) AND (`id` IN (4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10416, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 14, 6908, 0, 0, 0, 0, 0, 0, 0, 'Bile Spewer - AGGRO - Close Door');


-- venom belcher
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10417;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10417) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10417, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 14, 6908, 0, 0, 0, 0, 0, 0, 0, 'Venom Belcher - Aggr - Close door');


-- baron Rivendare
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10440;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10440) AND (`source_type` = 0) AND (`id` IN (20));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10440, 0, 20, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 14, 6908, 0, 0, 0, 0, 0, 0, 0, 'Baron Ricendare - Aggro - Open Door');

-- say --
-- Magistrate Barthilas
UPDATE `creature_text` SET `BroadcastTextId`=6162 WHERE `CreatureID`=10435 AND `GroupID`=0 AND `ID`=0;

-- Crimson Guardsman
UPDATE `creature_text` SET `BroadcastTextId`=6377 WHERE `CreatureID`=10418 AND `GroupID`=0 AND `ID`=0;

-- Crimson Conjuror
UPDATE `creature_text` SET `BroadcastTextId`=6378 WHERE `CreatureID`=10419 AND `GroupID`=0 AND `ID`=0;

-- Crimson Gallant
DELETE FROM `creature_text` WHERE `CreatureID`=10424;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(10424, 0, 0, 'They have broken into the Hall of Lights!  We must stop the intruders!', 14, 7, 100, 0, 0, 0, 6379, 0, 'Crimson Gallant'),
(10424, 1, 0, 'The Scourge have broken through in all wings!  May the light defeat these foul creatures!  We shall fight to the last!', 14, 7, 100, 0, 0, 0, 6439, 0, 'Crimson Gallant');

-- Crimson Monk
UPDATE `creature_text` SET `BroadcastTextId`=2627 WHERE `CreatureID`=11043 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=2628 WHERE `CreatureID`=11043 AND `GroupID`=0 AND `ID`=1;
UPDATE `creature_text` SET `BroadcastTextId`=2626 WHERE `CreatureID`=11043 AND `GroupID`=0 AND `ID`=2;
UPDATE `creature_text` SET `BroadcastTextId`=2625 WHERE `CreatureID`=11043 AND `GroupID`=0 AND `ID`=3;
UPDATE `creature_text` SET `BroadcastTextId`=6380 WHERE `CreatureID`=11043 AND `GroupID`=1 AND `ID`=0;

-- Grand Crusader Dathrohan
DELETE FROM `creature_text` WHERE `CreatureID`=10812;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(10812, 0, 0, 'Today you have unmade what took me years to create! For this you shall all die by my hand!', 14, 0, 100, 0, 0, 0, 6441, 0, 'Grand Crusader Dathrohan'),

-- This text must be inserted, otherwise the server will start with an error
(10812, 1, 0, 'Damn you mortals! All my plans of revenge, all my hate...I will be avenged...', 12, 0, 100, 0, 0, 0, 6442, 0, 'Grand Crusader Dathrohan');

DELETE FROM `creature_text` WHERE `CreatureID`=10813;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(10813, 0, 0, 'You fools think you can defeat me so easily? Face the true might of the Nathrezim!', 14, 0, 100, 0, 0, 0, 6447, 0, 'Grand Crusader Dathrohan'),
(10813, 1, 0, 'Damn you mortals! All my plans of revenge, all my hate...I will be avenged...', 12, 0, 100, 0, 0, 0, 6442, 0, 'Grand Crusader Dathrohan');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10812;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10812) AND (`source_type` = 0) AND (`id` IN (9,15));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10812, 0, 9, 0, 0, 2, 100, 1, 1000, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - In Combat - Balnazzar Say Line 0'),
(10812, 0, 15, 16, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - On Death - Say Line 1');



-- Ravaged Cadaver
UPDATE `creature_text` SET `BroadcastTextId`=5772 WHERE `CreatureID`=10381 AND `GroupID`=0 AND `ID`=0;

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

-- Thuzadin Acolyte
UPDATE `creature_text` SET `BroadcastTextId`=6527 WHERE `CreatureID`=10399 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=6526 WHERE `CreatureID`=10399 AND `GroupID`=0 AND `ID`=1;
UPDATE `creature_text` SET `BroadcastTextId`=6492 WHERE `CreatureID`=10399 AND `GroupID`=0 AND `ID`=2;

-- Bile Spewer
UPDATE `creature_text` SET `BroadcastTextId`=6257 WHERE `CreatureID`=10416 AND `GroupID`=1 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=6258 WHERE `CreatureID`=10416 AND `GroupID`=0 AND `ID`=0;

-- Ramstein the Gorger
UPDATE `creature_text` SET `BroadcastTextId`=6425 WHERE `CreatureID`=10439 AND `GroupID`=0 AND `ID`=0;

-- Black Guard Sentry
UPDATE `creature_text` SET `BroadcastTextId`=6415 WHERE `CreatureID`=10394 AND `GroupID`=0 AND `ID`=0;

-- Ysida Harmon  What is the same text content as GroupID 0 and 1?
UPDATE `creature_text` SET `BroadcastTextId`=11931 WHERE `CreatureID`=16031 AND `GroupID`=1 AND `ID`=0;

-- Crimson Gallant
DELETE FROM `creature_text` WHERE `CreatureID`=10424;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(10424, 0, 0, 'They have broken into the Hall of Lights!  We must stop the intruders!', 14, 7, 100, 0, 0, 0, 6379, 0, 'Crimson Gallant'),
(10424, 1, 0, 'The Scourge have broken through in all wings!  May the light defeat these foul creatures!  We shall fight to the last!', 14, 7, 100, 0, 0, 0, 6439, 0, 'Crimson Gallant');

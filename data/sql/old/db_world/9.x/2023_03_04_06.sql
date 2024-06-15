-- DB update 2023_03_04_05 -> 2023_03_04_06
--
DELETE FROM `creature_text` WHERE `CreatureID`=17876 AND `GroupID` IN (21,22,23);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17876, 21, 0, 'Thrall startles the horse with a fierce yell!', 16, 0, 100, 0, 0, 0, 16499, 0, 'Thrall Horse Emote'),
(17876, 22, 0, 'Thrall tries to calm the horse down.', 16, 0, 100, 0, 0, 0, 15970, 0, 'Thrall Horse Emote 2'),
(17876, 23, 0, 'Taretha isn\'t here. Let\'s head into town.', 12, 0, 100, 0, 0, 0, 15974, 0, 'Thrall Say Lead');

DELETE FROM `creature_text` WHERE `CreatureID`=18096;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18096, 0, 0, 'Thrall! Come outside and face your fate!', 14, 0, 100, 0, 0, 10418, 16016, 0, 'epoch hunter SAY_ENTER1'),
(18096, 1, 0, 'Taretha\'s life hangs in the balance. Surely you care for her. Surely you wish to save her... ', 14, 0, 100, 0, 0, 10419, 16019, 0, 'epoch hunter SAY_ENTER2'),
(18096, 2, 0, 'Ah, there you are. I had hoped to accomplish this with a bit of subtlety, but I suppose direct confrontation was inevitable. Your future, Thrall, must not come to pass and so... you and your troublesome friends must die!', 14, 0, 100, 0, 0, 10420, 16021, 0, 'epoch hunter SAY_ENTER3'),
(18096, 3, 0, 'Enough, I will erase your very existence!', 14, 0, 100, 0, 0, 10421, 16023, 0, 'epoch hunter SAY_AGGRO1'),
(18096, 3, 1, 'You cannot fight fate!', 14, 0, 100, 0, 0, 10422, 16693, 0, 'epoch hunter SAY_AGGRO2'),
(18096, 4, 0, 'You are... irrelevant.', 14, 0, 100, 0, 0, 10425, 16694, 0, 'epoch hunter SAY_SLAY1'),
(18096, 4, 1, 'Thrall will remain a slave. Taretha will die. You have failed.', 14, 0, 100, 0, 0, 10426, 16695, 0, 'epoch hunter SAY_SLAY2'),
(18096, 5, 0, 'Not so fast!', 14, 0, 100, 0, 0, 10423, 16691, 0, 'epoch hunter SAY_BREATH1'),
(18096, 5, 1, 'Struggle as much as you like...', 14, 0, 100, 0, 0, 10424, 16692, 0, 'epoch hunter SAY_BREATH2'),
(18096, 6, 0, 'Thrall will remain a slave. Taretha will die. You have failed.', 14, 0, 100, 0, 0, 10426, 16695, 0, 'epoch hunter SAY_SLAY2'),
(18096, 7, 0, 'Not so fast!', 14, 0, 100, 0, 0, 10423, 16691, 0, 'epoch hunter SAY_BREATH1'),
(18096, 7, 1, 'Struggle as much as you like...', 14, 0, 100, 0, 0, 10424, 16692, 0, 'epoch hunter SAY_BREATH2'),
(18096, 8, 0, 'No! The master will... not be... pleased.', 14, 0, 100, 0, 0, 10427, 16696, 0, 'epoch hunter SAY_DEATH');

UPDATE `script_waypoint` SET `waitTime`=13000 WHERE `entry`=17876 AND `pointid`=10;
UPDATE `script_waypoint` SET `waitTime`=20000 WHERE `entry`=17876 AND `pointid`=67;

DELETE FROM `waypoints` WHERE `entry` IN (180920,180921,180930,180940);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`) VALUES
(180920,1,2498.1045,695.5946,55.63158),
(180920,2,2495.6223,694.5012,55.63158),
(180920,3,2492.622,693.5881,55.699432),
(180920,4,2490.3777,695.98254,55.72346),
(180920,5,2490.0405,699.02325,55.73774),
(180920,6,2489.702,702.07544,55.759163),
(180920,7,2489.3306,702.90985,55.765854),
(180920,8,2488.1714,702.7047,55.77027),

(180921,1,2496.374,695.5221,55.63158),
(180921,2,2493.9353,694.89294,55.699627),
(180921,3,2490.935,693.97974,55.711452),
(180921,4,2491.0732,697.56885,55.724335),
(180921,5,2490.736,700.60956,55.741653),
(180921,6,2490.3975,703.66174,55.76295),
(180921,7,2487.7026,703.5013,55.777214),

(180930,1,2497.1765,697.05707,55.63158),
(180930,2,2495.118,696.15826,55.63158),
(180930,3,2492.1177,695.24506,55.70963),
(180930,4,2492.099,696.17346,55.713726),
(180930,5,2491.762,699.2142,55.728592),
(180930,6,2491.4233,702.26636,55.751934),
(180930,7,2489.0288,704.6154,55.77536),
(180930,8,2487.8696,704.4103,55.780678),

(180940,1,2495.4795,694.95447,55.63158),
(180940,2,2491.4536,694.1376,55.70895),
(180940,3,2490.363,703.972,55.764732);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18092 AND `id` IN (3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18092, 0, 3, 4, 72, 0, 100, 512, 2, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Guardsman - Do Action - Remove Unit Flag'),
(18092, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 180920, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Guardsman - Do Action - Start WP'),
(18092, 0, 5, 6, 72, 0, 100, 0, 2, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Guardsman - Do Action - Remove Unit Flag'),
(18092, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 180921, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Guardsman - Do Action - Start WP');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=18092 AND `SourceId` IN (4,6);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,0,18092,4,0,1,1,22805,0,0,0,0,0,'','Exeucte SAI if aura present'),
(22,0,18092,6,0,1,1,22805,0,0,1,0,0,'','Exeucte SAI if aura not present');

UPDATE `smart_scripts` SET `link`=8 WHERE `entryorguid`=18093 AND `source_type`=0 AND `id`=7;
DELETE FROM `smart_scripts` WHERE `entryorguid`=18093 AND `source_type`=0 AND `id`=8;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18093,0,8,0,61,0,100,0,0,0,0,0,0,53,0,180930,0,0,0,2,1,0,0,0,0,0,0,0,0,'Tarren Mill Protector - Do Action - Start WP');

UPDATE `smart_scripts` SET `link`=6 WHERE `entryorguid`=18094 AND `source_type`=0 AND `id`=5;
DELETE FROM `smart_scripts` WHERE `entryorguid`=18094 AND `source_type`=0 AND `id`=6;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18094,0,6,0,61,0,100,0,0,0,0,0,0,53,0,180940,0,0,0,2,1,0,0,0,0,0,0,0,0,'Tarren Mill Lookout - Do Action - Start WP');

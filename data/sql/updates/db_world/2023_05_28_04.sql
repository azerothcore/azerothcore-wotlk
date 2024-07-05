-- DB update 2023_05_28_03 -> 2023_05_28_04
UPDATE `creature_template` SET `ScriptName` = 'npc_shattered_hand_scout' WHERE `entry` = 17693;

SET @PATH := 17693 * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH,1,389.98074,315.4098,1.9338964,NULL,0,1,0,100,0),
(@PATH,2,419.4097,315.15308,1.940825,NULL,0,1,0,100,0),
(@PATH,3,460.31537,316.02213,1.9368871,NULL,0,1,0,100,0),
(@PATH,4,488.62424,315.73007,1.9498857,NULL,0,1,0,100,0);

DELETE FROM `spell_target_position` WHERE `ID` = 30976;
INSERT INTO `spell_target_position` (`ID`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `VerifiedBuild`) VALUES
(30976, 540, 520.062, 255.486, 2.0333333, 48999);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 30952);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 30952, 0, 0, 31, 0, 3, 17687, 0, 0, 0, 0, '', 'Shoot Flame Arrow (30952) only hit Flame Arrow (17687)');

DELETE FROM `creature_formations` WHERE `memberGUID` IN (151094,151095,151096,151097);
INSERT INTO `creature_formations` (`memberGUID`, `leaderGUID`, `groupAI`) VALUES
(151095,151095,3),
(151096,151095,3),
(151097,151095,3);

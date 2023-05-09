-- DB update 2023_05_09_00 -> 2023_05_09_01
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|67108864 WHERE (`entry` = 18829);

DELETE FROM `creature_addon` WHERE (`guid` IN (90985, 90986, 90987, 90988, 90989, 90990, 90991, 90992, 90993, 91247, 91248, 91249));
DELETE FROM `waypoint_data` WHERE `id` IN (909910, 909920, 909930);
UPDATE `creature_template_addon` SET `bytes2` = 1 WHERE (`entry` = 18829);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18829) AND (`source_type` = 0) AND (`id` IN (7, 8));
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-91247,-91248,-91249,-90985,-90986,-90987));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-91247, 0, 1000, 0, 1, 0, 100, 1, 3600, 3600, 0, 0, 0, 11, 33346, 0, 0, 0, 0, 0, 10, 90984, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - On Reset - Cast Green Beam'),
(-91248, 0, 1000, 0, 1, 0, 100, 1, 3600, 3600, 0, 0, 0, 11, 33346, 0, 0, 0, 0, 0, 10, 90984, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - On Reset - Cast Green Beam'),
(-91249, 0, 1000, 0, 1, 0, 100, 1, 3600, 3600, 0, 0, 0, 11, 33346, 0, 0, 0, 0, 0, 10, 90984, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - On Reset - Cast Green Beam'),
(-90985, 0, 1000, 0, 1, 0, 100, 1, 3600, 3600, 0, 0, 0, 11, 33827, 0, 0, 0, 0, 0, 10, 91250, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - On Reset - Cast Hellfire Warder Channel Visual'),
(-90986, 0, 1000, 0, 1, 0, 100, 1, 3600, 3600, 0, 0, 0, 11, 33827, 0, 0, 0, 0, 0, 10, 91250, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - On Reset - Cast Hellfire Warder Channel Visual'),
(-90987, 0, 1000, 0, 1, 0, 100, 1, 3600, 3600, 0, 0, 0, 11, 33827, 0, 0, 0, 0, 0, 10, 91250, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - On Reset - Cast Hellfire Warder Channel Visual');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceEntry` = 18829);

SET @NPC := 90991;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-73.72693,`position_y`=47.355293,`position_z`=-0.38537598 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-73.72693,`position_y`=47.355293,`position_z`=-0.38537598 WHERE `guid` IN (90992, 90993) AND `id1` = 18829;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-73.72693,47.355293,-0.38537598,NULL,0,0,0,100,0),
(@PATH,2,-53.951275,58.999866,3.1846943,NULL,0,0,0,100,0),
(@PATH,3,-28.083755,65.604164,15.94728,NULL,0,0,0,100,0),
(@PATH,4,-3.498642,66.86735,22.654028,NULL,0,0,0,100,0),
(@PATH,5,14.21773,57.512276,22.968313,NULL,0,0,0,100,0),
(@PATH,6,29.301313,40.577045,33.289814,NULL,0,0,0,100,0),
(@PATH,7,44.670013,16.09524,45.009865,NULL,0,0,0,100,0),
(@PATH,8,44.010056,-11.347733,45.010532,NULL,0,0,0,100,0),
(@PATH,9,33.572083,-28.368456,37.985077,NULL,0,0,0,100,0),
(@PATH,10,14.805847,-53.501915,22.991356,NULL,0,0,0,100,0),
(@PATH,11,-11.261587,-62.130146,22.562366,NULL,0,0,0,100,0),
(@PATH,12,-37.538406,-59.60784,11.227191,NULL,0,0,0,100,0),
(@PATH,13,-70.55042,-44.39177,-0.3772414,NULL,0,0,0,100,0),
(@PATH,14,-37.538406,-59.60784,11.227191,NULL,0,0,0,100,0),
(@PATH,15,-11.261587,-62.130146,22.562366,NULL,0,0,0,100,0),
(@PATH,16,14.805847,-53.501915,22.991356,NULL,0,0,0,100,0),
(@PATH,17,33.572083,-28.368456,37.985077,NULL,0,0,0,100,0),
(@PATH,18,44.010056,-11.347733,45.010532,NULL,0,0,0,100,0),
(@PATH,19,44.670013,16.09524,45.009865,NULL,0,0,0,100,0),
(@PATH,20,29.301313,40.577045,33.289814,NULL,0,0,0,100,0),
(@PATH,21,14.21773,57.512276,22.968313,NULL,0,0,0,100,0),
(@PATH,22,-3.498642,66.86735,22.654028,NULL,0,0,0,100,0),
(@PATH,23,-28.083755,65.604164,15.94728,NULL,0,0,0,100,0),
(@PATH,24,-53.951275,58.999866,3.1846943,NULL,0,0,0,100,0);

DELETE FROM `creature_formations` WHERE `memberGUID` IN (90991, 90992, 90993);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(90991, 90991, 0, 0, 515),
(90991, 90992, 4, 90, 515),
(90991, 90993, 4, 270, 515);

DELETE FROM `creature_formations` WHERE `memberGUID` IN (91247,91248,91249,90985,90986,90987,90988,90989,90990);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `groupAI`) VALUES
(91247, 91247, 3),
(91247, 91248, 3),
(91247, 91249, 3),
(90985, 90985, 3),
(90985, 90986, 3),
(90985, 90987, 3),
(90988, 90988, 3),
(90988, 90989, 3),
(90988, 90990, 3);

UPDATE `creature` SET `id1` = 15384 WHERE `guid` = 91250 AND `id1` = 19871;

SET @CGUID := 99126;

DELETE FROM `creature` WHERE `id1` = 17474 AND `map` = 544;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`) VALUES
(@CGUID+0 , 17474, 544, 3836, 3836, 12.277288, 1.4221332, -0.41251224, 0, 7200, 17.5, 1, 49444),
(@CGUID+1 , 17474, 544, 3836, 3836, 12.209613, -1.6456745, -0.4125001, 0, 7200, 15, 1, 49444),
(@CGUID+2 , 17474, 544, 3836, 3836, -41.256805, -18.75815, -0.41244552, 0, 7200, 15.5, 1, 49444),
(@CGUID+3 , 17474, 544, 3836, 3836, -36.77449, -18.470839, -0.41244859, 0, 7200, 14.5, 1, 49444),
(@CGUID+4 , 17474, 544, 3836, 3836, -39.86548, 23.40396, -0.41246653, 0, 7200, 15, 1, 49444),
(@CGUID+5 , 17474, 544, 3836, 3836, -39.30522, 22.472437, -0.41246665, 0, 7200, 18, 1, 49444),
(@CGUID+6 , 17474, 544, 3836, 3836, -10.57025, -36.72588, -0.412454, 0, 7200, 14, 1, 49444),
(@CGUID+7 , 17474, 544, 3836, 3836, -23.366783, -28.944124, -0.41246164, 0, 7200, 14.5, 1, 49444),
(@CGUID+8 , 17474, 544, 3836, 3836, -5.876664, 30.14057, -0.412483, 0, 7200, 16, 1, 49444),
(@CGUID+9 , 17474, 544, 3836, 3836, -12.428505, 38.717083, -0.1680651, 0, 7200, 16.5, 1, 49444),
(@CGUID+10, 17474, 544, 3836, 3836, -15.282015, -1.4561253, -0.4121307, 0, 7200, 10.8, 1, 49444),
(@CGUID+11, 17474, 544, 3836, 3836, -15.024544, 0.8793583, -0.41213986, 0, 7200, 11.5, 1, 49444);

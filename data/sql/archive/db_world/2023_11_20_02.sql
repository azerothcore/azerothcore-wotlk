-- DB update 2023_11_20_01 -> 2023_11_20_02
--
DELETE FROM `spell_target_position` WHERE `id` = 36459;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(36459, 0, 548, -347.518, -350.367, 1.07459, 0, 52188);

DELETE FROM `creature` WHERE `id1` IN (21260, 21253);

SET @NPC := 21253;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-323.41907,-329.45224,-1.5974255,0,0,0,0,100,0),
(@PATH,2,-304.07327,-324.3901,-1.6223572,0,0,0,0,100,0),
(@PATH,3,-285.72675,-317.75647,-1.6231745,0,0,0,0,100,0),
(@PATH,4,-268.1212,-317.92252,-1.6231549,0,0,0,0,100,0),
(@PATH,5,-250.01706,-326.13535,-1.6231577,0,0,0,0,100,0),
(@PATH,6,-232.28586,-345.37613,-0.82795566,0,3000,0,0,100,0),
(@PATH,7,-207.17967,-340.97714,-1.6231886,0,0,0,0,100,0),
(@PATH,8,-191.20467,-342.70514,-1.6231867,0,0,0,0,100,0),
(@PATH,9,-179.45354,-352.66028,-1.6231802,0,0,0,0,100,0),
(@PATH,10,-168.25655,-366.4079,-1.6235477,0,0,0,0,100,0),
(@PATH,11,-157.60028,-380.57797,-1.618623,0,0,0,0,100,0),
(@PATH,12,-142.09798,-404.16937,0.4633386,0,0,0,0,100,0),
(@PATH,13,-146.7672,-423.9643,1.0743836,0,0,0,0,100,0);

DELETE FROM `creature_addon` WHERE `guid` IN (81027, 82865, 82967, 93788);
DELETE FROM `linked_respawn` WHERE `guid` IN (81027, 82865, 82967, 93788);

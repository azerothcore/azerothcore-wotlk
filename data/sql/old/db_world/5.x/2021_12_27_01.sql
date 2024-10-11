-- DB update 2021_12_27_00 -> 2021_12_27_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_27_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_27_00 2021_12_27_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640100224987273652'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640100224987273652');

DELETE FROM `creature` WHERE `guid`=55733;

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55589;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9506.563,`position_y`=-6578.2944,`position_z`=19.420492 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9506.563,-6578.2944,19.420492,0,0,0,0,100,0),
(@PATH,2,9507.277,-6538.9165,21.695831,0,0,0,0,100,0),
(@PATH,3,9507.768,-6516.6167,21.929632,0,0,0,0,100,0),
(@PATH,4,9521.356,-6502.862,22.685003,0,0,0,0,100,0),
(@PATH,5,9536.49,-6494.0513,22.827436,0,0,0,0,100,0),
(@PATH,6,9521.356,-6502.862,22.685003,0,0,0,0,100,0),
(@PATH,7,9507.768,-6516.6167,21.929632,0,0,0,0,100,0),
(@PATH,8,9507.277,-6538.9165,21.695831,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55571;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9506.733,`position_y`=-6561.678,`position_z`=21.106964 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9506.733,-6561.678,21.106964,0,0,0,0,100,0),
(@PATH,2,9507.872,-6591.0024,18.020834,0,0,0,0,100,0),
(@PATH,3,9511.56,-6636.63,14.709623,0,0,0,0,100,0),
(@PATH,4,9517.866,-6647.6807,14.709623,0,0,0,0,100,0),
(@PATH,5,9532.879,-6657.527,12.818632,0,0,0,0,100,0),
(@PATH,6,9538.25,-6659.41,11.492346,0,0,0,0,100,0),
(@PATH,7,9532.879,-6657.527,12.818632,0,0,0,0,100,0),
(@PATH,8,9517.866,-6647.6807,14.709623,0,0,0,0,100,0),
(@PATH,9,9511.56,-6636.63,14.709623,0,0,0,0,100,0),
(@PATH,10,9507.872,-6591.0024,18.020834,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55575;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9815.366,`position_y`=-6492.4453,`position_z`=10.871314 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9815.366,-6492.4453,10.871314,0,0,0,0,100,0),
(@PATH,2,9805.167,-6490.022,9.563148,0,0,0,0,100,0),
(@PATH,3,9792.286,-6491.41,7.28751,0,0,0,0,100,0),
(@PATH,4,9784.372,-6496.444,5.0993385,0,0,0,0,100,0),
(@PATH,5,9777.1455,-6509.8447,4.694892,0,0,0,0,100,0),
(@PATH,6,9762.139,-6509.692,4.646071,0,0,0,0,100,0),
(@PATH,7,9751.457,-6508.3335,4.771071,0,0,0,0,100,0),
(@PATH,8,9737.317,-6496.72,7.4416666,0,0,0,0,100,0),
(@PATH,9,9751.457,-6508.3335,4.771071,0,0,0,0,100,0),
(@PATH,10,9762.139,-6509.692,4.646071,0,0,0,0,100,0),
(@PATH,11,9777.1455,-6509.8447,4.694892,0,0,0,0,100,0),
(@PATH,12,9784.372,-6496.444,5.0993385,0,0,0,0,100,0),
(@PATH,13,9792.286,-6491.41,7.28751,0,0,0,0,100,0),
(@PATH,14,9805.167,-6490.022,9.563148,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55586;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9695.087,`position_y`=-6516.658,`position_z`=6.457355 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9695.087,-6516.658,6.457355,0,0,0,0,100,0),
(@PATH,2,9694.442,-6492.726,8.660556,0,0,0,0,100,0),
(@PATH,3,9707.146,-6492.106,8.265313,0,0,0,0,100,0),
(@PATH,4,9720.994,-6491.4893,8.392266,0,0,0,0,100,0),
(@PATH,5,9733.76,-6493.9277,7.860612,0,0,0,0,100,0),
(@PATH,6,9720.994,-6491.4893,8.392266,0,0,0,0,100,0),
(@PATH,7,9707.146,-6492.106,8.265313,0,0,0,0,100,0),
(@PATH,8,9694.442,-6492.726,8.660556,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55576;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9893.542,`position_y`=-6647.347,`position_z`=10.822214 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9893.542,-6647.347,10.822214,0,0,0,0,100,0),
(@PATH,2,9878.062,-6628.788,9.591076,0,0,0,0,100,0),
(@PATH,3,9866.348,-6617.358,9.028847,0,0,0,0,100,0),
(@PATH,4,9878.062,-6628.788,9.591076,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55588;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9778.824,`position_y`=-6554.8306,`position_z`=4.003037 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9778.824,-6554.8306,4.003037,0,0,0,0,100,0),
(@PATH,2,9771.887,-6554.979,4.692673,0,0,0,0,100,0),
(@PATH,3,9755.896,-6552.4634,4.8141484,0,0,0,0,100,0),
(@PATH,4,9743.761,-6545.499,4.6891484,0,0,0,0,100,0),
(@PATH,5,9728.578,-6553.135,3.932308,0,0,0,0,100,0),
(@PATH,6,9711.016,-6563.2285,3.4074056,0,0,0,0,100,0),
(@PATH,7,9705.32,-6559.876,3.8095052,0,0,0,0,100,0),
(@PATH,8,9697.602,-6543.2163,5.172127,0,0,0,0,100,0),
(@PATH,9,9698.132,-6534.4126,5.670662,0,0,0,0,100,0),
(@PATH,10,9697.602,-6543.2163,5.172127,0,0,0,0,100,0),
(@PATH,11,9705.32,-6559.876,3.8095052,0,0,0,0,100,0),
(@PATH,12,9711.016,-6563.2285,3.4074056,0,0,0,0,100,0),
(@PATH,13,9728.359,-6553.2676,3.932308,0,0,0,0,100,0),
(@PATH,14,9743.761,-6545.499,4.6891484,0,0,0,0,100,0),
(@PATH,15,9755.896,-6552.4634,4.8141484,0,0,0,0,100,0),
(@PATH,16,9771.887,-6554.979,4.692673,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55577;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9816.146,`position_y`=-6812.5,`position_z`=14.8066845 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9816.146,-6812.5,14.8066845,0,0,0,0,100,0),
(@PATH,2,9861.069,-6803.586,13.529595,0,0,0,0,100,0),
(@PATH,3,9880.804,-6792.4194,12.252535,0,0,0,0,100,0),
(@PATH,4,9887.201,-6781.915,12.127535,0,0,0,0,100,0),
(@PATH,5,9889.891,-6762.7935,12.125087,0,0,0,0,100,0),
(@PATH,6,9891.433,-6754.3096,12.125087,0,0,0,0,100,0),
(@PATH,7,9894.559,-6736.954,12.125087,0,0,0,0,100,0),
(@PATH,8,9896.412,-6713.5938,12.137058,0,0,0,0,100,0),
(@PATH,9,9897.033,-6699.49,12.197214,0,0,0,0,100,0),
(@PATH,10,9896.412,-6713.5938,12.137058,0,0,0,0,100,0),
(@PATH,11,9894.559,-6736.954,12.125087,0,0,0,0,100,0),
(@PATH,12,9891.433,-6754.3096,12.125087,0,0,0,0,100,0),
(@PATH,13,9889.891,-6762.7935,12.125087,0,0,0,0,100,0),
(@PATH,14,9887.201,-6781.915,12.127535,0,0,0,0,100,0),
(@PATH,15,9880.804,-6792.4194,12.252535,0,0,0,0,100,0),
(@PATH,16,9861.069,-6803.586,13.529595,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55584;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9614.294,`position_y`=-6620.0225,`position_z`=4.1545334 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9614.294,-6620.0225,4.1545334,0,0,0,0,100,0),
(@PATH,2,9590.396,-6635.608,6.057633,0,0,0,0,100,0),
(@PATH,3,9560.556,-6662.2734,6.843176,0,0,0,0,100,0),
(@PATH,4,9558.408,-6682.9736,7.3493633,0,0,0,0,100,0),
(@PATH,5,9557.082,-6692.157,7.5993633,0,0,0,0,100,0),
(@PATH,6,9558.408,-6682.9736,7.3493633,0,0,0,0,100,0),
(@PATH,7,9560.556,-6662.2734,6.843176,0,0,0,0,100,0),
(@PATH,8,9590.396,-6635.608,6.057633,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55585;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9627.995,`position_y`=-6568.2056,`position_z`=4.8073654 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9627.995,-6568.2056,4.8073654,0,0,0,0,100,0),
(@PATH,2,9627.959,-6556.094,5.565211,0,0,0,0,100,0),
(@PATH,3,9626.396,-6533.458,7.9261727,0,0,0,0,100,0),
(@PATH,4,9623.422,-6512.0815,10.812044,0,0,0,0,100,0),
(@PATH,5,9618.45,-6497.971,12.1679,0,0,0,0,100,0),
(@PATH,6,9623.422,-6512.0815,10.812044,0,0,0,0,100,0),
(@PATH,7,9626.396,-6533.458,7.9261727,0,0,0,0,100,0),
(@PATH,8,9627.959,-6556.094,5.565211,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55587;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9698.328,`position_y`=-6534.8745,`position_z`=5.670662 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9698.328,-6534.8745,5.670662,0,0,0,0,100,0),
(@PATH,2,9697.866,-6545.1787,5.1141434,0,0,0,0,100,0),
(@PATH,3,9702.912,-6556.2905,4.202938,0,0,0,0,100,0),
(@PATH,4,9706.6045,-6564.3604,3.5413167,0,0,0,0,100,0),
(@PATH,5,9711.666,-6568.145,3.1790285,0,0,0,0,100,0),
(@PATH,6,9733.121,-6572.1733,2.1314821,0,0,0,0,100,0),
(@PATH,7,9746.721,-6574.4805,1.9113905,0,0,0,0,100,0),
(@PATH,8,9733.121,-6572.1733,2.1314821,0,0,0,0,100,0),
(@PATH,9,9711.666,-6568.145,3.1790285,0,0,0,0,100,0),
(@PATH,10,9706.6045,-6564.3604,3.5413167,0,0,0,0,100,0),
(@PATH,11,9702.912,-6556.2905,4.202938,0,0,0,0,100,0),
(@PATH,12,9697.866,-6545.1787,5.1141434,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55582;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9680.283,`position_y`=-6754.4946,`position_z`=0.860585 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9680.283,-6754.4946,0.860585,0,0,0,0,100,0),
(@PATH,2,9698.6,-6770.01,2.805438,0,0,0,0,100,0),
(@PATH,3,9721.754,-6766.0586,3.7985168,0,0,0,0,100,0),
(@PATH,4,9734.345,-6755.3594,4.0162206,0,0,0,0,100,0),
(@PATH,5,9746.513,-6741.6704,2.2295995,0,0,0,0,100,0),
(@PATH,6,9745.0205,-6726.203,1.0208384,0,0,0,0,100,0),
(@PATH,7,9737.717,-6708.9614,0.653834,0,0,0,0,100,0),
(@PATH,8,9722.521,-6689.5845,-0.3715247,0,0,0,0,100,0),
(@PATH,9,9712.473,-6687.374,-0.16888797,0,0,0,0,100,0),
(@PATH,10,9697.277,-6690.136,-1.2643509,0,0,0,0,100,0),
(@PATH,11,9682.954,-6697.1353,-2.9650345,0,0,0,0,100,0),
(@PATH,12,9668.647,-6708.9497,-3.121284,0,0,0,0,100,0),
(@PATH,13,9665.899,-6723.153,-2.7384582,0,0,0,0,100,0),
(@PATH,14,9666.404,-6733.253,-2.2384582,0,0,0,0,100,0),
(@PATH,15,9668.493,-6741.481,-1.0310166,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55583;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9587.938,`position_y`=-6799.3716,`position_z`=12.691641 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9587.938,-6799.3716,12.691641,0,0,0,0,100,0),
(@PATH,2,9620.347,-6799.769,10.898052,0,0,0,0,100,0),
(@PATH,3,9646.822,-6800.993,11.396337,0,0,0,0,100,0),
(@PATH,4,9658.064,-6801.679,11.896337,0,0,0,0,100,0),
(@PATH,5,9646.822,-6800.993,11.396337,0,0,0,0,100,0),
(@PATH,6,9620.347,-6799.769,10.898052,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55579;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9819.008,`position_y`=-6834.79,`position_z`=17.409399 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9819.008,-6834.79,17.409399,0,0,0,0,100,0),
(@PATH,2,9816.708,-6823.3457,15.4316845,0,0,0,0,100,0),
(@PATH,3,9814.559,-6813.8257,14.8066845,0,0,0,0,100,0),
(@PATH,4,9809.167,-6809.2485,14.5566845,0,0,0,0,100,0),
(@PATH,5,9783.6455,-6806.043,14.499349,0,0,0,0,100,0),
(@PATH,6,9809.167,-6809.2485,14.5566845,0,0,0,0,100,0),
(@PATH,7,9814.559,-6813.8257,14.8066845,0,0,0,0,100,0),
(@PATH,8,9816.708,-6823.3457,15.4316845,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55572;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9673.285,`position_y`=-6851.815,`position_z`=20.042854 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9673.285,-6851.815,20.042854,0,0,0,0,100,0),
(@PATH,2,9663.573,-6836.067,17.068417,0,0,0,0,100,0),
(@PATH,3,9648.542,-6821.6665,12.55869,0,0,0,0,100,0),
(@PATH,4,9624.031,-6816.225,12.984678,0,0,0,0,100,0),
(@PATH,5,9648.542,-6821.6665,12.55869,0,0,0,0,100,0),
(@PATH,6,9663.573,-6836.067,17.068417,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55581;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9775.571,`position_y`=-6724.7925,`position_z`=0.088252544 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9775.571,-6724.7925,0.088252544,0,0,0,0,100,0),
(@PATH,2,9774.77,-6734.8228,0.1856541,0,0,0,0,100,0),
(@PATH,3,9781.207,-6766.1973,6.435654,0,0,0,0,100,0),
(@PATH,4,9783.794,-6789.6704,12.517052,0,0,0,0,100,0),
(@PATH,5,9783.619,-6803.123,14.4366045,0,0,0,0,100,0),
(@PATH,6,9783.794,-6789.6704,12.517052,0,0,0,0,100,0),
(@PATH,7,9781.219,-6766.2407,6.4586034,0,0,0,0,100,0),
(@PATH,8,9774.77,-6734.8228,0.1856541,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55580;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9758.31,`position_y`=-6852.8433,`position_z`=19.123383 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9758.31,-6852.8433,19.123383,0,0,0,0,100,0),
(@PATH,2,9757.33,-6828.186,16.180866,0,0,0,0,100,0),
(@PATH,3,9760.911,-6809.3657,14.873005,0,0,0,0,100,0),
(@PATH,4,9774.598,-6807.496,14.624349,0,0,0,0,100,0),
(@PATH,5,9760.911,-6809.3657,14.873005,0,0,0,0,100,0),
(@PATH,6,9757.33,-6828.186,16.180866,0,0,0,0,100,0);

-- Pathing for Arcane Patroller Entry: 15638
SET @NPC := 55578;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9807.921,`position_y`=-6730.2134,`position_z`=19.139362 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9807.921,-6730.2134,19.139362,0,0,0,0,100,0),
(@PATH,2,9810.873,-6735.1895,19.177347,0,0,0,0,100,0),
(@PATH,3,9817.785,-6737.5464,19.19361,0,0,0,0,100,0),
(@PATH,4,9827.669,-6735.2324,19.197802,0,0,0,0,100,0),
(@PATH,5,9833.143,-6728.185,19.18879,0,0,0,0,100,0),
(@PATH,6,9827.925,-6713.9434,19.124517,0,0,0,0,100,0),
(@PATH,7,9833.143,-6728.185,19.18879,0,0,0,0,100,0),
(@PATH,8,9827.669,-6735.2324,19.197802,0,0,0,0,100,0),
(@PATH,9,9817.785,-6737.5464,19.19361,0,0,0,0,100,0),
(@PATH,10,9810.873,-6735.1895,19.177347,0,0,0,0,100,0);

-- Pathing for Silvermoon Guardian Entry: 16221
SET @NPC := 56876;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9558.3955,`position_y`=-6743.3853,`position_z`=10.524862 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9558.3955,-6743.3853,10.524862,0,0,0,0,100,0),
(@PATH,2,9583.363,-6729.3804,5.836354,0,0,0,0,100,0),
(@PATH,3,9611.343,-6712.439,5.781703,0,0,0,0,100,0),
(@PATH,4,9639.23,-6696.1533,5.7936373,0,0,0,0,100,0),
(@PATH,5,9676.211,-6670.011,6.6287155,0,0,0,0,100,0),
(@PATH,6,9717.48,-6644.643,6.547022,0,0,0,0,100,0),
(@PATH,7,9755.677,-6620.722,8.290506,0,0,0,0,100,0),
(@PATH,8,9790.733,-6603.264,8.421807,0,0,0,0,100,0),
(@PATH,9,9820.112,-6586.9897,8.712261,0,0,0,0,100,0),
(@PATH,10,9817.183,-6580.9673,8.774227,0,0,0,0,100,0),
(@PATH,11,9787.839,-6598.176,8.472772,0,0,0,0,100,0),
(@PATH,12,9755.116,-6619.5024,8.290506,0,0,0,0,100,0),
(@PATH,13,9716.602,-6643.7256,6.5118046,0,0,0,0,100,0),
(@PATH,14,9675.236,-6668.0537,6.6287155,0,0,0,0,100,0),
(@PATH,15,9635.08,-6689.944,5.6633687,0,0,0,0,100,0),
(@PATH,16,9607.67,-6707.251,5.670953,0,0,0,0,100,0),
(@PATH,17,9580.112,-6723.8115,5.757252,0,0,0,0,100,0),
(@PATH,18,9556.634,-6741.4023,10.6068325,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_27_01' WHERE sql_rev = '1640100224987273652';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

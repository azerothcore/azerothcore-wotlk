-- DB update 2022_01_03_05 -> 2022_01_03_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_03_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_03_05 2022_01_03_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640803052473980355'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640803052473980355');

-- Dalaran Crater, Alterac Mountains

-- Pathing for Elemental Slave Entry: 2359.
SET @NPC := 16818;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=457.73822,`position_y`=214.55646,`position_z`=42.041195 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,457.73822,214.55646,42.041195,0,0,0,0,100,0),
(@PATH,2,445.96973,214.29796,42.032284,0,0,0,0,100,0),
(@PATH,3,442.92194,206.45686,42.032284,0,0,0,0,100,0),
(@PATH,4,438.85782,198.80098,42.029827,0,0,0,0,100,0),
(@PATH,5,430.3756,197.59511,42.457813,0,0,0,0,100,0),
(@PATH,6,421.60727,192.22081,42.062428,0,0,0,0,100,0),
(@PATH,7,416.0996,181.55664,43.005665,0,0,0,0,100,0),
(@PATH,8,421.60727,192.22081,42.062428,0,0,0,0,100,0),
(@PATH,9,430.3756,197.59511,42.457813,0,0,0,0,100,0),
(@PATH,10,438.85782,198.80098,42.029827,0,0,0,0,100,0),
(@PATH,11,442.92194,206.45686,42.032284,0,0,0,0,100,0),
(@PATH,12,445.96973,214.29796,42.032284,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16822;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=413.21558,`position_y`=193.74141,`position_z`=42.005665 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,413.21558,193.74141,42.005665,0,0,0,0,100,0),
(@PATH,2,390.69757,175.08122,42.005665,0,0,0,0,100,0),
(@PATH,3,375.01358,184.56497,42.005665,0,0,0,0,100,0),
(@PATH,4,358.31284,196.64864,41.98608,0,0,0,0,100,0),
(@PATH,5,331.73557,178.07823,41.97292,0,0,0,0,100,0),
(@PATH,6,301.4229,162.19406,41.222916,0,0,0,0,100,0),
(@PATH,7,285.08328,166.89131,41.325336,0,0,0,0,100,0),
(@PATH,8,301.4229,162.19406,41.222916,0,0,0,0,100,0),
(@PATH,9,331.73557,178.07823,41.97292,0,0,0,0,100,0),
(@PATH,10,358.31284,196.64864,41.98608,0,0,0,0,100,0),
(@PATH,11,375.01358,184.56497,42.005665,0,0,0,0,100,0),
(@PATH,12,390.69757,175.08122,42.005665,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16833;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=369.85248,`position_y`=215.46297,`position_z`=43.210815 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,369.85248,215.46297,43.210815,0,0,0,0,100,0),
(@PATH,2,370.5104,201.7931,42.838013,0,0,0,0,100,0),
(@PATH,3,368.17102,197.34967,42.005665,0,0,0,0,100,0),
(@PATH,4,386.09097,181.66748,42.24956,0,0,0,0,100,0),
(@PATH,5,394.69366,183.41336,42.10149,0,0,0,0,100,0),
(@PATH,6,399.23242,196.64844,42.505665,0,0,0,0,100,0),
(@PATH,7,410.94937,200.65767,42.419678,0,0,0,0,100,0),
(@PATH,8,399.2602,196.70682,42.588306,0,0,0,0,100,0),
(@PATH,9,394.69366,183.41336,42.10149,0,0,0,0,100,0),
(@PATH,10,386.09097,181.66748,42.24956,0,0,0,0,100,0),
(@PATH,11,368.17102,197.34967,42.005665,0,0,0,0,100,0),
(@PATH,12,370.4961,201.77344,42.782593,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16861;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=405.9484,`position_y`=176.40237,`position_z`=42.176197 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,405.9484,176.40237,42.176197,0,0,0,0,100,0),
(@PATH,2,399.39844,165.17969,42.40506,0,0,0,0,100,0),
(@PATH,3,405.64166,155.97098,41.978065,0,0,0,0,100,0),
(@PATH,4,413.95236,150.24208,43.03617,0,0,0,0,100,0),
(@PATH,5,416.63208,157.4262,44.161537,0,0,0,0,100,0),
(@PATH,6,424.63663,152.20564,42.517372,0,0,0,0,100,0),
(@PATH,7,416.63208,157.4262,44.161537,0,0,0,0,100,0),
(@PATH,8,413.95236,150.24208,43.03617,0,0,0,0,100,0),
(@PATH,9,405.64166,155.97098,41.978065,0,0,0,0,100,0),
(@PATH,10,399.4336,165.0586,42.40506,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16866;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=489.96896,`position_y`=178.69768,`position_z`=42.009777 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,489.96896,178.69768,42.009777,0,0,0,0,100,0),
(@PATH,2,478.81827,177.31497,42.009777,0,0,0,0,100,0),
(@PATH,3,469.19028,183.3283,42.009777,0,0,0,0,100,0),
(@PATH,4,464.78775,176.82181,42.029827,0,0,0,0,100,0),
(@PATH,5,457.98486,169.82227,42.029827,0,0,0,0,100,0),
(@PATH,6,443.75522,163.85655,42.029827,0,0,0,0,100,0),
(@PATH,7,432.0342,167.87164,43.951466,0,0,0,0,100,0),
(@PATH,8,443.75522,163.85655,42.029827,0,0,0,0,100,0),
(@PATH,9,457.98486,169.82227,42.029827,0,0,0,0,100,0),
(@PATH,10,464.78775,176.82181,42.029827,0,0,0,0,100,0),
(@PATH,11,469.19028,183.3283,42.009777,0,0,0,0,100,0),
(@PATH,12,478.81827,177.31497,42.009777,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16867;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=375.74506,`position_y`=138.93732,`position_z`=43.73819 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,375.74506,138.93732,43.73819,0,0,0,0,100,0),
(@PATH,2,384.57852,138.20595,42.257965,0,0,0,0,100,0),
(@PATH,3,395.01187,145.93343,42.03006,0,0,0,0,100,0),
(@PATH,4,395.34952,154.75974,42.03006,0,0,0,0,100,0),
(@PATH,5,387.61996,162.37758,42.828766,0,0,0,0,100,0),
(@PATH,6,379.57205,169.81529,43.033253,0,0,0,0,100,0),
(@PATH,7,387.61996,162.37758,42.828766,0,0,0,0,100,0),
(@PATH,8,395.34952,154.75974,42.03006,0,0,0,0,100,0),
(@PATH,9,395.01187,145.93343,42.03006,0,0,0,0,100,0),
(@PATH,10,384.57852,138.20595,42.257965,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16868;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=340.1949,`position_y`=166.84375,`position_z`=41.997066 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,340.1949,166.84375,41.997066,0,0,0,0,100,0),
(@PATH,2,342.1603,156.19038,41.69579,0,0,0,0,100,0),
(@PATH,3,348.47162,156.77486,41.82079,0,0,0,0,100,0),
(@PATH,4,357.39127,151.24327,42.056263,0,0,0,0,100,0),
(@PATH,5,360.59235,143.47827,42.540882,0,0,0,0,100,0),
(@PATH,6,373.25195,137.49023,43.40506,0,0,0,0,100,0),
(@PATH,7,377.6565,137.1068,43.29837,0,0,0,0,100,0),
(@PATH,8,360.59235,143.47827,42.540882,0,0,0,0,100,0),
(@PATH,9,357.39127,151.24327,42.056263,0,0,0,0,100,0),
(@PATH,10,348.47162,156.77486,41.82079,0,0,0,0,100,0),
(@PATH,11,342.1603,156.19038,41.69579,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16871;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=333.7112,`position_y`=203.42975,`position_z`=42.33435 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,333.7112,203.42975,42.33435,0,0,0,0,100,0),
(@PATH,2,339.441,188.31288,42.64526,0,0,0,0,100,0),
(@PATH,3,337.33685,181.02498,41.943233,0,0,0,0,100,0),
(@PATH,4,330.42535,178.01207,41.97292,0,0,0,0,100,0),
(@PATH,5,322.68356,179.4646,42.93056,0,0,0,0,100,0),
(@PATH,6,337.33685,181.02498,41.943233,0,0,0,0,100,0),
(@PATH,7,339.441,188.31288,42.64526,0,0,0,0,100,0),
(@PATH,8,338.03873,196.0626,42.981686,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16874;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=372.52286,`position_y`=176.26959,`position_z`=41.93108 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,372.52286,176.26959,41.93108,0,0,0,0,100,0),
(@PATH,2,371.54044,182.61464,42.005665,0,0,0,0,100,0),
(@PATH,3,364.12964,187.61887,42.353146,0,0,0,0,100,0),
(@PATH,4,355.5789,186.57002,43.44116,0,0,0,0,100,0),
(@PATH,5,348.83218,182.7818,43.26074,0,0,0,0,100,0),
(@PATH,6,339.8955,172.34023,41.98608,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16875;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=325.21506,`position_y`=173.77821,`position_z`=42.175434 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,325.21506,173.77821,42.175434,0,0,0,0,100,0),
(@PATH,2,305.52078,169.19904,41.22292,0,0,0,0,100,0),
(@PATH,3,298.92593,173.57195,41.22292,0,0,0,0,100,0),
(@PATH,4,292.19153,184.06233,42.497944,0,0,0,0,100,0),
(@PATH,5,295.0845,192.17174,43.72292,0,0,0,0,100,0),
(@PATH,6,298.92593,173.57195,41.22292,0,0,0,0,100,0),
(@PATH,7,305.52078,169.19904,41.22292,0,0,0,0,100,0),
(@PATH,8,317.2702,169.4438,41.74367,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16912;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=449.50262,`position_y`=258.38727,`position_z`=43.387814 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,449.50262,258.38727,43.387814,0,0,0,0,100,0),
(@PATH,2,460.91205,276.25998,41.989525,0,0,0,0,100,0),
(@PATH,3,480.51236,270.0413,41.117046,0,0,0,0,100,0),
(@PATH,4,496.2101,254.2387,39.503048,0,0,0,0,100,0),
(@PATH,5,495.50137,238.25519,42.895016,0,0,0,0,100,0),
(@PATH,6,496.2101,254.2387,39.503048,0,0,0,0,100,0),
(@PATH,7,480.51236,270.0413,41.117046,0,0,0,0,100,0),
(@PATH,8,460.91205,276.25998,41.989525,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16916;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=430.82257,`position_y`=222.82896,`position_z`=43.698242 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,430.82257,222.82896,43.698242,0,0,0,0,100,0),
(@PATH,2,441.68484,226.99411,42.269222,0,0,0,0,100,0),
(@PATH,3,439.46988,241.61143,42.91064,0,0,0,0,100,0),
(@PATH,4,434.61566,249.76997,42.481808,0,0,0,0,100,0),
(@PATH,5,427.9342,253.19992,43.45349,0,0,0,0,100,0),
(@PATH,6,417.7162,249.55222,44.33728,0,0,0,0,100,0),
(@PATH,7,407.71582,250.77843,42.14612,0,0,0,0,100,0),
(@PATH,8,405.92178,241.49905,42.303223,0,0,0,0,100,0),
(@PATH,9,407.71582,250.77843,42.14612,0,0,0,0,100,0),
(@PATH,10,417.63867,249.56836,44.407593,0,0,0,0,100,0),
(@PATH,11,427.9342,253.19992,43.45349,0,0,0,0,100,0),
(@PATH,12,434.61566,249.76997,42.481808,0,0,0,0,100,0),
(@PATH,13,439.46988,241.61143,42.91064,0,0,0,0,100,0),
(@PATH,14,441.68484,226.99411,42.269222,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16917;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=502.71646,`position_y`=184.95145,`position_z`=42.0166 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,502.71646,184.95145,42.0166,0,0,0,0,100,0),
(@PATH,2,513.64777,197.89996,42.46692,0,0,0,0,100,0),
(@PATH,3,512.14014,209.73877,42.677616,0,0,0,0,100,0),
(@PATH,4,500.449,223.89293,41.70972,0,0,0,0,100,0),
(@PATH,5,491.08405,224.79799,41.954502,0,0,0,0,100,0),
(@PATH,6,480.86273,214.72803,42.64066,0,0,0,0,100,0),
(@PATH,7,470.45236,227.97385,43.935215,0,0,0,0,100,0),
(@PATH,8,458.7465,220.34518,42.032284,0,0,0,0,100,0),
(@PATH,9,470.45236,227.97385,43.935215,0,0,0,0,100,0),
(@PATH,10,480.86273,214.72803,42.64066,0,0,0,0,100,0),
(@PATH,11,491.08405,224.79799,41.954502,0,0,0,0,100,0),
(@PATH,12,500.449,223.89293,41.70972,0,0,0,0,100,0),
(@PATH,13,512.14014,209.73877,42.677616,0,0,0,0,100,0),
(@PATH,14,513.64777,197.89996,42.46692,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16933;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=162.11003,`position_y`=219.85997,`position_z`=42.1071 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,162.11003,219.85997,42.1071,0,0,0,0,100,0),
(@PATH,2,133.10481,246.77696,43.55792,0,0,0,0,100,0),
(@PATH,3,119.04297,239.1211,42.804012,0,0,0,0,100,0),
(@PATH,4,106.05795,229.01297,43.475227,0,0,0,0,100,0),
(@PATH,5,118.97971,239.07419,42.770687,0,0,0,0,100,0),
(@PATH,6,133.10481,246.77696,43.55792,0,0,0,0,100,0),
(@PATH,7,144.42546,234.14035,41.6922,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16934;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=43.913956,`position_y`=489.94498,`position_z`=43.656384 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,43.913956,489.94498,43.656384,0,0,0,0,100,0),
(@PATH,2,40.223362,499.84973,42.032604,0,0,0,0,100,0),
(@PATH,3,24.70942,497.74307,42.032608,0,0,0,0,100,0),
(@PATH,4,8.855198,485.7876,42.907486,0,0,0,0,100,0),
(@PATH,5,0.242459,471.11752,43.94606,0,0,0,0,100,0),
(@PATH,6,3.750868,448.38028,46.34413,0,0,0,0,100,0),
(@PATH,7,16.084743,441.03223,42.934708,0,0,0,0,100,0),
(@PATH,8,3.750868,448.38028,46.34413,0,0,0,0,100,0),
(@PATH,9,0.242459,471.11752,43.94606,0,0,0,0,100,0),
(@PATH,10,8.855198,485.7876,42.907486,0,0,0,0,100,0),
(@PATH,11,24.70942,497.74307,42.032608,0,0,0,0,100,0),
(@PATH,12,40.223362,499.84973,42.032604,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16937;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=92.18077,`position_y`=441.28363,`position_z`=43.90834 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,92.18077,441.28363,43.90834,0,0,0,0,100,0),
(@PATH,2,110.27539,447.7636,42.032593,0,0,0,0,100,0),
(@PATH,3,107.2525,459.1418,42.032593,0,0,0,0,100,0),
(@PATH,4,94.193794,480.36948,42.032578,0,0,0,0,100,0),
(@PATH,5,81.049805,487.35742,42.032578,0,0,0,0,100,0),
(@PATH,6,66.24447,488.33057,42.032604,0,0,0,0,100,0),
(@PATH,7,81.049805,487.35742,42.032578,0,0,0,0,100,0),
(@PATH,8,94.193794,480.36948,42.032578,0,0,0,0,100,0),
(@PATH,9,107.2525,459.1418,42.032593,0,0,0,0,100,0),
(@PATH,10,110.27539,447.7636,42.032593,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16941;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=45.851887,`position_y`=260.6772,`position_z`=42.01178 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,45.851887,260.6772,42.01178,0,0,0,0,100,0),
(@PATH,2,55.613823,253.44127,42.97003,0,0,0,0,100,0),
(@PATH,3,68.95497,248.45934,42.028526,0,0,0,0,100,0),
(@PATH,4,91.88455,265.8588,41.98812,0,0,0,0,100,0),
(@PATH,5,114.51292,287.0678,42.03256,0,0,0,0,100,0),
(@PATH,6,91.88455,265.8588,41.98812,0,0,0,0,100,0),
(@PATH,7,68.95497,248.45934,42.028526,0,0,0,0,100,0),
(@PATH,8,55.613823,253.44127,42.97003,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16944;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=107.95508,`position_y`=226.70703,`position_z`=42.59095 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,107.95508,226.70703,42.59095,0,0,0,0,100,0),
(@PATH,2,98.18945,210.46606,41.990273,0,0,0,0,100,0),
(@PATH,3,85.4745,214.92093,41.865273,0,0,0,0,100,0),
(@PATH,4,74.814125,230.81676,42.331337,0,0,0,0,100,0),
(@PATH,5,75.99534,241.77504,43.594566,0,0,0,0,100,0),
(@PATH,6,74.814125,230.81676,42.331337,0,0,0,0,100,0),
(@PATH,7,85.4745,214.92093,41.865273,0,0,0,0,100,0),
(@PATH,8,98.18945,210.46606,41.990273,0,0,0,0,100,0),
(@PATH,9,107.36079,218.72241,41.71595,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16945;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=50.429363,`position_y`=273.29193,`position_z`=41.982677 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,50.429363,273.29193,41.982677,0,0,0,0,100,0),
(@PATH,2,52.539173,287.42123,40.982677,0,0,0,0,100,0),
(@PATH,3,66.821724,296.3042,42.04811,0,0,0,0,100,0),
(@PATH,4,78.63075,313.44986,41.84926,0,0,0,0,100,0),
(@PATH,5,91.54785,319.05582,41.998306,0,0,0,0,100,0),
(@PATH,6,101.44151,307.14194,42.077145,0,0,0,0,100,0),
(@PATH,7,91.54785,319.05582,41.998306,0,0,0,0,100,0),
(@PATH,8,78.63075,313.44986,41.84926,0,0,0,0,100,0),
(@PATH,9,66.821724,296.3042,42.04811,0,0,0,0,100,0),
(@PATH,10,52.539173,287.42123,40.982677,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16946;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=48.63867,`position_y`=428.8744,`position_z`=42.02454 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,48.63867,428.8744,42.02454,0,0,0,0,100,0),
(@PATH,2,52.539116,408.23547,42.02454,0,0,0,0,100,0),
(@PATH,3,36.784073,399.0739,42.4022,0,0,0,0,100,0),
(@PATH,4,24.942818,385.85806,43.047443,0,0,0,0,100,0),
(@PATH,5,15.894749,375.23795,44.293415,0,0,0,0,100,0),
(@PATH,6,10.49132,359.00626,44.293415,0,0,0,0,100,0),
(@PATH,7,12.272244,346.90152,43.289143,0,0,0,0,100,0),
(@PATH,8,24.661242,331.41373,43.396313,0,0,0,0,100,0),
(@PATH,9,34.482964,329.74417,43.06464,0,0,0,0,100,0),
(@PATH,10,51.25,334.21234,43.287716,0,0,0,0,100,0),
(@PATH,11,34.482964,329.74417,43.06464,0,0,0,0,100,0),
(@PATH,12,24.661242,331.41373,43.396313,0,0,0,0,100,0),
(@PATH,13,12.272244,346.90152,43.289143,0,0,0,0,100,0),
(@PATH,14,10.49132,359.00626,44.293415,0,0,0,0,100,0),
(@PATH,15,15.894749,375.23795,44.293415,0,0,0,0,100,0),
(@PATH,16,24.942818,385.85806,43.047443,0,0,0,0,100,0),
(@PATH,17,36.784073,399.0739,42.4022,0,0,0,0,100,0),
(@PATH,18,52.539116,408.23547,42.02454,0,0,0,0,100,0),
(@PATH,19,52.539116,408.23547,42.02454,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 16949;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=81.69629,`position_y`=310.9397,`position_z`=41.998306 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,81.69629,310.9397,41.998306,0,0,0,0,100,0),
(@PATH,2,86.88834,319.78522,41.998306,0,0,0,0,100,0),
(@PATH,3,80.995766,329.0309,42.465836,0,0,0,0,100,0),
(@PATH,4,72.35667,338.61774,42.049957,0,0,0,0,100,0),
(@PATH,5,64.88173,344.30884,41.912716,0,0,0,0,100,0),
(@PATH,6,60.521484,352.1836,43.287716,0,0,0,0,100,0),
(@PATH,7,58.459095,359.3466,43.56335,0,0,0,0,100,0),
(@PATH,8,55.770073,365.07413,41.912716,0,0,0,0,100,0),
(@PATH,9,58.972767,368.89725,42.00364,0,0,0,0,100,0),
(@PATH,10,68.03407,377.39062,42.02454,0,0,0,0,100,0),
(@PATH,11,58.972767,368.89725,42.00364,0,0,0,0,100,0),
(@PATH,12,55.770073,365.07413,41.912716,0,0,0,0,100,0),
(@PATH,13,58.459095,359.3466,43.56335,0,0,0,0,100,0),
(@PATH,14,60.503582,352.2002,43.191036,0,0,0,0,100,0),
(@PATH,15,64.88173,344.30884,41.912716,0,0,0,0,100,0),
(@PATH,16,72.35667,338.61774,42.049957,0,0,0,0,100,0),
(@PATH,17,80.995766,329.0309,42.465836,0,0,0,0,100,0),
(@PATH,18,86.88834,319.78522,41.998306,0,0,0,0,100,0);

-- Pathing for Elemental Slave Entry: 2359
SET @NPC := 18031;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=89.6607,`position_y`=437.51794,`position_z`=43.358414 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,89.6607,437.51794,43.358414,0,0,0,0,100,0),
(@PATH,2,95.00532,427.98096,43.68028,0,0,0,0,100,0),
(@PATH,3,94.60048,417.21844,42.393536,0,0,0,0,100,0),
(@PATH,4,90.625,408.6404,42.518536,0,0,0,0,100,0),
(@PATH,5,80.63296,398.3157,43.66491,0,0,0,0,100,0),
(@PATH,6,64.79427,402.60944,42.02454,0,0,0,0,100,0),
(@PATH,7,52.407337,413.6512,42.02454,0,0,0,0,100,0),
(@PATH,8,55.343098,424.24045,42.120853,0,0,0,0,100,0),
(@PATH,9,63.30295,436.75845,42.004433,0,0,0,0,100,0),
(@PATH,10,71.454865,437.71628,42.032608,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_03_06' WHERE sql_rev = '1640803052473980355';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

-- DB update 2022_01_07_01 -> 2022_01_07_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_07_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_07_01 2022_01_07_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641500724802128502'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641500724802128502');

-- Swamp of Sorrow

-- Pathing for Stonard Scout Entry: 861 "incorrect"
SET @NPC := 38923;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10387.552,`position_y`=-2642.2817,`position_z`=22.00936 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10387.552,-2642.2817,22.00936,0,0,0,0,100,0),
(@PATH,2,-10381.763,-2622.669,21.80374,0,0,0,0,100,0),
(@PATH,3,-10386.015,-2591.5498,21.942404,0,0,0,0,100,0),
(@PATH,4,-10419.332,-2563.054,23.35627,0,0,0,0,100,0),
(@PATH,5,-10423.957,-2530.602,25.15484,0,0,0,0,100,0),
(@PATH,6,-10404.192,-2492.4895,33.471153,0,0,0,0,100,0),
(@PATH,7,-10388.918,-2466.7212,40.779305,0,0,0,0,100,0),
(@PATH,8,-10385.449,-2429.8652,51.26205,0,0,0,0,100,0),
(@PATH,9,-10388.918,-2466.7212,40.779305,0,0,0,0,100,0),
(@PATH,10,-10404.192,-2492.4895,33.471153,0,0,0,0,100,0),
(@PATH,11,-10423.957,-2530.602,25.15484,0,0,0,0,100,0),
(@PATH,12,-10419.332,-2563.054,23.35627,0,0,0,0,100,0),
(@PATH,13,-10386.015,-2591.5498,21.942404,0,0,0,0,100,0),
(@PATH,14,-10381.763,-2622.669,21.80374,0,0,0,0,100,0);

-- Pathing for Stonard Scout Entry: 861 "incorrect"
SET @NPC := 37596;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10392.724,`position_y`=-2610.6047,`position_z`=39.98046 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10392.724,-2610.6047,39.98046,0,0,0,0,100,0),
(@PATH,2,-10392.667,-2619.1965,40.532917,0,0,0,0,100,0),
(@PATH,3,-10396.455,-2606.3447,40.295776,0,4000,0,0,100,0);

-- Pathing for Stonard Scout Entry: 861 "incorrect"
SET @NPC := 38885;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10520.517,`position_y`=-3028.345,`position_z`=21.873867 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10520.517,-3028.345,21.873867,0,0,0,0,100,0),
(@PATH,2,-10520.875,-3003.8245,21.61581,0,0,0,0,100,0),
(@PATH,3,-10514.659,-2993.5337,21.592003,0,0,0,0,100,0),
(@PATH,4,-10504.353,-2956.8147,21.761738,0,0,0,0,100,0),
(@PATH,5,-10515.915,-2915.4688,21.80282,0,0,0,0,100,0),
(@PATH,6,-10497.181,-2876.0059,21.680384,0,0,0,0,100,0),
(@PATH,7,-10491.617,-2836.3743,21.749088,0,0,0,0,100,0),
(@PATH,8,-10468.38,-2802.0903,21.748274,0,0,0,0,100,0),
(@PATH,9,-10456.611,-2761.6907,21.802816,0,0,0,0,100,0),
(@PATH,10,-10419.497,-2732.6555,21.802816,0,0,0,0,100,0),
(@PATH,11,-10400.246,-2711.4402,21.802816,0,0,0,0,100,0),
(@PATH,12,-10389.673,-2705.902,21.748835,0,0,0,0,100,0),
(@PATH,13,-10378.284,-2679.8096,21.802816,0,0,0,0,100,0),
(@PATH,14,-10389.673,-2705.902,21.748835,0,0,0,0,100,0),
(@PATH,15,-10400.246,-2711.4402,21.802816,0,0,0,0,100,0),
(@PATH,16,-10419.497,-2732.6555,21.802816,0,0,0,0,100,0),
(@PATH,17,-10456.611,-2761.6907,21.802816,0,0,0,0,100,0),
(@PATH,18,-10468.38,-2802.0903,21.748274,0,0,0,0,100,0),
(@PATH,19,-10491.617,-2836.3743,21.749088,0,0,0,0,100,0),
(@PATH,20,-10497.181,-2876.0059,21.680384,0,0,0,0,100,0),
(@PATH,21,-10515.915,-2915.4688,21.80282,0,0,0,0,100,0),
(@PATH,22,-10504.353,-2956.8147,21.761738,0,0,0,0,100,0),
(@PATH,23,-10514.659,-2993.5337,21.592003,0,0,0,0,100,0),
(@PATH,24,-10520.875,-3003.8245,21.61581,0,0,0,0,100,0);

-- Pathing for Stonard Scout Entry: 861 "incorrect"
SET @NPC := 38668;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10479.312,`position_y`=-3121.1511,`position_z`=20.303179 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10479.312,-3121.1511,20.303179,0,0,0,0,100,0),
(@PATH,2,-10483.729,-3097.8137,20.535868,0,0,0,0,100,0),
(@PATH,3,-10482.677,-3074.4783,20.410868,0,0,0,0,100,0),
(@PATH,4,-10496.356,-3045.3684,20.752298,0,0,0,0,100,0),
(@PATH,5,-10513.836,-3039.9297,21.101698,0,0,0,0,100,0),
(@PATH,6,-10531.488,-3045.6104,22.046766,0,0,0,0,100,0),
(@PATH,7,-10567.993,-3044.8643,26.992815,0,0,0,0,100,0),
(@PATH,8,-10531.488,-3045.6104,22.046766,0,0,0,0,100,0),
(@PATH,9,-10513.836,-3039.9297,21.101698,0,0,0,0,100,0),
(@PATH,10,-10496.356,-3045.3684,20.752298,0,0,0,0,100,0),
(@PATH,11,-10482.677,-3074.4783,20.410868,0,0,0,0,100,0),
(@PATH,12,-10483.729,-3097.8137,20.535868,0,0,0,0,100,0);

-- Pathing for Stonard Scout Entry: 861 "incorrect"
SET @NPC := 38775;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10384.563,`position_y`=-2652.958,`position_z`=21.802816 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10384.563,-2652.958,21.802816,0,0,0,0,100,0),
(@PATH,2,-10390.833,-2694.5784,21.802816,0,0,0,0,100,0),
(@PATH,3,-10424.154,-2726.7063,21.802816,0,0,0,0,100,0),
(@PATH,4,-10455.435,-2764.0127,21.802816,0,0,0,0,100,0),
(@PATH,5,-10470.941,-2797.8276,21.80282,0,0,0,0,100,0),
(@PATH,6,-10495.463,-2835.2825,21.749088,0,0,0,0,100,0),
(@PATH,7,-10500.585,-2876.0498,21.770647,0,0,0,0,100,0),
(@PATH,8,-10514.264,-2897.781,21.770647,0,0,0,0,100,0),
(@PATH,9,-10518.801,-2919.4553,21.80282,0,0,0,0,100,0),
(@PATH,10,-10509.563,-2945.3616,21.761738,0,0,0,0,100,0),
(@PATH,11,-10509.271,-2962.4636,21.761738,0,0,0,0,100,0),
(@PATH,12,-10524.853,-3004.9045,21.798183,0,0,0,0,100,0),
(@PATH,13,-10530.655,-3028.074,21.970547,0,0,0,0,100,0),
(@PATH,14,-10524.853,-3004.9045,21.798183,0,0,0,0,100,0),
(@PATH,15,-10509.271,-2962.4636,21.761738,0,0,0,0,100,0),
(@PATH,16,-10509.563,-2945.3616,21.761738,0,0,0,0,100,0),
(@PATH,17,-10518.801,-2919.4553,21.80282,0,0,0,0,100,0),
(@PATH,18,-10514.264,-2897.781,21.770647,0,0,0,0,100,0),
(@PATH,19,-10500.585,-2876.0498,21.770647,0,0,0,0,100,0),
(@PATH,20,-10495.463,-2835.2825,21.749088,0,0,0,0,100,0),
(@PATH,21,-10470.941,-2797.8276,21.80282,0,0,0,0,100,0),
(@PATH,22,-10455.435,-2764.0127,21.802816,0,0,0,0,100,0),
(@PATH,23,-10424.154,-2726.7063,21.802816,0,0,0,0,100,0),
(@PATH,24,-10390.833,-2694.5784,21.802816,0,0,0,0,100,0);

-- Pathing for Stonard Explorer Entry: 862 "incorrect"
SET @NPC := 37598;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10395.443,`position_y`=-4312.792,`position_z`=22.971727 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10395.443,-4312.792,22.971727,0,0,0,0,100,0),
(@PATH,2,-10361.994,-4336.187,21.837858,0,0,0,0,100,0),
(@PATH,3,-10342.132,-4317.2485,23.375294,0,0,0,0,100,0),
(@PATH,4,-10318.267,-4326.7446,24.003088,0,0,0,0,100,0),
(@PATH,5,-10300.083,-4338.6035,20.14352,0,0,0,0,100,0),
(@PATH,6,-10274.08,-4312.6895,23.730661,0,0,0,0,100,0),
(@PATH,7,-10227.911,-4296.0664,23.556202,0,0,0,0,100,0),
(@PATH,8,-10207.045,-4284.2017,23.3521,0,0,0,0,100,0),
(@PATH,9,-10178.565,-4287.5957,23.33709,0,0,0,0,100,0),
(@PATH,10,-10155.258,-4276.0264,22.963474,0,0,0,0,100,0),
(@PATH,11,-10136.055,-4257.4956,21.95129,0,0,0,0,100,0),
(@PATH,12,-10123.61,-4235.4204,22.915155,0,0,0,0,100,0),
(@PATH,13,-10104.282,-4198.3506,23.436085,0,0,0,0,100,0),
(@PATH,14,-10079.524,-4206.5933,23.925829,0,0,0,0,100,0),
(@PATH,15,-10061.004,-4187.7837,23.484911,0,0,0,0,100,0),
(@PATH,16,-10040.505,-4177.3706,21.802782,0,0,0,0,100,0),
(@PATH,17,-10000.658,-4197.456,22.543242,0,0,0,0,100,0),
(@PATH,18,-9976.06,-4180.6694,22.835203,0,0,0,0,100,0),
(@PATH,19,-9947.604,-4154.994,22.183352,0,0,0,0,100,0),
(@PATH,20,-9932.02,-4132.4062,22.026392,0,0,0,0,100,0),
(@PATH,21,-9914.603,-4123.7007,22.59231,0,0,0,0,100,0),
(@PATH,22,-9905.828,-4134.9766,22.188314,0,0,0,0,100,0),
(@PATH,23,-9883.336,-4130.872,19.13911,0,0,0,0,100,0),
(@PATH,24,-9876.062,-4112.929,20.005322,0,0,0,0,100,0),
(@PATH,25,-9858.903,-4095.7422,21.611328,0,0,0,0,100,0),
(@PATH,26,-9834.923,-4087.511,19.093506,0,0,0,0,100,0),
(@PATH,27,-9833.794,-4066.3398,21.789185,0,0,0,0,100,0),
(@PATH,28,-9806.543,-4037.0518,21.979628,0,0,0,0,100,0),
(@PATH,29,-9770.986,-4021.8252,18.161787,0,0,0,0,100,0),
(@PATH,30,-9758.88,-3982.2495,21.528019,0,0,0,0,100,0),
(@PATH,31,-9736.2,-3947.4504,21.431736,0,0,0,0,100,0),
(@PATH,32,-9758.88,-3982.2495,21.528019,0,0,0,0,100,0),
(@PATH,33,-9770.986,-4021.8252,18.161787,0,0,0,0,100,0),
(@PATH,34,-9806.543,-4037.0518,21.979628,0,0,0,0,100,0),
(@PATH,35,-9833.809,-4066.3496,21.937378,0,0,0,0,100,0),
(@PATH,36,-9834.923,-4087.511,19.093506,0,0,0,0,100,0),
(@PATH,37,-9858.903,-4095.7422,21.611328,0,0,0,0,100,0),
(@PATH,38,-9876.062,-4112.929,20.005322,0,0,0,0,100,0),
(@PATH,39,-9883.336,-4130.872,19.13911,0,0,0,0,100,0),
(@PATH,40,-9905.828,-4134.9766,22.188314,0,0,0,0,100,0),
(@PATH,41,-9914.603,-4123.7007,22.59231,0,0,0,0,100,0),
(@PATH,42,-9932.02,-4132.4062,22.026392,0,0,0,0,100,0),
(@PATH,43,-9947.604,-4154.994,22.183352,0,0,0,0,100,0),
(@PATH,44,-9976.06,-4180.6694,22.835203,0,0,0,0,100,0),
(@PATH,45,-10000.658,-4197.456,22.543242,0,0,0,0,100,0),
(@PATH,46,-10040.505,-4177.3706,21.802782,0,0,0,0,100,0),
(@PATH,47,-10061.004,-4187.7837,23.484911,0,0,0,0,100,0),
(@PATH,48,-10079.524,-4206.5933,23.925829,0,0,0,0,100,0),
(@PATH,49,-10104.282,-4198.3506,23.436085,0,0,0,0,100,0),
(@PATH,50,-10123.61,-4235.4204,22.915155,0,0,0,0,100,0),
(@PATH,51,-10136.055,-4257.4956,21.95129,0,0,0,0,100,0),
(@PATH,52,-10155.258,-4276.0264,22.963474,0,0,0,0,100,0),
(@PATH,53,-10178.566,-4287.6035,23.202324,0,0,0,0,100,0),
(@PATH,54,-10207.045,-4284.2017,23.3521,0,0,0,0,100,0),
(@PATH,55,-10227.911,-4296.0664,23.556202,0,0,0,0,100,0),
(@PATH,56,-10274.041,-4312.623,23.74116,0,0,0,0,100,0),
(@PATH,57,-10300.083,-4338.6035,20.14352,0,0,0,0,100,0),
(@PATH,58,-10318.267,-4326.7446,24.003088,0,0,0,0,100,0),
(@PATH,59,-10342.132,-4317.2485,23.375294,0,0,0,0,100,0),
(@PATH,60,-10361.994,-4336.187,21.837858,0,0,0,0,100,0);

-- Pathing for Stonard Grunt Entry: 866 "incorrect"
SET @NPC := 31848;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10380.126,`position_y`=-3327.8071,`position_z`=22.005377 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10380.126,-3327.8071,22.005377,0,1000,0,0,100,0),
(@PATH,2,-10379.939,-3309.891,22.238775,0,0,0,0,100,0),
(@PATH,3,-10388.469,-3298.0193,20.913956,0,1000,0,0,100,0),
(@PATH,4,-10379.939,-3309.891,22.238775,0,0,0,0,100,0);
-- 0x204494000000D88000001600005464B0 .go xyz -10380.126 -3327.8071 22.005377

-- Pathing for Stonard Grunt Entry: 866 "incorrect"
SET @NPC := 31849;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10453.266,`position_y`=-3173.1318,`position_z`=20.242271 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10453.266,-3173.1318,20.242271,0,0,0,0,100,0),
(@PATH,2,-10427.546,-3173.839,22.349993,0,0,0,0,100,0),
(@PATH,3,-10408.267,-3196.486,22.736956,0,0,0,0,100,0),
(@PATH,4,-10427.546,-3173.839,22.349993,0,0,0,0,100,0);

-- Pathing for Stonard Grunt Entry: 866 "incorrect"
SET @NPC := 31851;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10426.041,`position_y`=-3343.582,`position_z`=22.128275 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10426.041,-3343.582,22.128275,0,1000,0,0,100,0),
(@PATH,2,-10406.933,-3344.7925,22.546244,0,0,0,0,100,0),
(@PATH,3,-10388.769,-3338.1685,22.43016,0,1000,0,0,100,0),
(@PATH,4,-10406.933,-3344.7925,22.546244,0,0,0,0,100,0);

-- Pathing for Stonard Grunt Entry: 866 "incorrect"
SET @NPC := 31852;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10463.11,`position_y`=-3171.425,`position_z`=20.242271 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10463.11,-3171.425,20.242271,0,0,0,0,100,0),
(@PATH,2,-10488.763,-3172.539,20.639118,0,0,0,0,100,0),
(@PATH,3,-10506.145,-3186.9011,22.098927,0,0,0,0,100,0),
(@PATH,4,-10488.763,-3172.539,20.639118,0,0,0,0,100,0);

-- Pathing for Noboru the Cudgel Entry: 5477 "missing"
SET @NPC := 43588;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10174.764,`position_y`=-3505.7986,`position_z`=23.740782 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-10172.764,`position_y`=-3506.7986,`position_z`=23.740782 WHERE `guid`=43589;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-10176.764,`position_y`=-3507.7986,`position_z`=23.740782 WHERE `guid`=43590;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10174.764,-3505.7986,23.740782,0,0,0,0,100,0),
(@PATH,2,-10199.281,-3489.0244,22.896154,0,0,0,0,100,0),
(@PATH,3,-10208.981,-3470.2778,23.36289,0,0,0,0,100,0),
(@PATH,4,-10218.238,-3447.0696,22.507154,0,0,0,0,100,0),
(@PATH,5,-10217.213,-3422.0703,20.874094,0,0,0,0,100,0),
(@PATH,6,-10212.013,-3382.255,23.253244,0,0,0,0,100,0),
(@PATH,7,-10210.794,-3339.0447,24.305006,0,0,0,0,100,0),
(@PATH,8,-10208.208,-3308.2534,22.021559,0,0,0,0,100,0),
(@PATH,9,-10212.185,-3288.9885,20.03131,0,0,0,0,100,0),
(@PATH,10,-10179.041,-3269.541,22.297472,0,0,0,0,100,0),
(@PATH,11,-10151.514,-3240.2913,20.444052,0,0,0,0,100,0),
(@PATH,12,-10135.184,-3221.289,22.110317,0,0,0,0,100,0),
(@PATH,13,-10111.181,-3191.9595,20.995178,0,0,0,0,100,0),
(@PATH,14,-10116.873,-3159.7249,23.361877,0,0,0,0,100,0),
(@PATH,15,-10152.515,-3146.0461,20.628723,0,0,0,0,100,0),
(@PATH,16,-10168.91,-3113.7207,22.326069,0,0,0,0,100,0),
(@PATH,17,-10202.678,-3103.9075,24.04049,0,0,0,0,100,0),
(@PATH,18,-10240.646,-3097.6692,21.989426,0,0,0,0,100,0),
(@PATH,19,-10282.701,-3092.744,23.17424,0,0,0,0,100,0),
(@PATH,20,-10309.505,-3074.6292,23.088953,0,0,0,0,100,0),
(@PATH,21,-10331.981,-3065.2761,23.26966,0,0,0,0,100,0),
(@PATH,22,-10319.258,-3044.5808,22.308235,0,0,0,0,100,0),
(@PATH,23,-10300.271,-3007.03,21.122866,0,0,0,0,100,0),
(@PATH,24,-10294.067,-2991.9336,22.43688,0,0,0,0,100,0),
(@PATH,25,-10272.63,-2989.1868,22.01354,0,0,0,0,100,0),
(@PATH,26,-10239.631,-2988.4785,22.004036,0,0,0,0,100,0),
(@PATH,27,-10219.915,-2974.8098,19.835,0,0,0,0,100,0),
(@PATH,28,-10189.127,-2962.1155,22.09839,0,0,0,0,100,0),
(@PATH,29,-10178.872,-2963.054,23.43799,0,0,0,0,100,0),
(@PATH,30,-10189.127,-2962.1155,22.09839,0,0,0,0,100,0),
(@PATH,31,-10219.915,-2974.8098,19.835,0,0,0,0,100,0),
(@PATH,32,-10239.523,-2988.4827,22.018196,0,0,0,0,100,0),
(@PATH,33,-10272.63,-2989.1868,22.01354,0,0,0,0,100,0),
(@PATH,34,-10294.067,-2991.9336,22.43688,0,0,0,0,100,0),
(@PATH,35,-10300.271,-3007.03,21.122866,0,0,0,0,100,0),
(@PATH,36,-10319.258,-3044.5808,22.308235,0,0,0,0,100,0),
(@PATH,37,-10331.981,-3065.2761,23.26966,0,0,0,0,100,0),
(@PATH,38,-10309.505,-3074.6292,23.088953,0,0,0,0,100,0),
(@PATH,39,-10282.701,-3092.744,23.17424,0,0,0,0,100,0),
(@PATH,40,-10240.646,-3097.6692,21.989426,0,0,0,0,100,0),
(@PATH,41,-10202.678,-3103.9075,24.04049,0,0,0,0,100,0),
(@PATH,42,-10168.91,-3113.7207,22.326069,0,0,0,0,100,0),
(@PATH,43,-10152.515,-3146.0461,20.628723,0,0,0,0,100,0),
(@PATH,44,-10116.873,-3159.7249,23.361877,0,0,0,0,100,0),
(@PATH,45,-10111.181,-3191.9595,20.995178,0,0,0,0,100,0),
(@PATH,46,-10135.184,-3221.289,22.110317,0,0,0,0,100,0),
(@PATH,47,-10151.514,-3240.2913,20.444052,0,0,0,0,100,0),
(@PATH,48,-10179.041,-3269.541,22.297472,0,0,0,0,100,0),
(@PATH,49,-10212.185,-3288.9885,20.03131,0,0,0,0,100,0),
(@PATH,50,-10208.208,-3308.2534,22.021559,0,0,0,0,100,0),
(@PATH,51,-10210.794,-3339.0447,24.305006,0,0,0,0,100,0),
(@PATH,52,-10212.013,-3382.255,23.253244,0,0,0,0,100,0),
(@PATH,53,-10217.236,-3422.0671,20.749582,0,0,0,0,100,0),
(@PATH,54,-10218.262,-3447.0664,22.427809,0,0,0,0,100,0),
(@PATH,55,-10208.981,-3470.2778,23.36289,0,0,0,0,100,0),
(@PATH,56,-10199.281,-3489.0244,22.896154,0,0,0,0,100,0);
-- Formation
DELETE FROM `creature_formations` WHERE `leaderGUID`=43588;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`) VALUES
(43588,43589,2,180,514,0,0),
(43588,43590,2,90,514,0,0),
(43588,43588,0,0,2,0,0);

-- Pathing for Marsh Inkspewer Entry: 750 "missing"
SET @NPC := 43597;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10865.772,`position_y`=-3642.491,`position_z`=13.737023 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10865.772,-3642.491,13.737023,0,0,0,0,100,0),
(@PATH,2,-10886.792,-3645.7874,12.400993,0,0,0,0,100,0),
(@PATH,3,-10900.961,-3652.9993,10.913968,0,0,0,0,100,0),
(@PATH,4,-10914.851,-3660.5513,10.275975,0,0,0,0,100,0),
(@PATH,5,-10912.942,-3676.0881,11.78728,0,0,0,0,100,0),
(@PATH,6,-10896.64,-3687.369,16.984901,0,0,0,0,100,0),
(@PATH,7,-10870.898,-3702.722,22.069647,0,0,0,0,100,0),
(@PATH,8,-10853.066,-3697.5508,22.841703,0,0,0,0,100,0),
(@PATH,9,-10840.168,-3691.0518,22.497534,0,0,0,0,100,0),
(@PATH,10,-10848.666,-3667.3264,20.445873,0,0,0,0,100,0);

-- Pathing for Marsh Inkspewer Entry: 750 "missing"
SET @NPC := 43444;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10925.247,`position_y`=-3615.6436,`position_z`=18.93797 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10925.247,-3615.6436,18.93797,0,0,0,0,100,0),
(@PATH,2,-10944.487,-3610.0886,21.197165,0,0,0,0,100,0),
(@PATH,3,-10951.533,-3615.6406,22.720346,0,0,0,0,100,0),
(@PATH,4,-10951.223,-3635.461,24.396866,0,0,0,0,100,0),
(@PATH,5,-10953.005,-3650.3723,25.49607,0,0,0,0,100,0),
(@PATH,6,-10963.87,-3662.0852,27.828234,0,0,0,0,100,0),
(@PATH,7,-10977.978,-3664.4504,27.488153,0,0,0,0,100,0),
(@PATH,8,-11008.85,-3663.2126,23.37605,0,0,0,0,100,0),
(@PATH,9,-11020.755,-3675.981,22.455765,0,0,0,0,100,0),
(@PATH,10,-11018.961,-3692.529,22.54579,0,0,0,0,100,0),
(@PATH,11,-11012.535,-3700.934,21.316383,0,0,0,0,100,0),
(@PATH,12,-10997.018,-3701.8997,18.178654,0,0,0,0,100,0),
(@PATH,13,-10979.054,-3701.6484,14.303013,0,0,0,0,100,0),
(@PATH,14,-10961.701,-3687.6216,8.558474,0,0,0,0,100,0),
(@PATH,15,-10938.992,-3676.7717,8.55861,0,0,0,0,100,0),
(@PATH,16,-10961.701,-3687.6216,8.558474,0,0,0,0,100,0),
(@PATH,17,-10979.054,-3701.6484,14.303013,0,0,0,0,100,0),
(@PATH,18,-10997.018,-3701.8997,18.178654,0,0,0,0,100,0),
(@PATH,19,-11012.535,-3700.934,21.316383,0,0,0,0,100,0),
(@PATH,20,-11018.961,-3692.529,22.54579,0,0,0,0,100,0),
(@PATH,21,-11020.755,-3675.981,22.455765,0,0,0,0,100,0),
(@PATH,22,-11008.85,-3663.2126,23.37605,0,0,0,0,100,0),
(@PATH,23,-10977.978,-3664.4504,27.488153,0,0,0,0,100,0),
(@PATH,24,-10963.87,-3662.0852,27.828234,0,0,0,0,100,0),
(@PATH,25,-10953.005,-3650.3723,25.49607,0,0,0,0,100,0),
(@PATH,26,-10951.223,-3635.461,24.396866,0,0,0,0,100,0),
(@PATH,27,-10951.533,-3615.6406,22.720346,0,0,0,0,100,0),
(@PATH,28,-10944.487,-3610.0886,21.197165,0,0,0,0,100,0);

-- Pathing for Marsh Inkspewer Entry: 750 "missing"
SET @NPC := 43599;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10951.789,`position_y`=-3703.1372,`position_z`=26.933634 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10951.789,-3703.1372,26.933634,0,0,0,0,100,0),
(@PATH,2,-10948.399,-3723.5603,25.27377,0,0,0,0,100,0),
(@PATH,3,-10932.7,-3747.1467,23.746986,0,0,0,0,100,0),
(@PATH,4,-10911.275,-3746.8276,23.434021,0,0,0,0,100,0),
(@PATH,5,-10875.682,-3729.8118,23.206373,0,0,0,0,100,0),
(@PATH,6,-10864.208,-3730.4502,23.269411,0,0,0,0,100,0),
(@PATH,7,-10836.52,-3741.3923,23.41871,0,0,0,0,100,0),
(@PATH,8,-10807.807,-3738.057,25.887337,0,0,0,0,100,0),
(@PATH,9,-10785.825,-3743.7317,24.383118,0,2000,0,0,100,0),
(@PATH,10,-10807.807,-3738.057,25.887337,0,0,0,0,100,0),
(@PATH,11,-10836.52,-3741.3923,23.41871,0,0,0,0,100,0),
(@PATH,12,-10864.208,-3730.4502,23.269411,0,0,0,0,100,0),
(@PATH,13,-10875.682,-3729.8118,23.206373,0,0,0,0,100,0),
(@PATH,14,-10911.275,-3746.8276,23.434021,0,0,0,0,100,0),
(@PATH,15,-10932.7,-3747.1467,23.746986,0,0,0,0,100,0),
(@PATH,16,-10948.399,-3723.5603,25.27377,0,0,0,0,100,0);

-- Remove a couple overspawns from Stagalbog Cave
DELETE FROM `creature` WHERE `guid` IN (2688,43600);
DELETE FROM `creature_addon` WHERE `guid` IN (2688,43600);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_07_02' WHERE sql_rev = '1641500724802128502';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

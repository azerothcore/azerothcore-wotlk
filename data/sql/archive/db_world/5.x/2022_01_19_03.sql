-- DB update 2022_01_19_02 -> 2022_01_19_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_19_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_19_02 2022_01_19_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642556118096974034'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642556118096974034');

DELETE FROM `creature` WHERE `guid` IN (59386,59478,59479,59480);
INSERT INTO `creature` (`guid`,`id1`,`id2`,`id3`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(59386, 16857, 0, 0, 530, 0, 0, 1, 1, 0, -803.8987, 3132.88, -2.8533463, 4.97418832778930664, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(59478, 16857, 0, 0, 530, 0, 0, 1, 1, 0, -805.9301, 3164.4517, 3.7072277, 4.97418832778930664, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(59479, 16857, 0, 0, 530, 0, 0, 1, 1, 0, 51.90408, 3038.4705, -0.7635418, 4.97418832778930664, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(59480, 16857, 0, 0, 530, 0, 0, 1, 1, 0, 127.03462, 3045.6382, -0.9333534, 4.97418832778930664, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 59386;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-803.8987,3132.88,-2.8533463,0,0,0,0,100,0),
(@PATH,2,-776.51825,3097.9805,-4.005171,0,0,0,0,100,0),
(@PATH,3,-761.1749,3085.1887,5.1967344,0,0,0,0,100,0),
(@PATH,4,-757.834,3065.222,6.5856857,0,0,0,0,100,0),
(@PATH,5,-768.2207,3046.5852,6.030099,0,0,0,0,100,0),
(@PATH,6,-767.1921,3024.281,8.733586,0,0,0,0,100,0),
(@PATH,7,-768.2207,3046.5852,6.030099,0,0,0,0,100,0),
(@PATH,8,-757.834,3065.222,6.5856857,0,0,0,0,100,0),
(@PATH,9,-761.1749,3085.1887,5.1967344,0,0,0,0,100,0),
(@PATH,10,-776.51825,3097.9805,-4.005171,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 59478;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-805.9301,3164.4517,3.7072277,0,0,0,0,100,0),
(@PATH,2,-824.5558,3182.2708,7.1943808,0,0,0,0,100,0),
(@PATH,3,-841.3824,3201.1116,5.511631,0,0,0,0,100,0),
(@PATH,4,-807.4523,3206.1418,13.065578,0,0,0,0,100,0),
(@PATH,5,-836.3227,3199.1047,5.8761125,0,0,0,0,100,0),
(@PATH,6,-864.3863,3193.6436,7.4974504,0,0,0,0,100,0),
(@PATH,7,-849.362,3200.0374,4.5993996,0,0,0,0,100,0),
(@PATH,8,-852.2203,3223.7122,17.504307,0,0,0,0,100,0),
(@PATH,9,-864.3863,3193.6436,7.4974504,0,0,0,0,100,0),
(@PATH,10,-836.3227,3199.1047,5.8761125,0,0,0,0,100,0),
(@PATH,11,-807.4523,3206.1418,13.065578,0,0,0,0,100,0),
(@PATH,12,-841.3824,3201.1116,5.511631,0,0,0,0,100,0),
(@PATH,13,-824.5558,3182.2708,7.1943808,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 59479;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,51.90408,3038.4705,-0.7635418,0,0,0,0,100,0),
(@PATH,2,46.38683,3047.876,-1.0301434,0,0,0,0,100,0),
(@PATH,3,54.412003,3059.2822,-1.0975262,0,0,0,0,100,0),
(@PATH,4,65.4885,3051.529,-1.0975262,0,0,0,0,100,0),
(@PATH,5,76.67166,3052.1858,-1.0975262,0,0,0,0,100,0),
(@PATH,6,86.011826,3048.457,-1.0975262,0,0,0,0,100,0),
(@PATH,7,97.092995,3040.1165,-1.0975262,0,0,0,0,100,0),
(@PATH,8,94.707466,3033.0496,-1.1259686,0,0,0,0,100,0),
(@PATH,9,84.74935,3029.8464,-0.74169123,0,0,0,0,100,0),
(@PATH,10,77.05697,3030.1675,-0.7801434,0,0,0,0,100,0),
(@PATH,11,62.467884,3030.3503,-0.73583186,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 59480;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,127.03462,3045.6382,-0.9333534,0,0,0,0,100,0),
(@PATH,2,141.6441,3045.617,-1.1065221,0,0,0,0,100,0),
(@PATH,3,153.64226,3039.5657,-1.1065221,0,0,0,0,100,0),
(@PATH,4,155.07076,3028.5027,-1.0975262,0,0,0,0,100,0),
(@PATH,5,142.23785,3018.0088,-1.0975262,0,0,0,0,100,0),
(@PATH,6,126.75456,3020.7112,-0.793327,0,0,0,0,100,0),
(@PATH,7,119.83909,3025.372,-0.9547039,0,0,0,0,100,0),
(@PATH,8,110.58485,3026.3918,-1.0140301,0,0,0,0,100,0),
(@PATH,9,105.67578,3041.096,-1.1657753,0,0,0,0,100,0),
(@PATH,10,113.6058,3048.7769,-1.1657753,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58022;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=192.85237,`position_y`=3022.2378,`position_z`=-1.0975183 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,192.85237,3022.2378,-1.0975183,0,0,0,0,100,0),
(@PATH,2,204.33203,3008.6309,-1.0975112,0,0,0,0,100,0),
(@PATH,3,208.16597,2995.8489,-1.0975163,0,0,0,0,100,0),
(@PATH,4,196.1594,2990.8457,-1.0975183,0,0,0,0,100,0),
(@PATH,5,179.60818,2991.3262,-1.0975183,0,0,0,0,100,0),
(@PATH,6,167.56989,2999.4614,-1.0975183,0,0,0,0,100,0),
(@PATH,7,167.1811,3012.4353,-1.0975183,0,0,0,0,100,0),
(@PATH,8,178.722,3023.3906,-1.0975183,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58023;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=276.03235,`position_y`=3018.686,`position_z`=0.63882256 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,276.03235,3018.686,0.63882256,0,0,0,0,100,0),
(@PATH,2,228.85721,3018.9397,-1.0975112,0,0,0,0,100,0),
(@PATH,3,196.05127,3023.8352,-1.0975183,0,0,0,0,100,0),
(@PATH,4,167.0235,3026.5295,-1.0975183,0,0,0,0,100,0),
(@PATH,5,130.55914,3029.5342,-1.0975262,0,0,0,0,100,0),
(@PATH,6,167.0235,3026.5295,-1.0975183,0,0,0,0,100,0),
(@PATH,7,196.05127,3023.8352,-1.0975183,0,0,0,0,100,0),
(@PATH,8,228.85721,3018.9397,-1.0975112,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58024;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=185.77925,`position_y`=3027.3914,`position_z`=-1.0975183 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,185.77925,3027.3914,-1.0975183,0,0,0,0,100,0),
(@PATH,2,173.58192,3026.9211,-1.0975183,0,0,0,0,100,0),
(@PATH,3,161.23541,3034.9539,-1.1065221,0,0,0,0,100,0),
(@PATH,4,161.93338,3048.5703,-1.1065221,0,0,0,0,100,0),
(@PATH,5,176.52707,3058.6416,-0.9980283,0,0,0,0,100,0),
(@PATH,6,194.38716,3059.8787,-0.71067476,0,0,0,0,100,0),
(@PATH,7,202.62929,3049.222,-1.0033951,0,0,0,0,100,0),
(@PATH,8,197.30779,3038.5327,-1.0975156,0,0,0,0,100,0),
(@PATH,9,196.0197,3035.963,-1.0975156,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58025;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-13.282987,`position_y`=3112.1772,`position_z`=-1.0986356 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-13.282987,3112.1772,-1.0986356,0,0,0,0,100,0),
(@PATH,2,-1.649957,3102.8384,-1.0986356,0,0,0,0,100,0),
(@PATH,3,-5.895291,3096.1243,-1.0208749,0,0,0,0,100,0),
(@PATH,4,-14.015625,3088.712,0.45153725,0,0,0,0,100,0),
(@PATH,5,-18.434679,3077.221,0.92687905,0,0,0,0,100,0),
(@PATH,6,-21.041775,3072.4556,0.82653725,0,0,0,0,100,0),
(@PATH,7,-43.407444,3084.627,-1.2337177,0,0,0,0,100,0),
(@PATH,8,-46.677517,3101.8118,-2.2063098,0,0,0,0,100,0),
(@PATH,9,-34.772243,3117.4805,-1.4563098,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58026;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-7.006619,`position_y`=3122.4097,`position_z`=-1.0986356 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-7.006619,3122.4097,-1.0986356,0,0,0,0,100,0),
(@PATH,2,-15.915364,3136.0747,-1.1390536,0,0,0,0,100,0),
(@PATH,3,-14.131077,3149.9219,-1.1390536,0,0,0,0,100,0),
(@PATH,4,5.993381,3151.146,-1.0224485,0,0,0,0,100,0),
(@PATH,5,20.567274,3134.2576,-1.0975218,0,0,0,0,100,0),
(@PATH,6,24.69325,3122.3162,-1.0975221,0,0,0,0,100,0),
(@PATH,7,14.462348,3116.6067,-1.0975221,0,0,0,0,100,0),
(@PATH,8,4.649306,3115.9148,-1.0975221,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58027;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=13.524848,`position_y`=3085.7312,`position_z`=-1.0975211 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,13.524848,3085.7312,-1.0975211,0,0,0,0,100,0),
(@PATH,2,1.925347,3093.8313,-1.0447867,0,0,0,0,100,0),
(@PATH,3,-1.894097,3103.6013,-1.0986356,0,0,0,0,100,0),
(@PATH,4,2.807834,3113.809,-1.0975221,0,0,0,0,100,0),
(@PATH,5,17.173828,3118.1655,-1.0975221,0,0,0,0,100,0),
(@PATH,6,27.732748,3110.741,-1.0975221,0,0,0,0,100,0),
(@PATH,7,38.19705,3102.8555,-1.1846819,0,0,0,0,100,0),
(@PATH,8,40.344402,3089.826,-1.1293093,0,0,0,0,100,0),
(@PATH,9,26.051432,3085.0752,-1.0975211,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58028;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=41.68164,`position_y`=3062.5947,`position_z`=-1.0975262 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,41.68164,3062.5947,-1.0975262,0,0,0,0,100,0),
(@PATH,2,45.9388,3049.6372,-1.2414471,0,0,0,0,100,0),
(@PATH,3,33.271378,3053.746,-0.98609924,0,0,0,0,100,0),
(@PATH,4,21.698242,3055.2751,-1.0990143,0,0,0,0,100,0),
(@PATH,5,11.094727,3052.4692,-1.0827789,0,0,0,0,100,0),
(@PATH,6,6.079102,3063.0078,-1.0990143,0,0,0,0,100,0),
(@PATH,7,4.347548,3074.7388,-1.0975211,0,0,0,0,100,0),
(@PATH,8,7.306641,3082.583,-1.0975211,0,0,0,0,100,0),
(@PATH,9,27.311523,3081.033,-1.0975211,0,0,0,0,100,0),
(@PATH,10,36.355034,3081.246,-1.1293093,0,0,0,0,100,0),
(@PATH,11,39.173286,3073.5203,-1.1293093,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58029;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-748.9632,`position_y`=2931.8418,`position_z`=21.680258 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-748.9632,2931.8418,21.680258,0,0,0,0,100,0),
(@PATH,2,-740.63116,2913.1763,25.161215,0,0,0,0,100,0),
(@PATH,3,-723.25165,2892.0684,32.259914,0,0,0,0,100,0),
(@PATH,4,-714.852,2868.1675,39.47317,0,0,0,0,100,0),
(@PATH,5,-723.25165,2892.0684,32.259914,0,0,0,0,100,0),
(@PATH,6,-740.63116,2913.1763,25.161215,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58030;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-751.03625,`position_y`=3013.1504,`position_z`=11.731231 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-751.03625,3013.1504,11.731231,0,0,0,0,100,0),
(@PATH,2,-786.30646,2980.2532,12.811809,0,0,0,0,100,0),
(@PATH,3,-799.5866,2943.9392,13.014446,0,0,0,0,100,0),
(@PATH,4,-781.30646,2918.138,16.453808,0,0,0,0,100,0),
(@PATH,5,-776.4347,2888.797,20.594124,0,0,0,0,100,0),
(@PATH,6,-781.30646,2918.138,16.453808,0,0,0,0,100,0),
(@PATH,7,-799.5866,2943.9392,13.014446,0,0,0,0,100,0),
(@PATH,8,-786.30646,2980.2532,12.811809,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58031;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-854.46246,`position_y`=2976.1052,`position_z`=9.845428 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-854.46246,2976.1052,9.845428,0,0,0,0,100,0),
(@PATH,2,-854.8802,2949.2563,6.4391885,0,0,0,0,100,0),
(@PATH,3,-851.5339,2923.5403,5.405945,0,0,0,0,100,0),
(@PATH,4,-847.80383,2894.2468,9.257814,0,0,0,0,100,0),
(@PATH,5,-844.946,2868.5957,11.181887,0,0,0,0,100,0),
(@PATH,6,-844.9694,2851.461,13.528069,0,0,0,0,100,0),
(@PATH,7,-830.43445,2830.3015,19.415745,0,0,0,0,100,0),
(@PATH,8,-844.9694,2851.461,13.528069,0,0,0,0,100,0),
(@PATH,9,-844.946,2868.5957,11.181887,0,0,0,0,100,0),
(@PATH,10,-847.80383,2894.2468,9.257814,0,0,0,0,100,0),
(@PATH,11,-851.5339,2923.5403,5.405945,0,0,0,0,100,0),
(@PATH,12,-854.8802,2949.2563,6.4391885,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58032;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-816.41144,`position_y`=2976.2297,`position_z`=8.9055605 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-816.41144,2976.2297,8.9055605,0,0,0,0,100,0),
(@PATH,2,-818.17035,2987.76,2.140912,0,0,0,0,100,0),
(@PATH,3,-817.39343,3002.2954,-4.9119215,0,0,0,0,100,0),
(@PATH,4,-843.3926,3002.3965,6.6546297,0,0,0,0,100,0),
(@PATH,5,-864.35547,3005.6497,7.932706,0,0,0,0,100,0),
(@PATH,6,-881.0536,3017.9297,8.938755,0,0,0,0,100,0),
(@PATH,7,-896.0762,3021.0137,9.981602,0,0,0,0,100,0),
(@PATH,8,-912.061,3033.434,11.262013,0,0,0,0,100,0),
(@PATH,9,-935.7355,3039.9526,13.517764,0,0,0,0,100,0),
(@PATH,10,-912.061,3033.434,11.262013,0,0,0,0,100,0),
(@PATH,11,-896.0762,3021.0137,9.981602,0,0,0,0,100,0),
(@PATH,12,-881.0536,3017.9297,8.938755,0,0,0,0,100,0),
(@PATH,13,-864.35547,3005.6497,7.932706,0,0,0,0,100,0),
(@PATH,14,-843.42926,3002.4036,6.7271395,0,0,0,0,100,0),
(@PATH,15,-817.4297,3002.3018,-5.0354567,0,0,0,0,100,0),
(@PATH,16,-818.17035,2987.76,2.140912,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58033;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-845.8616,`position_y`=3200.3386,`position_z`=4.707798 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-845.8616,3200.3386,4.707798,0,0,0,0,100,0),
(@PATH,2,-822.65906,3181.8308,7.26628,0,0,0,0,100,0),
(@PATH,3,-804.9475,3165.4192,3.7021008,0,0,0,0,100,0),
(@PATH,4,-794.26495,3145.3481,-6.134981,0,0,0,0,100,0),
(@PATH,5,-791.7342,3118.8325,-9.778892,0,0,0,0,100,0),
(@PATH,6,-791.5488,3096.6562,-7.692793,0,0,0,0,100,0),
(@PATH,7,-791.7342,3118.8325,-9.778892,0,0,0,0,100,0),
(@PATH,8,-794.26495,3145.3481,-6.134981,0,0,0,0,100,0),
(@PATH,9,-804.9475,3165.4192,3.7021008,0,0,0,0,100,0),
(@PATH,10,-822.65906,3181.8308,7.26628,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58034;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-888.85724,`position_y`=3237.8125,`position_z`=31.59423 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-888.85724,3237.8125,31.59423,0,0,0,0,100,0),
(@PATH,2,-860.13367,3248.4133,28.347353,0,0,0,0,100,0),
(@PATH,3,-819.70337,3247.4456,25.205738,0,0,0,0,100,0),
(@PATH,4,-799.3147,3240.7708,23.272297,0,0,0,0,100,0),
(@PATH,5,-784.34503,3210.9001,15.29162,0,0,0,0,100,0),
(@PATH,6,-789.0074,3187.458,10.574884,0,0,0,0,100,0),
(@PATH,7,-784.34503,3210.9001,15.29162,0,0,0,0,100,0),
(@PATH,8,-799.3147,3240.7708,23.272297,0,0,0,0,100,0),
(@PATH,9,-819.70337,3247.4456,25.205738,0,0,0,0,100,0),
(@PATH,10,-860.13367,3248.4133,28.347353,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58035;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-830.4227,`position_y`=3154.5537,`position_z`=10.20796 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-830.4227,3154.5537,10.20796,0,0,0,0,100,0),
(@PATH,2,-839.52997,3120.3345,9.37639,0,0,0,0,100,0),
(@PATH,3,-824.66583,3085.7993,9.210888,0,0,0,0,100,0),
(@PATH,4,-846.4464,3065.0308,10.924051,0,0,0,0,100,0),
(@PATH,5,-846.4464,3065.0308,10.924051,0,0,0,0,100,0),
(@PATH,6,-856.6875,3026.108,11.27963,0,0,0,0,100,0),
(@PATH,7,-846.4464,3065.0308,10.924051,0,0,0,0,100,0),
(@PATH,8,-824.66583,3085.7993,9.210888,0,0,0,0,100,0),
(@PATH,9,-839.52997,3120.3345,9.37639,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58036;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-720.653,`position_y`=3194.1377,`position_z`=-12.910929 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-720.653,3194.1377,-12.910929,0,0,0,0,100,0),
(@PATH,2,-730.82336,3169.2031,-22.27543,0,0,0,0,100,0),
(@PATH,3,-759.4622,3156.0364,-12.943293,0,0,0,0,100,0),
(@PATH,4,-785.2546,3139.3508,-11.054903,0,0,0,0,100,0),
(@PATH,5,-794.1643,3103.7324,-8.499106,0,0,0,0,100,0),
(@PATH,6,-793.31335,3089.9504,-3.665205,0,0,0,0,100,0),
(@PATH,7,-799.7832,3055.2058,3.9219446,0,0,0,0,100,0),
(@PATH,8,-793.31335,3089.9504,-3.665205,0,0,0,0,100,0),
(@PATH,9,-794.1643,3103.7324,-8.499106,0,0,0,0,100,0),
(@PATH,10,-785.2546,3139.3508,-11.054903,0,0,0,0,100,0),
(@PATH,11,-759.4622,3156.0364,-12.943293,0,0,0,0,100,0),
(@PATH,12,-730.82336,3169.2031,-22.27543,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58037;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-692.87775,`position_y`=3057.7056,`position_z`=6.947967 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-692.87775,3057.7056,6.947967,0,0,0,0,100,0),
(@PATH,2,-703.26855,3076.4783,2.6308844,0,0,0,0,100,0),
(@PATH,3,-704.8348,3103.882,-1.5758705,0,0,0,0,100,0),
(@PATH,4,-690.5576,3126.0674,-4.003143,0,0,0,0,100,0),
(@PATH,5,-691.0191,3154.8723,-6.6994514,0,0,0,0,100,0),
(@PATH,6,-697.52454,3169.6262,-18.867704,0,0,0,0,100,0),
(@PATH,7,-720.52216,3195.386,-12.327433,0,0,0,0,100,0),
(@PATH,8,-740.6632,3210.996,3.8330088,0,0,0,0,100,0),
(@PATH,9,-720.52216,3195.386,-12.327433,0,0,0,0,100,0),
(@PATH,10,-697.52454,3169.6262,-18.867704,0,0,0,0,100,0),
(@PATH,11,-691.05664,3154.9854,-6.603504,0,0,0,0,100,0),
(@PATH,12,-690.5576,3126.0674,-4.003143,0,0,0,0,100,0),
(@PATH,13,-704.8348,3103.882,-1.5758705,0,0,0,0,100,0),
(@PATH,14,-703.26855,3076.4783,2.6308844,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58038;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-740.9754,`position_y`=3071.413,`position_z`=5.884967 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-740.9754,3071.413,5.884967,0,0,0,0,100,0),
(@PATH,2,-733.5148,3095.2664,3.1070125,0,0,0,0,100,0),
(@PATH,3,-706.63855,3107.9705,-2.8036537,0,0,0,0,100,0),
(@PATH,4,-679.57605,3124.388,-2.889007,0,0,0,0,100,0),
(@PATH,5,-669.2669,3142.6929,-4.353504,0,0,0,0,100,0),
(@PATH,6,-643.35364,3151.2356,-3.01508,0,0,0,0,100,0),
(@PATH,7,-669.2669,3142.6929,-4.353504,0,0,0,0,100,0),
(@PATH,8,-679.5625,3124.4004,-2.8999934,0,0,0,0,100,0),
(@PATH,9,-706.63855,3107.9705,-2.8036537,0,0,0,0,100,0),
(@PATH,10,-733.5148,3095.2664,3.1070125,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58039;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-647.50867,`position_y`=3117.2427,`position_z`=-1.3314972 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-647.50867,3117.2427,-1.3314972,0,0,0,0,100,0),
(@PATH,2,-675.523,3089.5637,1.8247509,0,0,0,0,100,0),
(@PATH,3,-702.21136,3073.3235,3.2614996,0,0,0,0,100,0),
(@PATH,4,-723.52734,3046.8271,7.7990284,0,0,0,0,100,0),
(@PATH,5,-731.89453,3020.7065,12.339237,0,0,0,0,100,0),
(@PATH,6,-750.08215,2997.5442,14.89899,0,0,0,0,100,0),
(@PATH,7,-760.3774,2960.988,17.665518,0,0,0,0,100,0),
(@PATH,8,-750.08215,2997.5442,14.89899,0,0,0,0,100,0),
(@PATH,9,-731.89453,3020.7065,12.339237,0,0,0,0,100,0),
(@PATH,10,-723.5841,3046.7156,7.7121143,0,0,0,0,100,0),
(@PATH,11,-702.2676,3073.212,3.281275,0,0,0,0,100,0),
(@PATH,12,-675.523,3089.5637,1.8247509,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58040;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-782.186,`position_y`=3104.1667,`position_z`=-9.736777 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-782.186,3104.1667,-9.736777,0,0,0,0,100,0),
(@PATH,2,-780.63214,3132.4678,-14.025229,0,0,0,0,100,0),
(@PATH,3,-766.88995,3146.794,-13.314058,0,0,0,0,100,0),
(@PATH,4,-734.6257,3163.39,-21.273127,0,0,0,0,100,0),
(@PATH,5,-723.8224,3181.0315,-19.071573,0,0,0,0,100,0),
(@PATH,6,-682.70044,3186.1191,-17.990019,0,0,0,0,100,0),
(@PATH,7,-659.18774,3188.6113,-14.771339,0,0,0,0,100,0),
(@PATH,8,-682.70044,3186.1191,-17.990019,0,0,0,0,100,0),
(@PATH,9,-723.8224,3181.0315,-19.071573,0,0,0,0,100,0),
(@PATH,10,-734.6257,3163.39,-21.273127,0,0,0,0,100,0),
(@PATH,11,-766.88995,3146.794,-13.314058,0,0,0,0,100,0),
(@PATH,12,-780.63214,3132.4678,-14.025229,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58041;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-801.1113,`position_y`=3133.4438,`position_z`=-4.021288 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-801.1113,3133.4438,-4.021288,0,0,0,0,100,0),
(@PATH,2,-774.5831,3143.6953,-13.6495075,0,0,0,0,100,0),
(@PATH,3,-759.56665,3156.8235,-13.132257,0,0,0,0,100,0),
(@PATH,4,-735.45734,3168.6409,-21.609797,0,0,0,0,100,0),
(@PATH,5,-716.1632,3182.4358,-19.271036,0,0,0,0,100,0),
(@PATH,6,-703.68567,3198.3782,-11.923136,0,0,0,0,100,0),
(@PATH,7,-679.9005,3196.747,-13.012846,0,0,0,0,100,0),
(@PATH,8,-703.68567,3198.3782,-11.923136,0,0,0,0,100,0),
(@PATH,9,-716.1632,3182.4358,-19.271036,0,0,0,0,100,0),
(@PATH,10,-735.45734,3168.6409,-21.609797,0,0,0,0,100,0),
(@PATH,11,-759.56665,3156.8235,-13.132257,0,0,0,0,100,0),
(@PATH,12,-774.5831,3143.6953,-13.6495075,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58042;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-785.35114,`position_y`=3100.6797,`position_z`=-10.155723 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-785.35114,3100.6797,-10.155723,0,0,0,0,100,0),
(@PATH,2,-801.56036,3062.0505,4.701668,0,0,0,0,100,0),
(@PATH,3,-813.301,3027.3035,-5.451106,0,0,0,0,100,0),
(@PATH,4,-838.2031,3010.6045,7.9046297,0,0,0,0,100,0),
(@PATH,5,-846.1747,2991.1667,9.231781,0,0,0,0,100,0),
(@PATH,6,-849.01953,2960.288,8.462381,0,0,0,0,100,0),
(@PATH,7,-856.86456,2935.8176,5.189921,0,0,0,0,100,0),
(@PATH,8,-849.0013,2960.1987,8.326639,0,0,0,0,100,0),
(@PATH,9,-846.15625,2991.0781,9.150238,0,0,0,0,100,0),
(@PATH,10,-838.3045,3010.5376,7.9793367,0,0,0,0,100,0),
(@PATH,11,-813.301,3027.3035,-5.451106,0,0,0,0,100,0),
(@PATH,12,-801.56036,3062.0505,4.701668,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58043;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-782.26605,`position_y`=2985.408,`position_z`=12.923869 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-782.26605,2985.408,12.923869,0,0,0,0,100,0),
(@PATH,2,-761.17017,3005.5383,13.178863,0,0,0,0,100,0),
(@PATH,3,-753.77594,3027.9077,10.897246,0,0,0,0,100,0),
(@PATH,4,-745.1748,3055.842,7.605461,0,0,0,0,100,0),
(@PATH,5,-745.3524,3083.675,5.66817,0,0,0,0,100,0),
(@PATH,6,-750.8376,3110.3298,5.1056724,0,0,0,0,100,0),
(@PATH,7,-745.3524,3083.675,5.66817,0,0,0,0,100,0),
(@PATH,8,-745.1748,3055.842,7.605461,0,0,0,0,100,0),
(@PATH,9,-753.77594,3027.9077,10.897246,0,0,0,0,100,0),
(@PATH,10,-761.17017,3005.5383,13.178863,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58044;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-754.8075,`position_y`=2948.5227,`position_z`=19.52294 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-754.8075,2948.5227,19.52294,0,0,0,0,100,0),
(@PATH,2,-728.4604,2984.1074,19.474998,0,0,0,0,100,0),
(@PATH,3,-716.0385,3018.404,13.779667,0,0,0,0,100,0),
(@PATH,4,-699.6328,3043.5117,9.129852,0,0,0,0,100,0),
(@PATH,5,-681.57684,3079.8406,3.116499,0,0,0,0,100,0),
(@PATH,6,-699.6145,3043.566,9.089325,0,0,0,0,100,0),
(@PATH,7,-716.0385,3018.404,13.779667,0,0,0,0,100,0),
(@PATH,8,-728.4604,2984.1074,19.474998,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58045;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-778.1738,`position_y`=3102.535,`position_z`=-6.4682226 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-778.1738,3102.535,-6.4682226,0,0,0,0,100,0),
(@PATH,2,-760.0304,3082.9473,5.8756895,0,0,0,0,100,0),
(@PATH,3,-756.2166,3057.9407,8.106682,0,0,0,0,100,0),
(@PATH,4,-768.571,3043.0266,6.538644,0,0,0,0,100,0),
(@PATH,5,-788.6688,3037.5278,6.238961,0,0,0,0,100,0),
(@PATH,6,-824.33136,3029.2666,-0.5818434,0,0,0,0,100,0),
(@PATH,7,-841.7409,3036.7107,8.249735,0,0,0,0,100,0),
(@PATH,8,-853.4768,3041.3022,9.307352,0,0,0,0,100,0),
(@PATH,9,-883.45984,3034.2292,10.644545,0,0,0,0,100,0),
(@PATH,10,-853.4768,3041.3022,9.307352,0,0,0,0,100,0),
(@PATH,11,-841.7409,3036.7107,8.249735,0,0,0,0,100,0),
(@PATH,12,-824.33136,3029.2666,-0.5818434,0,0,0,0,100,0),
(@PATH,13,-788.6688,3037.5278,6.238961,0,0,0,0,100,0),
(@PATH,14,-768.571,3043.0266,6.538644,0,0,0,0,100,0),
(@PATH,15,-756.2166,3057.9407,8.106682,0,0,0,0,100,0),
(@PATH,16,-760.0304,3082.9473,5.8756895,0,0,0,0,100,0);

-- Pathing for Marauding Crust Burster Entry: 16857
SET @NPC := 58046;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-870.0354,`position_y`=3111.6807,`position_z`=13.332392 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-870.0354,3111.6807,13.332392,0,0,0,0,100,0),
(@PATH,2,-873.1339,3080.9219,13.012137,0,0,0,0,100,0),
(@PATH,3,-872.18555,3056.309,12.9516735,0,0,0,0,100,0),
(@PATH,4,-855.20575,3017.4294,10.995694,0,0,0,0,100,0),
(@PATH,5,-862.00415,2983.2522,10.202972,0,0,0,0,100,0),
(@PATH,6,-875.1893,2952.0815,9.087381,0,0,0,0,100,0),
(@PATH,7,-862.00415,2983.2522,10.202972,0,0,0,0,100,0),
(@PATH,8,-855.20575,3017.4294,10.995694,0,0,0,0,100,0),
(@PATH,9,-872.18555,3056.309,12.9516735,0,0,0,0,100,0),
(@PATH,10,-873.1339,3080.9219,13.012137,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_19_03' WHERE sql_rev = '1642556118096974034';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

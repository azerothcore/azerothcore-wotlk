-- DB update 2022_02_18_05 -> 2022_02_18_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_18_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_18_05 2022_02_18_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645221497531808185'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645221497531808185');

-- Fix Gan'arg Sapper, Maiden of Pain, Z'kral, and Urga'zz spawns, Hellfire Peninsula

-- Honor Hold Mine
-- Respawn with type2 positions and new spawns 67464, 67973, 67974
DELETE FROM `creature` WHERE `guid` IN (81712,67464,69297,69298,67208,67209,67210,67211,67212,67213,67214,67215,67216,67217,67218,67219,67220,67221,67222,67223,67224,67225,67973,67974);
DELETE FROM `creature_addon` WHERE `guid` IN (81712,67464,69297,69298,67208,67209,67210,67211,67212,67213,67214,67215,67216,67217,67218,67219,67220,67221,67222,67223,67224,67225,67973,67974);
INSERT INTO `creature` (`guid`,`id1`,`id2`,`id3`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(81712, 18974, 0, 0, 530, 0, 0, 1, 1, 0, -637.22186, 2636.504, -3.0604658, 2.164208173751831054, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(67464, 19408, 0, 0, 530, 0, 0, 1, 1, 0, -671.4884, 2679.1663, -7.7117853, 1.622856378555297851, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(69297, 19408, 0, 0, 530, 0, 0, 1, 1, 0, -667.5924, 2822.2854, 48.804832, 1.460894942283630371, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(69298, 19408, 0, 0, 530, 0, 0, 1, 1, 0, -720.61395, 2747.189, 35.76355, 3.527124643325805664, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67208, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -734.5546, 2747.1692, 36.32672, 2.49582076072692871, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67209, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -671.75977, 2759.7869, 41.210808, 0.349065840244293212, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67210, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -688.07794, 2760.7454, 45.292763, 2.652900457382202148, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67211, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -679.37067, 2782.457, 43.17484, 2.792526721954345703, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67212, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -671.8215, 2817.2178, 47.803173, 2.443460941314697265, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67213, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -666.03345, 2802.3901, 45.887527, 6.091198921203613281, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67214, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -714.00836, 2717.8235, 34.37148, 5.305800914764404296, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67215, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -680.6395, 2655.7378, 1.3530644, 3.752457857131958007, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67216, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -664.6757, 2638.78, 1.2917644, 4.747295379638671875, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67217, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -741.7749, 2745.8176, 19.605059, 3.700098037719726562, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67218, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -702.92053, 2745.4878, 36.81597, 3.054326057434082031, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67219, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -689.6154, 2721.6033, 7.0773125, 6.0737457275390625, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67220, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -668.41223, 2681.3452, -7.3432574, 0.977384388446807861, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67221, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -751.7427, 2727.752, 23.108004, 1.65806281566619873, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67222, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -692.9867, 2697.3528, 3.8066442, 3.351032257080078125, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67223, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -719.3816, 2750.3003, 16.448572, 1.2042771577835083, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67224, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -627.35645, 2632.8906, -2.1608508, 6.056292533874511718, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67225, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -623.61053, 2664.1177, -4.2476435, 0.418879032135009765, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67973, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -648.3387, 2669.0166, -0.8865627, 4.363323211669921875, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67974, 18827, 0, 0, 530, 0, 0, 1, 1, 1, -654.32025, 2689.2239, -0.32843265, 0.942477762699127197, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);

-- Pathing for Maiden of Pain Entry: 19408 proper spawn
SET @NPC := 67464;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-671.5385,`position_y`=2680.128,`position_z`=-7.907692 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-671.5385,2680.128,-7.907692,0,0,0,0,100,0),
(@PATH,2,-643.43524,2646.783,-2.9723997,0,0,0,0,100,0),
(@PATH,3,-634.0244,2658.2874,-2.2484586,0,0,0,0,100,0),
(@PATH,4,-647.5993,2678.5205,-0.44719937,0,0,0,0,100,0),
(@PATH,5,-665.4527,2696.0864,0.16602075,0,0,0,0,100,0),
(@PATH,6,-685.63525,2697.5664,1.780336,0,0,0,0,100,0),
(@PATH,7,-690.76624,2682.0635,2.3327248,0,0,0,0,100,0),
(@PATH,8,-681.64014,2662.78,1.2924887,0,0,0,0,100,0),
(@PATH,9,-663.94244,2643.5894,0.79706633,0,0,0,0,100,0),
(@PATH,10,-644.3442,2645.5024,-3.189935,0,0,0,0,100,0);

-- Pathing for Maiden of Pain Entry: 19408 proper spawn
SET @NPC := 69297;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-667.18896,`position_y`=2825.9414,`position_z`=49.58473 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-667.18896,2825.9414,49.58473,0,0,0,0,100,0),
(@PATH,2,-672.56415,2793.744,44.543205,0,0,0,0,100,0),
(@PATH,3,-676.0389,2769.0996,41.397633,0,0,0,0,100,0),
(@PATH,4,-674.08185,2751.6963,40.383987,0,0,0,0,100,0),
(@PATH,5,-704.8257,2735.9297,33.721233,0,0,0,0,100,0),
(@PATH,6,-726.8668,2746.2554,35.987698,0,0,0,0,100,0),
(@PATH,7,-704.8257,2735.9297,33.721233,0,0,0,0,100,0),
(@PATH,8,-674.08185,2751.6963,40.383987,0,0,0,0,100,0),
(@PATH,9,-676.0389,2769.0996,41.397633,0,0,0,0,100,0),
(@PATH,10,-672.56415,2793.744,44.543205,0,0,0,0,100,0);

-- Pathing for Maiden of Pain Entry: 19408
SET @NPC := 69298;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-721.7341,2746.7344,35.74085,0,0,0,0,100,0),
(@PATH,2,-716.77747,2724.9724,33.474903,0,0,0,0,100,0),
(@PATH,3,-735.48444,2715.2988,27.953459,0,0,0,0,100,0),
(@PATH,4,-745.69324,2734.8064,21.54924,0,0,0,0,100,0),
(@PATH,5,-728.327,2747.2878,16.551306,0,0,0,0,100,0),
(@PATH,6,-704.89606,2729.565,12.283419,0,0,0,0,100,0),
(@PATH,7,-684.9554,2699.9219,1.9530281,0,0,0,0,100,0),
(@PATH,8,-704.89606,2729.565,12.283419,0,0,0,0,100,0),
(@PATH,9,-728.327,2747.2878,16.551306,0,0,0,0,100,0),
(@PATH,10,-745.69324,2734.8064,21.54924,0,0,0,0,100,0),
(@PATH,11,-735.48444,2715.2988,27.953459,0,0,0,0,100,0),
(@PATH,12,-716.77747,2724.9724,33.474903,0,0,0,0,100,0);

-- Thrallmar Mine
-- Respawn with type2 positions and new spawn 67975
DELETE FROM `creature` WHERE `guid` IN (68186,69294,69295,69296,67188,67189,67190,67191,67192,67193,67194,67195,67196,67197,67198,67199,67200,67201,67202,67203,67204,67205,67206,67207,67975);
DELETE FROM `creature_addon` WHERE `guid` IN (68186,69294,69295,69296,67188,67189,67190,67191,67192,67193,67194,67195,67196,67197,67198,67199,67200,67201,67202,67203,67204,67205,67206,67207,67975);
INSERT INTO `creature` (`guid`,`id1`,`id2`,`id3`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(68186, 18976, 0, 0, 530, 0, 0, 1, 1, 0, 407.1935, 2729.8281, 51.956497, 3.003158092498779296, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(69294, 19408, 0, 0, 530, 0, 0, 1, 1, 0, 396.05914, 2853.1338, 54.386784, 1.926535964012145996, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(69295, 19408, 0, 0, 530, 0, 0, 1, 1, 0, 447.0613, 2761.9893, 51.406292, 2.41000223159790039, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(69296, 19408, 0, 0, 530, 0, 0, 1, 1, 0, 393.7551, 2726.3276, 52.323494, 0.439483702182769775, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(67188, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 388.82498, 2801.5574, 54.332893, 2.321287870407104492, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67189, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 394.2958, 2817.3123, 52.559566, 3.996803998947143554, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67190, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 386.60916, 2784.0933, 52.710342, 2.076941728591918945, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67191, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 387.33300, 2720.7300, 50.806400, 3.874630000000000000, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67192, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 388.35900, 2732.2800, 51.575900, 6.161010000000000000, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67193, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 394.83978, 2849.7808, 53.97513, 2.862339973449707031, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67194, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 400.4861, 2823.2322, 53.255276, 1.361356854438781738, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67195, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 408.0771, 2807.5552, 52.92135, 0.383972436189651489, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67196, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 418.1414, 2815.8508, 51.840122, 4.764749050140380859, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67197, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 439.0482, 2826.2278, 52.172783, 4.625122547149658203, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67198, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 427.66812, 2838.6091, 52.295826, 1.343903541564941406, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67199, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 449.51212, 2802.8267, 53.53486, 3.577924966812133789, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 0),
(67200, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 409.74902, 2760.284, 53.65116, 4.188790321350097656, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67201, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 431.3304, 2793.0137, 58.131016, 2.373647689819335937, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67202, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 426.1554, 2766.591, 57.16282, 4.886921882629394531, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67203, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 449.05078, 2778.3547, 52.003887, 0.05235987901687622, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67204, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 439.55777, 2768.7258, 52.984077, 3.944444179534912109, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67205, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 397.76422, 2755.949, 54.011005, 6.003932476043701171, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67206, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 451.49985, 2756.05, 50.16976, 5.8817596435546875, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67207, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 412.06186, 2731.9219, 51.56407, 0.558505356311798095, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(67975, 18827, 0, 0, 530, 0, 0, 1, 1, 1, 410.01117, 2838.0503, 52.243996, 5.445427417755126953, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(67199,0,0,0,1,0,0, ''); -- This npc does random movement with no emote

-- Pathing for Maiden of Pain Entry: 19408
SET @NPC := 69294;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,395.50754,2854.6184,54.555614,0,0,0,0,100,0),
(@PATH,2,404.64545,2839.9773,51.95075,0,0,0,0,100,0),
(@PATH,3,419.57178,2842.1301,52.714176,0,0,0,0,100,0),
(@PATH,4,430.4977,2830.9905,52.38746,0,0,0,0,100,0),
(@PATH,5,423.79428,2819.3582,51.900425,0,0,0,0,100,0),
(@PATH,6,405.13687,2818.5374,53.201782,0,0,0,0,100,0),
(@PATH,7,423.77515,2819.3435,51.896175,0,0,0,0,100,0),
(@PATH,8,430.4977,2830.9905,52.38746,0,0,0,0,100,0),
(@PATH,9,419.57178,2842.1301,52.714176,0,0,0,0,100,0),
(@PATH,10,404.64545,2839.9773,51.95075,0,0,0,0,100,0);

-- Pathing for Maiden of Pain Entry: 19408
SET @NPC := 69295;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,446.75922,2762.054,51.326275,0,0,0,0,100,0),
(@PATH,2,443.58224,2774.6204,52.052395,0,0,0,0,100,0),
(@PATH,3,444.39645,2798.6777,52.791733,0,0,0,0,100,0),
(@PATH,4,429.68002,2777.0754,57.334812,0,0,0,0,100,0),
(@PATH,5,415.09268,2763.2527,53.829445,0,0,0,0,100,0),
(@PATH,6,394.0157,2768.3528,52.393276,0,0,0,0,100,0),
(@PATH,7,415.09268,2763.2527,53.829445,0,0,0,0,100,0),
(@PATH,8,429.68002,2777.0754,57.334812,0,0,0,0,100,0),
(@PATH,9,444.401,2798.8125,52.791637,0,0,0,0,100,0),
(@PATH,10,443.58224,2774.6204,52.052395,0,0,0,0,100,0);

-- Pathing for Maiden of Pain Entry: 19408
SET @NPC := 69296;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,394.41043,2726.6357,52.38723,0,0,0,0,100,0),
(@PATH,2,391.05316,2740.5127,52.231533,0,0,0,0,100,0),
(@PATH,3,396.29797,2763.9998,53.230976,0,0,0,0,100,0),
(@PATH,4,389.11417,2789.9666,53.18183,0,0,0,0,100,0),
(@PATH,5,393.45975,2799.82,53.50179,0,0,0,0,100,0),
(@PATH,6,401.9381,2803.7493,53.51102,0,0,0,0,100,0),
(@PATH,7,409.03458,2820.124,52.55848,0,0,0,0,100,0),
(@PATH,8,401.9381,2803.7493,53.51102,0,0,0,0,100,0),
(@PATH,9,393.52475,2799.9675,53.499653,0,0,0,0,100,0),
(@PATH,10,389.11417,2789.9666,53.18183,0,0,0,0,100,0),
(@PATH,11,396.29797,2763.9998,53.230976,0,0,0,0,100,0),
(@PATH,12,391.05316,2740.5127,52.231533,0,0,0,0,100,0);

-- Pathing for Urga'zz Entry: 18976
SET @NPC := 68186;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,401.9732,2730.862,51.936386,0,0,0,0,100,0),
(@PATH,2,401.9732,2730.862,51.936386,3.141592741012573242,20000,0,0,100,0),
(@PATH,3,394.05624,2730.6294,52.12319,0,15000,0,7,75,0),
(@PATH,4,391.559,2749.55,51.894005,0,20000,0,8,75,0),
(@PATH,5,390.09024,2736.5627,51.870853,0,5000,0,0,100,0);
DELETE FROM `waypoint_scripts` WHERE `id` IN (7,8);
INSERT INTO `waypoint_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`,`guid`) VALUES
(7,4,0,0,0,19592,0,0,0,0,8), -- Text 0
(8,4,0,0,0,19593,0,0,0,0,9); -- Text 1

-- Using broadcast text but added here because they exist and scripting method could change. 
DELETE FROM `creature_text` WHERE `CreatureID`=18976;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(18976,0,0, 'Work harder!',12,0,100,0,0,0,19592,0, 'Urga''zz say at waypoint'),
(18976,1,0, 'Mine rock!  Crack stone!  Faster!  Faster!',12,0,100,0,0,0,19593,0, 'Urga''zz say at waypoint');

-- Z''kral SAI *** Not complete ***
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=18974;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18974) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(18974,0,0,0,0,0,100,0,2500,5000,10000,12500,0,11,32004,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Z''kral - In Combat - Cast Drill'),
(18974,0,1,0,0,0,100,0,5000,10000,15000,20000,0,11,32003,1,0,0,0,0,2,0,0,0,0,0,0,0,0,'Z''kral - In Combat - Cast Power Burn'),
(18974,0,2,0,6,0,100,0,0,0,0,0,0,41,60000,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'Z''kral - On Death - Set despawn/respawn');

-- Urga''zz SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=18976;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18976) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(18976,0,0,0,0,0,100,0,3000,7000,7000,12000,0,11,32004,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Urga''zz - In Combat - Cast Drill'),
(18976,0,1,0,0,0,100,0,11000,17000,16000,30000,0,11,32003,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Urga''zz - In Combat - Cast Power Burn'),
(18976,0,2,0,0,0,100,0,3000,12000,16000,30000,0,11,34095,0,0,0,0,0,5,30,0,0,0,0,0,0,0,'Urga''zz - In Combat - Cast Throw Proximity Bomb'),
(18976,0,3,0,6,0,100,0,0,0,0,0,0,41,60000,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'Urga''zz - On Death - Set despawn/respawn');

-- Gan'arg Sapper SAI *** Not complete ***
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=18827;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18827) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(18827,0,0,1,2,0,100,1,0,15,0,0,0,11,33974,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gan''arg Sapper - Between 0-15% Health - Cast Power Burn (No Repeat)'),
(18827,0,1,0,61,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gan''arg Sapper - Between 0-15% Health - Say 0 (No Repeat)');
-- OOC spell 33895 need to add scripting may do in future but many other things need fixing.

-- Camera Shaker SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=18828;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18828) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(18828,0,0,0,1,0,100,0,8000,13000,8000,13000,0,11,33016,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Camera Shaker - OOC - Cast Internal Shake Camera');

-- Maiden of Pain SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=19408;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (19408) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(19408,0,0,0,0,0,100,0,2000,5000,10000,15000,0,11,15968,32,0,0,0,0,2,0,0,0,0,0,0,0,0,'Maiden of Pain - In Combat - Cast Lash of Pain'),
(19408,0,1,0,1,0,50,0,5000,15000,25000,35000,0,11,34086,32,0,0,0,0,1,0,0,0,0,0,0,0,0,'Maiden of Pain - OOC - Cast Whipped Frenzy');

-- Condition for source Spell implicit target condition type Object entry guid
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=34086;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 34086, 0, 1, 31, 0, 3, 18827, 0, 0, 0, 0, '', 'Spell Whipped Frenzy (effect 0) will hit the potential target of the spell if target is unit Gan''arg Sapper.'),
(13, 1, 34086, 0, 2, 31, 0, 3, 18974, 0, 0, 0, 0, '', 'Spell Whipped Frenzy (effect 0) will hit the potential target of the spell if target is unit Z''kral.'),
(13, 1, 34086, 0, 3, 31, 0, 3, 18976, 0, 0, 0, 0, '', 'Spell Whipped Frenzy (effect 0) will hit the potential target of the spell if target is unit Urga''zz.');

-- Remove improper path
DELETE FROM `waypoint_data` WHERE `id` IN (817120);
-- Fix Template
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry` IN (18827);
-- Update addon
UPDATE `creature_template_addon` SET `bytes2`=1 WHERE `entry` IN (18827,19408,18974,18976);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_18_06' WHERE sql_rev = '1645221497531808185';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

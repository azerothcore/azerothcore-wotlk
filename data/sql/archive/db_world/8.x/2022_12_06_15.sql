-- DB update 2022_12_06_14 -> 2022_12_06_15
-- TrinityCore - WowPacketParser
-- File name: 3.4.0.46368_Auchenai Crypts.pkt
-- Detected build: V3_4_0_46368
-- Detected locale: enUS
-- Targeted database: WrathOfTheLichKing
-- Parsing date: 11/18/2022 11:46:05

SET @CGUID := 132400;

DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+41;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0 , 18778, 558, 3790, 3790, 3, 1, 0, 141.688201904296875, -17.8009662628173828, 9.308135986328125, 2.129301786422729492, 86400, 0, 0, 3914, 2846, 0, 0, 0, 0, 46368), -- 18778 (Area: 3790 - Difficulty: 1) (Auras: )
(@CGUID+1 , 18726, 558, 3790, 3790, 3, 1, 0, 72.23728179931640625, -139.230804443359375, 41.13397598266601562, 3.973823785781860351, 86400, 10, 0, 3914, 2846, 1, 0, 0, 0, 46368), -- 18726 (Area: 3790 - Difficulty: 1) (Auras: ) (possible waypoints or random movement)
(@CGUID+2 , 14881, 558, 3790, 3790, 3, 1, 0, 45.05952835083007812, -22.7702369689941406, -0.06518066674470901, 1.5471726655960083, 86400, 10, 0, 8, 0, 1, 0, 0, 0, 46368), -- 14881 (Area: 3790 - Difficulty: 1) (possible waypoints or random movement)
(@CGUID+3 , 18726, 558, 3790, 3790, 3, 1, 0, 146.81549072265625, 46.86194992065429687, 25.45572662353515625, 1.716990828514099121, 86400, 10, 0, 3785, 2790, 1, 0, 0, 0, 46368), -- 18726 (Area: 3790 - Difficulty: 1) (Auras: ) (possible waypoints or random movement)
(@CGUID+4 , 18558, 558, 3790, 3790, 3, 1, 0, 60.76089859008789062, 14.71425914764404296, 3.01380324363708496, 4.572762489318847656, 86400, 10, 0, 4892, 8538, 1, 0, 0, 0, 46368), -- 18558 (Area: 3790 - Difficulty: 1) (Auras: 33422 - 33422) (possible waypoints or random movement)
(@CGUID+5 , 14881, 558, 3790, 3790, 3, 1, 0, 92.6985931396484375, 39.83838272094726562, 4.261242866516113281, 3.175329923629760742, 86400, 10, 0, 8, 0, 1, 0, 0, 0, 46368), -- 14881 (Area: 3790 - Difficulty: 1) (possible waypoints or random movement)
(@CGUID+6 , 18559, 558, 3790, 3790, 3, 1, 0, 103.51043701171875, -31.661163330078125, 2.187038183212280273, 1.361356854438781738, 86400, 10, 0, 4892, 8538, 1, 0, 0, 0, 46368), -- 18559 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+7 , 14881, 558, 3790, 3790, 3, 1, 0, 97.67818450927734375, -48.17626953125, 13.02889537811279296, 3.892084121704101562, 86400, 0, 0, 8, 0, 0, 0, 0, 0, 46368), -- 14881 (Area: 3790 - Difficulty: 1)
(@CGUID+8 , 18559, 558, 3790, 3790, 3, 1, 0, 126.1765975952148437, 27.94812965393066406, -0.0451296642422676, 5.288347721099853515, 86400, 10, 0, 4731, 8370, 1, 0, 0, 0, 46368), -- 18559 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+9 , 18557, 558, 3790, 3790, 3, 1, 0, 127.6752700805664062, -9.82014083862304687, 0.99261629581451416, 4.747295379638671875, 86400, 10, 0, 4892, 8538, 1, 0, 0, 0, 46368), -- 18557 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+10, 18726, 558, 3790, 3790, 3, 1, 0, 97.7019195556640625, -196.2841796875, 32.13418960571289062, 3.175072669982910156, 86400, 10, 0, 3914, 2846, 1, 0, 0, 0, 46368), -- 18726 (Area: 3790 - Difficulty: 1) (Auras: ) (possible waypoints or random movement)
(@CGUID+11, 18556, 558, 3790, 3790, 3, 1, 0, 163.4202117919921875, -22.1444644927978515, 3.989299297332763671, 3.50811171531677246, 86400, 10, 0, 5914, 0, 1, 0, 0, 0, 46368), -- 18556 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+12, 14881, 558, 3790, 3790, 3, 1, 0, 159.0821685791015625, 48.30177688598632812, 13.00515556335449218, 2.722713708877563476, 86400, 0, 0, 8, 0, 0, 0, 0, 0, 46368), -- 14881 (Area: 3790 - Difficulty: 1)
(@CGUID+13, 18557, 558, 3790, 3790, 3, 1, 0, 187.840087890625, -15.5929212570190429, 0.094242662191390991, 0.797547459602355957, 86400, 10, 0, 4892, 8538, 1, 0, 0, 0, 46368), -- 18557 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+14, 18557, 558, 3790, 3790, 3, 1, 0, 213.835174560546875, -4.47357988357543945, 27.13109397888183593, 3.855632543563842773, 86400, 10, 0, 4892, 8538, 1, 0, 0, 0, 46368), -- 18557 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+15, 18726, 558, 3790, 3790, 3, 1, 0, 228.5708770751953125, -154.554794311523437, 42.4182281494140625, 4.082814216613769531, 86400, 10, 0, 3914, 2846, 1, 0, 0, 0, 46368), -- 18726 (Area: 3790 - Difficulty: 1) (Auras: ) (possible waypoints or random movement)
(@CGUID+16, 18559, 558, 3790, 3790, 3, 1, 0, 235.888214111328125, 37.071319580078125, 26.60670852661132812, 6.230825424194335937, 86400, 10, 0, 4892, 8538, 1, 0, 0, 0, 46368), -- 18559 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+17, 18558, 558, 3790, 3790, 3, 1, 0, 233.9306640625, -81.6968917846679687, 26.59130859375, 1.873605251312255859, 86400, 10, 0, 4731, 8370, 1, 0, 0, 0, 46368), -- 18558 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+18, 14881, 558, 3790, 3790, 3, 1, 0, 231.3909759521484375, -89.6042861938476562, 26.59129714965820312, 3.194384336471557617, 86400, 10, 0, 8, 0, 1, 0, 0, 0, 46368), -- 14881 (Area: 3790 - Difficulty: 1) (possible waypoints or random movement)
(@CGUID+19, 14881, 558, 3790, 3790, 3, 1, 0, 246.479034423828125, 28.41371917724609375, -0.0931381732225418, 2.503427028656005859, 86400, 10, 0, 8, 0, 1, 0, 0, 0, 46368), -- 14881 (Area: 3790 - Difficulty: 1) (possible waypoints or random movement)
(@CGUID+20, 18559, 558, 3790, 3790, 3, 1, 0, 248.70538330078125, 8.750345230102539062, -0.05698036402463912, 4.583363533020019531, 86400, 10, 0, 4892, 8538, 1, 0, 0, 0, 46368), -- 18559 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+21, 18559, 558, 3790, 3790, 3, 1, 0, 243.87628173828125, -83.900970458984375, 26.59127998352050781, 1.63226020336151123, 86400, 10, 0, 4731, 8370, 1, 0, 0, 0, 46368), -- 18559 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+22, 18556, 558, 3790, 3790, 3, 1, 0, 186.60491943359375, -142.1177978515625, 26.49381256103515625, 1.495209813117980957, 86400, 10, 0, 5914, 0, 1, 0, 0, 0, 46368), -- 18556 (Area: 3790 - Difficulty: 1) (Auras: 32828 - 32828, 35838 - 35838) (possible waypoints or random movement)
(@CGUID+23, 14881, 558, 3790, 3790, 3, 1, 0, 279.230072021484375, -164.819198608398437, 26.59128189086914062, 5.252141952514648437, 86400, 10, 0, 8, 0, 1, 0, 0, 0, 46368), -- 14881 (Area: 3790 - Difficulty: 1) (possible waypoints or random movement)
(@CGUID+24, 14881, 558, 3790, 3790, 3, 1, 0, 265.3153076171875, -165.703216552734375, 26.59129714965820312, 0.433016598224639892, 86400, 10, 0, 8, 0, 1, 0, 0, 0, 46368), -- 14881 (Area: 3790 - Difficulty: 1) (possible waypoints or random movement)
(@CGUID+25, 18557, 558, 3790, 3790, 3, 1, 0, 223.129425048828125, -185.3570556640625, 26.59128952026367187, 3.803879976272583007, 86400, 10, 0, 4892, 8538, 1, 0, 0, 0, 46368), -- 18557 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+26, 14881, 558, 3790, 3790, 3, 1, 0, 242.442474365234375, -197.4185791015625, 26.78278923034667968, 0.544354975223541259, 86400, 10, 0, 8, 0, 1, 0, 0, 0, 46368), -- 14881 (Area: 3790 - Difficulty: 1) (possible waypoints or random movement)
(@CGUID+27, 14881, 558, 3790, 3790, 3, 1, 0, 183.240753173828125, -184.31024169921875, 26.5577239990234375, 1.310078978538513183, 86400, 10, 0, 8, 0, 1, 0, 0, 0, 46368), -- 14881 (Area: 3790 - Difficulty: 1) (possible waypoints or random movement)
(@CGUID+28, 18559, 558, 3790, 3790, 3, 1, 0, 152.7404937744140625, -152.847808837890625, 19.01497459411621093, 3.115509033203125, 86400, 10, 0, 4731, 8370, 1, 0, 0, 0, 46368), -- 18559 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+29, 18557, 558, 3790, 3790, 3, 1, 0, 252.762115478515625, -143.580169677734375, 31.34482765197753906, 3.944444179534912109, 86400, 10, 0, 4892, 8538, 1, 0, 0, 0, 46368), -- 18557 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+30, 18557, 558, 3790, 3790, 3, 1, 0, 63.40744400024414062, -175.263900756835937, 15.34021472930908203, 6.143558979034423828, 86400, 10, 0, 4731, 8370, 1, 0, 0, 0, 46368), -- 18557 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+31, 18558, 558, 3790, 3790, 3, 1, 0, 108.3681259155273437, -168.1009521484375, 14.66339969635009765, 4.031710624694824218, 86400, 10, 0, 4731, 8370, 1, 0, 0, 0, 46368), -- 18558 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+32, 18726, 558, 3790, 3790, 3, 1, 0, 25.89444541931152343, -345.461029052734375, 46.5911712646484375, 1.54946136474609375, 86400, 10, 0, 3914, 2846, 1, 0, 0, 0, 46368), -- 18726 (Area: 3790 - Difficulty: 1) (Auras: ) (possible waypoints or random movement)
(@CGUID+35, 14881, 558, 3790, 3790, 3, 1, 0, -109.882362365722656, -154.428543090820312, 26.5885162353515625, 3.14505171775817871, 86400, 0, 0, 8, 0, 0, 0, 0, 0, 46368), -- 14881 (Area: 3790 - Difficulty: 1)
(@CGUID+36, 18556, 558, 3790, 3790, 3, 1, 0, -130.409500122070312, -169.439208984375, 26.58745956420898437, 0.149694308638572692, 86400, 10, 0, 6116, 0, 1, 0, 0, 0, 46368), -- 18556 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838, 32828 - 32828) (possible waypoints or random movement)
(@CGUID+37, 18558, 558, 3790, 3790, 3, 1, 0, -144.49114990234375, -158.025375366210937, 26.58998870849609375, 1.594105005264282226, 86400, 10, 0, 4892, 8538, 1, 0, 0, 0, 46368), -- 18558 (Area: 3790 - Difficulty: 1) (Auras: 35838 - 35838) (possible waypoints or random movement)
(@CGUID+38, 14881, 558, 3790, 3790, 3, 1, 0, -132.335433959960937, -243.223098754882812, 26.33264350891113281, 2.764749526977539062, 86400, 10, 0, 8, 0, 1, 0, 0, 0, 46368), -- 14881 (Area: 3790 - Difficulty: 1) (possible waypoints or random movement)
-- (@CGUID+39, 18499, 558, 3790, 3790, 3, 1, 0, -143.103179931640625, -190.384490966796875, 26.67429924011230468, 4.689732074737548828, 86400, 0, 0, 6604, 8538, 0, 0, 0, 0, 46368), -- 18499 (Area: 3790 - Difficulty: 1) (Auras: 33422 - 33422) - !!! might be temporary spawn !!!
(@CGUID+40, 14881, 558, 3790, 3790, 3, 1, 0, -172.6209716796875, -314.437774658203125, 27.149200439453125, 4.899399280548095703, 86400, 0, 0, 8, 0, 0, 0, 0, 0, 46368), -- 14881 (Area: 3790 - Difficulty: 1)
(@CGUID+41, 14881, 558, 3790, 3790, 3, 1, 0, -126.184173583984375, -322.9429931640625, 28.4794464111328125, 4.805230140686035156, 86400, 0, 0, 8, 0, 0, 0, 0, 0, 46368); -- 14881 (Area: 3790 - Difficulty: 1)
-- (@CGUID+42, 18499, 558, 3790, 3790, 3, 1, 0, -119.939155578613281, -163.717010498046875, 26.67186164855957031, 0.069813169538974761, 86400, 0, 0, 6604, 8538, 0, 0, 0, 0, 46368), -- 18499 (Area: 3790 - Difficulty: 1) (Auras: 33422 - 33422) - !!! might be temporary spawn !!!
-- (@CGUID+43, 18499, 558, 3790, 3790, 3, 1, 0, -148.999969482421875, -157.538055419921875, 26.67399024963378906, 3.255656719207763671, 86400, 0, 0, 6387, 8370, 0, 0, 0, 0, 46368); -- 18499 (Area: 3790 - Difficulty: 1) (Auras: 33422 - 33422) - !!! might be temporary spawn !!!

-- Cosmetic Flying creatures
UPDATE `creature_template_addon` SET `auras` = '32460' WHERE `entry` IN (18726, 18778);
-- ID - 35838 Ghost Visual
DELETE FROM `creature_template_addon` WHERE `entry` IN (18556, 18557, 18558, 18559, 18506);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(18556, 0, 0, 0, 0, 0, 0, '32828 35838 35841 35850'),
(18557, 0, 0, 0, 0, 0, 0, '35838'),
(18558, 0, 0, 0, 0, 0, 0, '35838'),
(18559, 0, 0, 0, 0, 0, 0, '35838'),
(18506, 0, 0, 0, 0, 0, 0, '35841 35850'); -- Raging Soul

-- Correct Movement Speed of Auchenai Monks (Previously 1,6 and 1,71429)
UPDATE `creature_template` SET `speed_walk` = 1, `speed_run` = 1.14286 WHERE (`entry` = 18497);

SET @NPC := @CGUID+1;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '32460');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,73.350945,-138.00761,31.271748,NULL,0,2,0,100,0),
(@PATH,2,72.23728,-139.2308,41.133976,NULL,0,2,0,100,0),
(@PATH,3,71.92045,-139.5788,43.93974,NULL,0,2,0,100,0),
(@PATH,4,44.709515,-139.31296,43.773067,NULL,0,2,0,100,0),
(@PATH,5,23.519997,-138.49461,43.661957,NULL,0,2,0,100,0),
(@PATH,6,-20.031794,-137.46468,43.273064,NULL,0,2,0,100,0),
(@PATH,7,-20.031794,-137.46468,43.273064,NULL,0,2,0,100,0);

SET @NPC := @CGUID+3;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '32460');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,151.24632,44.323353,15.399155,NULL,0,2,0,100,0),
(@PATH,2 ,147.2805,46.17681,24.390093,NULL,0,2,0,100,0),
(@PATH,3 ,146.81526,46.394245,25.444843,NULL,0,2,0,100,0),
(@PATH,4 ,146.69821,37.811546,25.500387,NULL,0,2,0,100,0),
(@PATH,5 ,146.4773,28.050829,25.667048,NULL,0,2,0,100,0),
(@PATH,6 ,147.59975,13.665521,25.611506,NULL,0,2,0,100,0),
(@PATH,7 ,148.03667,-3.350005,25.750395,NULL,0,2,0,100,0),
(@PATH,8 ,148.1382,-22.668484,25.444832,NULL,0,2,0,100,0),
(@PATH,9 ,147.31918,-37.111103,25.333727,NULL,0,2,0,100,0),
(@PATH,10,146.81532,-46.187805,25.333723,NULL,0,2,0,100,0),
(@PATH,11,146.81532,-46.187805,25.333723,NULL,0,2,0,100,0);

SET @NPC := @CGUID+10;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '32460');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,179.56317,-198.8384,10.106315,NULL,0,2,0,100,0),
(@PATH,2,157.18993,-196.71312,21.43171,NULL,0,2,0,100,0),
(@PATH,3,134.81668,-194.58784,32.757103,NULL,0,2,0,100,0),
(@PATH,4,108.52028,-195.8693,32.229393,NULL,0,2,0,100,0),
(@PATH,5,93.42153,-196.42836,32.118183,NULL,0,2,0,100,0),
(@PATH,6,93.42153,-196.42836,32.118183,NULL,0,2,0,100,0);

SET @NPC := @CGUID+15;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '32460');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,232.20787,-145.59749,41.718987,NULL,0,2,0,100,0),
(@PATH,2 ,228.02461,-154.6508,42.452423,NULL,0,2,0,100,0),
(@PATH,3 ,225.33128,-160.47964,42.924637,NULL,0,2,0,100,0),
(@PATH,4 ,226.26433,-167.05211,43.61908,NULL,0,2,0,100,0),
(@PATH,5 ,228.99861,-171.22679,44.09132,NULL,0,2,0,100,0),
(@PATH,6 ,234.16539,-174.73897,44.61909,NULL,0,2,0,100,0),
(@PATH,7 ,240.23022,-175.16766,44.757957,NULL,0,2,0,100,0),
(@PATH,8 ,245.79956,-173.5961,44.836193,NULL,0,2,0,100,0),
(@PATH,9 ,250.73444,-170.3529,44.89179,NULL,0,2,0,100,0),
(@PATH,10,253.15332,-164.77332,44.44733,NULL,0,2,0,100,0),
(@PATH,11,251.40865,-158.42947,43.8496,NULL,0,2,0,100,0),
(@PATH,12,247.62373,-153.52211,43.168236,NULL,0,2,0,100,0),
(@PATH,13,241.58646,-149.26561,42.473785,NULL,0,2,0,100,0),
(@PATH,14,236.16528,-148.9468,42.22376,NULL,0,2,0,100,0),
(@PATH,15,231.14494,-151.02124,42.195972,NULL,0,2,0,100,0),
(@PATH,16,228.57088,-154.5548,42.41823,NULL,0,2,0,100,0),
(@PATH,17,228.57088,-154.5548,42.41823,NULL,0,2,0,100,0);

SET @NPC := @CGUID+32;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '32460');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,24.944605,-358.5967,46.91501,NULL,0,2,0,100,0),
(@PATH,2,24.51828,-375.59692,47.02612,NULL,0,2,0,100,0),
(@PATH,3,24.289051,-397.9468,47.026104,NULL,0,2,0,100,0),
(@PATH,4,24.935328,-418.3117,46.803886,NULL,0,2,0,100,0),
(@PATH,5,25.588974,-434.98022,46.72057,NULL,0,2,0,100,0);

-- Pathing for Phasing Soldier Entry: 18556
SET @NPC := @CGUID+11;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '32828 35838 35841 35850');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,163.42021,-22.144464,3.9059505,NULL,0,0,491,100,0),
(@PATH,2,156.25214,-26.96173,7.3015285,NULL,0,0,0,100,0),
(@PATH,3,148.84656,-26.111628,9.093671,NULL,0,0,0,100,0),
(@PATH,4,143.56517,-26.607273,10.320737,NULL,0,0,0,100,0),
(@PATH,5,137.3586,-29.342598,11.133306,NULL,0,0,0,100,0),
(@PATH,6,132.71771,-32.661335,12.362364,NULL,0,0,0,100,0),
(@PATH,7,127.05344,-36.36787,11.95393,NULL,180000,0,492,100,0);
-- 0x204CB045C0121F0000016F000061BFFA .go xyz 163.42021 -22.144464 3.9059505

-- Pathing for Phasing Soldier Entry: 18556
SET @NPC := @CGUID+22;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '32828 35838 35841 35850');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,186.39815,-187.63376,26.586843,NULL,0,0,491,100,0),
(@PATH,2,186.01659,-170.86678,26.57505,NULL,0,0,0,100,0),
(@PATH,3,185.84586,-152.141,26.433743,NULL,0,0,0,100,0),
(@PATH,4,186.82649,-139.19202,26.515371,NULL,180000,0,492,100,0);
-- 0x204CB045C0121F0000016F000061BFFB .go xyz 186.39815 -187.63376 26.586843

-- Pathing for Phasing Soldier Entry: 18556
SET @NPC := @CGUID+36;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-140.33557,`position_y`=-182.85066,`position_z`=26.59173 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '32828 35838 35841 35850');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-140.33557,-182.85066,26.59173,NULL,0,0,491,100,0),
(@PATH,2,-139.43959,-177.26666,26.591074,NULL,0,0,0,100,0),
(@PATH,3,-137.69144,-172.42462,26.592718,NULL,0,0,0,100,0),
(@PATH,4,-130.4095,-169.43921,26.58746,NULL,180000,0,492,100,0);
-- 0x204CB045C0121F0000016F0000E1BFFA .go xyz -140.33557 -182.85066 26.59173

-- Pathing for Phasing Cleric Entry: 18557
SET @NPC := @CGUID+29;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=252.76212,`position_y`=-143.58017,`position_z`=31.344828 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,252.76212,-143.58017,31.344828,NULL,0,0,491,100,0),
(@PATH,2,247.20137,-141.40672,28.45697,NULL,0,0,0,100,0),
(@PATH,3,239.47426,-140.56499,26.604721,NULL,0,0,0,100,0),
(@PATH,4,232.98956,-142.09483,26.598186,NULL,0,0,0,100,0),
(@PATH,5,226.8533,-145.60709,26.592377,NULL,0,0,0,100,0),
(@PATH,6,223.00479,-149.41129,26.591297,NULL,0,0,0,100,0),
(@PATH,7,219.4117,-156.10533,26.591295,NULL,0,0,0,100,0),
(@PATH,8,218.31477,-163.05994,26.591297,NULL,0,0,0,100,0),
(@PATH,9,219.38469,-170.84055,26.591295,NULL,0,0,0,100,0),
(@PATH,10,222.65584,-177.14705,26.59129,NULL,0,0,0,100,0),
(@PATH,11,229.7245,-182.66959,26.591282,NULL,0,0,0,100,0),
(@PATH,12,233.93506,-186.75621,26.591286,NULL,0,0,0,100,0),
(@PATH,13,234.9648,-190.40332,26.59129,NULL,180000,0,492,100,0);
-- 0x204CB045C0121F4000016F000061BFFA .go xyz 252.76212 -143.58017 31.344828

-- Pathing for Phasing Cleric Entry: 18557
SET @NPC := @CGUID+25;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=265.72266,`position_y`=-167.39992,`position_z`=26.591297 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,265.72266,-167.39992,26.591297,NULL,0,0,491,100,0),
(@PATH,2,260.2587,-173.44904,26.5913,NULL,0,0,0,100,0),
(@PATH,3,254.21541,-174.24063,28.541336,NULL,0,0,0,100,0),
(@PATH,4,249.80678,-178.8307,29.993172,NULL,0,0,0,100,0),
(@PATH,5,243.34229,-182.10753,29.073282,NULL,0,0,0,100,0),
(@PATH,6,236.51315,-182.80513,26.591282,NULL,0,0,0,100,0),
(@PATH,7,230.59372,-180.36035,26.59128,NULL,0,0,0,100,0),
(@PATH,8,226.47932,-182.74487,26.591282,NULL,0,0,0,100,0),
(@PATH,9,223.12943,-185.35706,26.59129,NULL,180000,0,492,100,0);
-- 0x204CB045C0121F4000016F0000E1BFFA .go xyz 265.72266 -167.39992 26.591297

-- Pathing for Phasing Cleric Entry: 18557
SET @NPC := @CGUID+9;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=127.67527,`position_y`=-9.820141,`position_z`=0.9092922 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,127.67527,-9.820141,0.9092922,NULL,0,0,491,100,0),
(@PATH,2,129.5654,-17.583628,5.0594177,NULL,0,0,0,100,0),
(@PATH,3,129.5531,-21.944284,6.884782,NULL,0,0,0,100,0),
(@PATH,4,133.11812,-29.490608,10.753902,NULL,0,0,0,100,0),
(@PATH,5,136.52745,-31.686588,12.264767,NULL,0,0,0,100,0),
(@PATH,6,143.1685,-34.106094,13.614726,NULL,0,0,0,100,0),
(@PATH,7,150.10359,-36.330883,13.5456295,NULL,0,0,0,100,0),
(@PATH,8,154.84016,-37.25858,13.179008,NULL,0,0,0,100,0),
(@PATH,9,161.82185,-39.311287,12.2130375,NULL,180000,0,492,100,0);
-- 0x204CB045C0121F4000016F000161BFFA .go xyz 127.67527 -9.820141 0.9092922

-- Pathing for Phasing Cleric Entry: 18557
SET @NPC := @CGUID+13;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=170.21268,`position_y`=-18.678844,`position_z`=1.8106413 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,170.21268,-18.678844,1.8106413,NULL,0,0,491,100,0),
(@PATH,2,176.21935,-20.366,-0.12755382,NULL,0,0,0,100,0),
(@PATH,3,183.50932,-20.030233,-0.124699146,NULL,0,0,0,100,0),
(@PATH,4,187.84009,-15.592921,0.09424267,NULL,0,0,0,100,0),
(@PATH,5,191.94017,-6.714968,-0.12076864,NULL,0,0,0,100,0),
(@PATH,6,192.66939,2.518242,-0.116914734,NULL,0,0,0,100,0),
(@PATH,7,191.38432,9.125355,-0.11827608,NULL,0,0,0,100,0),
(@PATH,8,190.95491,15.178104,1.7854161,NULL,180000,0,492,100,0);
-- 0x204CB045C0121F4000016F0001E1BFFA .go xyz 170.21268 -18.678844 1.8106413

-- Pathing for Phasing Cleric Entry: 18557
SET @NPC := @CGUID+30;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=63.407444,`position_y`=-175.2639,`position_z`=15.340215 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,63.407444,-175.2639,15.340215,NULL,0,0,491,100,0),
(@PATH,2,63.922012,-164.90332,15.36321,NULL,0,0,0,100,0),
(@PATH,3,64.89777,-157.71608,15.324875,NULL,0,0,0,100,0),
(@PATH,4,63.779285,-154.1999,15.270904,NULL,0,0,0,100,0),
(@PATH,5,61.176,-152.29073,15.320725,NULL,0,0,0,100,0),
(@PATH,6,57.89829,-152.15157,15.305273,NULL,0,0,0,100,0),
(@PATH,7,54.855816,-154.90836,15.210086,NULL,0,0,0,100,0),
(@PATH,8,42.59613,-157.50063,14.917099,NULL,0,0,0,100,0),
(@PATH,9,38.038113,-157.83847,14.781163,NULL,0,0,0,100,0),
(@PATH,10,34.37812,-156.34639,14.540044,NULL,180000,0,492,100,0);
-- 0x204CB045C0121F4000016F000261BFFA .go xyz 63.407444 -175.2639 15.340215

-- Pathing for Phasing Cleric Entry: 18557
SET @NPC := @CGUID+14;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=219.37904,`position_y`=0.33060265,`position_z`=28.327349 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,219.37904,0.33060265,28.327349,NULL,0,0,491,100,0),
(@PATH,2,213.83517,-4.47358,27.131094,NULL,0,0,0,100,0),
(@PATH,3,212.30658,-9.702579,27.207218,NULL,0,0,0,100,0),
(@PATH,4,212.08582,-16.853407,27.295864,NULL,0,0,0,100,0),
(@PATH,5,212.82582,-22.971846,26.895174,NULL,0,0,0,100,0),
(@PATH,6,216.42055,-27.29053,26.591383,NULL,0,0,0,100,0),
(@PATH,7,222.45038,-29.665424,27.404846,NULL,0,0,0,100,0),
(@PATH,8,227.68648,-29.660278,27.280148,NULL,0,0,0,100,0),
(@PATH,9,237.29475,-29.352152,26.840483,NULL,0,0,0,100,0),
(@PATH,10,245.5611,-29.118198,26.610186,NULL,0,0,0,100,0),
(@PATH,11,256.06567,-29.392622,26.598423,NULL,0,0,0,100,0),
(@PATH,12,264.68683,-30.948347,26.591227,NULL,0,0,0,100,0),
(@PATH,13,273.67218,-31.774408,26.591225,NULL,180000,0,492,100,0);
-- 0x204CB045C0121F4000016F0002E1BFFA .go xyz 219.37904 0.33060265 28.327349

-- Pathing for Phasing Sorcerer Entry: 18558
SET @NPC := @CGUID+31;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=108.368126,`position_y`=-168.10095,`position_z`=14.6634 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,108.368126,-168.10095,14.6634,NULL,0,0,491,100,0),
(@PATH,2,94.0889,-166.98608,15.221693,NULL,0,0,0,100,0),
(@PATH,3,87.63592,-167.62035,15.353543,NULL,0,0,0,100,0),
(@PATH,4,83.18925,-169.28035,15.387257,NULL,0,0,0,100,0),
(@PATH,5,80.92766,-172.92093,15.428644,NULL,180000,0,492,100,0);
-- 0x204CB045C0121F8000016F0000E1BFFA .go xyz 108.368126 -168.10095 14.6634

-- Pathing for Phasing Sorcerer Entry: 18558
SET @NPC := @CGUID+4;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=60.7609,`position_y`=14.71426,`position_z`=2.9304667 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,60.7609,14.71426,2.9304667,NULL,0,0,491,100,0),
(@PATH,2,62.473858,-0.185765,-0.1819104,NULL,0,0,0,100,0),
(@PATH,3,60.937054,-19.739634,2.7972555,NULL,180000,0,492,100,0);
-- 0x204CB045C0121F8000016F000261BFFA .go xyz 60.7609 14.71426 2.9304667

-- Pathing for Phasing Sorcerer Entry: 18558
SET @NPC := @CGUID+37;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-144.05402,-176.77612,26.591373,NULL,0,0,491,100,0),
(@PATH,2,-144.21027,-170.07382,26.590784,NULL,0,0,0,100,0),
(@PATH,3,-144.36652,-163.37152,26.590195,NULL,0,0,0,100,0),
(@PATH,4,-144.37608,-162.96107,26.58878,NULL,0,0,0,100,0),
(@PATH,5,-144.54129,-155.87457,26.590515,NULL,0,0,0,100,0),
(@PATH,6,-144.54129,-155.87457,26.590515,NULL,180000,0,492,100,0);

-- Pathing for Phasing Sorcerer Entry: 18558
SET @NPC := @CGUID+17;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,234.08588,-92.13391,26.591291,NULL,0,0,491,100,0),
(@PATH,2,234.09532,-91.47241,26.591291,NULL,0,0,0,100,0),
(@PATH,3,234.10477,-90.81091,26.591291,NULL,0,0,0,100,0),
(@PATH,4,234.46289,-89.07118,26.591288,NULL,0,0,0,100,0),
(@PATH,5,235.16656,-85.652824,26.59131,NULL,0,0,0,100,0),
(@PATH,6,234.99062,-85.08963,26.59131,NULL,0,0,0,100,0),
(@PATH,7,233.66092,-80.833466,26.591309,NULL,0,0,0,100,0),
(@PATH,8,233.66092,-80.833466,26.591309,NULL,180000,0,492,100,0);

-- Pathing for Phasing Stalker Entry: 18559
SET @NPC := @CGUID+20;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=254.08589,`position_y`=16.281115,`position_z`=1.0690411 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,254.08589,16.281115,1.0690411,NULL,0,0,491,100,0),
(@PATH,2,249.09479,11.751573,-0.057969235,NULL,0,0,0,100,0),
(@PATH,3,248.29317,5.573168,-0.05051643,NULL,0,0,0,100,0),
(@PATH,4,249.30978,0.292467,-0.04696809,NULL,0,0,0,100,0),
(@PATH,5,248.19304,-4.38714,-0.050115947,NULL,0,0,0,100,0),
(@PATH,6,245.5446,-7.974623,-0.058118563,NULL,0,0,0,100,0),
(@PATH,7,241.89896,-12.228353,-0.06918345,NULL,0,0,0,100,0),
(@PATH,8,239.66989,-16.145578,-0.07585467,NULL,0,0,0,100,0),
(@PATH,9,239.524,-20.53202,-0.06419688,NULL,0,0,0,100,0),
(@PATH,10,240.83255,-25.9776,-0.06601114,NULL,0,0,0,100,0),
(@PATH,11,244.28032,-28.857412,1.3836285,NULL,180000,0,492,100,0);
-- 0x204CB045C0121FC000016F000061BFFA .go xyz 254.08589 16.281115 1.0690411

-- Pathing for Phasing Stalker Entry: 18559
SET @NPC := @CGUID+16;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=235.88821,`position_y`=37.07132,`position_z`=26.606709 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,235.88821,37.07132,26.606709,NULL,0,0,491,100,0),
(@PATH,2,247.22252,37.847027,20.479275,NULL,0,0,0,100,0),
(@PATH,3,257.5441,38.34387,13.4442425,NULL,0,0,0,100,0),
(@PATH,4,269.6288,37.601143,13.41417,NULL,0,0,0,100,0),
(@PATH,5,272.89047,36.50316,13.4086685,NULL,0,0,0,100,0),
(@PATH,6,274.30402,34.681675,13.410205,NULL,0,0,0,100,0),
(@PATH,7,274.67148,31.516829,13.418446,NULL,0,0,0,100,0),
(@PATH,8,274.31213,21.329618,13.449085,NULL,0,0,0,100,0),
(@PATH,9,274.1166,11.805699,6.4145527,NULL,0,0,0,100,0),
(@PATH,10,274.6112,1.604477,-0.08050743,NULL,180000,0,492,100,0);
-- 0x204CB045C0121FC000016F0000E1BFFA .go xyz 235.88821 37.07132 26.606709

-- Pathing for Phasing Stalker Entry: 18559
SET @NPC := @CGUID+21;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,244.87045,-100.05577,26.59129,NULL,0,0,491,100,0),
(@PATH,2,244.45204,-93.25677,26.591284,NULL,0,0,0,100,0),
(@PATH,3,244.03363,-86.45776,26.591278,NULL,0,0,0,100,0),
(@PATH,4,243.87628,-83.90097,26.59128,NULL,0,0,0,100,0),
(@PATH,5,243.87628,-83.90097,26.59128,NULL,180000,0,492,100,0);

-- Pathing for Phasing Stalker Entry: 18559
SET @NPC := @CGUID+8;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=126.1766,`position_y`=27.948132,`position_z`=-0.105519295 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,126.1766,27.948132,-0.105519295,NULL,0,0,491,100,0),
(@PATH,2,130.59267,16.555323,-0.12910895,NULL,0,0,0,100,0),
(@PATH,3,130.62326,8.567173,-0.1291158,NULL,0,0,0,100,0),
(@PATH,4,132.76746,2.109716,-0.12837085,NULL,0,0,0,100,0),
(@PATH,5,135.87859,-4.567481,1.1544765,NULL,0,0,0,100,0),
(@PATH,6,141.38376,-6.336381,1.8670539,NULL,0,0,0,100,0),
(@PATH,7,150.151,-6.409088,1.8575414,NULL,0,0,0,100,0),
(@PATH,8,158.26154,-6.41169,1.2996879,NULL,0,0,0,100,0),
(@PATH,9,162.83406,-10.075247,1.2974932,NULL,0,0,0,100,0),
(@PATH,10,166.6864,-15.174739,2.4810312,NULL,180000,0,492,100,0);
-- 0x204CB045C0121FC000016F000261BFFA .go xyz 126.1766 27.948132 -0.105519295

-- Pathing for Phasing Stalker Entry: 18559
SET @NPC := @CGUID+6;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=103.51044,`position_y`=-31.661163,`position_z`=2.2046442 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,103.51044,-31.661163,2.2046442,NULL,0,0,491,100,0),
(@PATH,2,104.59338,-23.583656,-0.07155674,NULL,0,0,0,100,0),
(@PATH,3,102.89938,-19.097414,-0.043581124,NULL,0,0,0,100,0),
(@PATH,4,102.20383,-13.462062,0.18044646,NULL,0,0,0,100,0),
(@PATH,5,104.55045,-7.681597,0.21229711,NULL,0,0,0,100,0),
(@PATH,6,105.15511,5.540357,0.5351643,NULL,0,0,0,100,0),
(@PATH,7,103.2398,12.823616,-0.098418705,NULL,0,0,0,100,0),
(@PATH,8,104.68291,17.770578,0.1706654,NULL,0,0,0,100,0),
(@PATH,9,108.10148,21.937067,0.16965415,NULL,0,0,0,100,0),
(@PATH,10,111.47976,22.290707,0.009937675,NULL,180000,0,492,100,0);
-- 0x204CB045C0121FC000016F0002E1BFFA .go xyz 103.51044 -31.661163 2.2046442

-- Pathing for Phasing Stalker Entry: 18559
SET @NPC := @CGUID+28;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=182.65771,`position_y`=-140.55536,`position_z`=26.389036 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '35838');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,182.65771,-140.55536,26.389036,NULL,0,0,491,100,0),
(@PATH,2,181.64246,-147.2506,26.326574,NULL,0,0,0,100,0),
(@PATH,3,179.35037,-150.43063,26.26074,NULL,0,0,0,100,0),
(@PATH,4,174.82385,-152.08482,26.326044,NULL,0,0,0,100,0),
(@PATH,5,169.2696,-152.8632,26.444696,NULL,0,0,0,100,0),
(@PATH,6,162.41,-153.10008,26.06021,NULL,0,0,0,100,0),
(@PATH,7,152.7405,-152.84781,19.014975,NULL,0,0,0,100,0),
(@PATH,8,146.63557,-152.49663,14.267556,NULL,180000,0,492,100,0);
-- 0x204CB045C0121FC000016F000361BFFA .go xyz 182.65771 -140.55536 26.389036

-- Pathing for Auchenai Monk Entry: 18497
SET @NPC := 83390;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=139.49518,`position_y`=2.368823,`position_z`=-0.12775199 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,139.49518,2.368823,-0.12775199,NULL,0,0,0,100,0),
(@PATH,2,148.84927,3.26893,-0.12693678,NULL,0,0,0,100,0),
(@PATH,3,158.58562,2.221657,-0.12592205,NULL,0,0,0,100,0),
(@PATH,4,164.71635,9.033345,-0.12607376,NULL,0,0,0,100,0),
(@PATH,5,164.69518,17.096685,0.042672906,NULL,0,0,0,100,0),
(@PATH,6,164.39384,27.017565,-0.03106403,NULL,0,0,0,100,0),
(@PATH,7,158.12143,30.15233,-0.110156626,NULL,0,0,0,100,0),
(@PATH,8,154.54019,31.208351,-0.10033583,NULL,0,0,0,100,0),
(@PATH,9,153.50821,38.660362,4.231137,NULL,40000,0,0,100,0),
(@PATH,10,150.59761,30.838694,-0.10033666,NULL,0,0,0,100,0),
(@PATH,11,132.99837,30.463366,-0.09167093,NULL,0,0,0,100,0),
(@PATH,12,130.24228,29.550669,-0.09694571,NULL,0,0,0,100,0),
(@PATH,13,129.23076,20.53834,-0.12918013,NULL,0,0,0,100,0),
(@PATH,14,130.77061,10.76564,0.09537189,NULL,0,0,0,100,0),
(@PATH,15,130.48642,2.902071,-0.12865439,NULL,0,0,0,100,0),
(@PATH,16,129.59958,-2.468409,0.06528245,NULL,0,0,0,100,0),
(@PATH,17,125.65282,-3.223653,0.120242454,NULL,40000,0,0,100,0);
-- 0x204CB045C012104000016F0002E1BFFA .go xyz 139.49518 2.368823 -0.12775199

-- Pathing for Auchenai Soulpriest Entry: 18493
SET @NPC := 83386;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=268.32703,`position_y`=-3.305813,`position_z`=-0.0678567 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,268.32703,-3.305813,-0.0678567,NULL,0,0,0,100,0),
(@PATH,2,269.36295,21.878204,13.413179,NULL,0,0,0,100,0),
(@PATH,3,268.90814,29.680952,13.439169,NULL,0,0,0,100,0),
(@PATH,4,266.3649,32.88496,13.436618,NULL,0,0,0,100,0),
(@PATH,5,257.8986,33.67169,13.394914,NULL,0,0,0,100,0),
(@PATH,6,237.949,32.514015,26.632038,NULL,0,0,0,100,0),
(@PATH,7,217.88676,33.820267,26.621796,NULL,0,0,0,100,0),
(@PATH,8,211.06705,32.123497,26.631569,NULL,0,0,0,100,0),
(@PATH,9,209.0718,26.146828,26.627604,NULL,0,0,0,100,0),
(@PATH,10,215.35312,3.553464,28.625824,NULL,0,0,0,100,0),
(@PATH,11,211.31487,-9.173203,27.079954,NULL,0,0,0,100,0),
(@PATH,12,210.42763,-25.172428,26.591162,NULL,0,0,0,100,0),
(@PATH,13,212.88191,-30.137917,26.591192,NULL,0,0,0,100,0),
(@PATH,14,216.55647,-32.453876,26.591314,NULL,0,0,0,100,0),
(@PATH,15,226.7893,-32.321796,27.100355,NULL,0,0,0,100,0),
(@PATH,16,239.0565,-32.50906,26.59868,NULL,0,0,0,100,0),
(@PATH,17,226.7893,-32.321796,27.100355,NULL,0,0,0,100,0),
(@PATH,18,216.55647,-32.453876,26.591314,NULL,0,0,0,100,0),
(@PATH,19,212.88191,-30.137917,26.591192,NULL,0,0,0,100,0),
(@PATH,20,210.42763,-25.172428,26.591162,NULL,0,0,0,100,0),
(@PATH,21,211.31487,-9.173203,27.079954,NULL,0,0,0,100,0),
(@PATH,22,215.35312,3.553464,28.625824,NULL,0,0,0,100,0),
(@PATH,23,209.0718,26.146828,26.627604,NULL,0,0,0,100,0),
(@PATH,24,211.06705,32.123497,26.631569,NULL,0,0,0,100,0),
(@PATH,25,217.88676,33.820267,26.621796,NULL,0,0,0,100,0),
(@PATH,26,237.949,32.514015,26.632038,NULL,0,0,0,100,0),
(@PATH,27,257.8986,33.67169,13.394914,NULL,0,0,0,100,0),
(@PATH,28,266.3649,32.88496,13.436618,NULL,0,0,0,100,0),
(@PATH,29,268.90814,29.680952,13.439169,NULL,0,0,0,100,0),
(@PATH,30,269.36252,21.88547,13.4133215,NULL,0,0,0,100,0);
-- 0x204CB045C0120F4000016F000061BFFA .go xyz 268.32703 -3.305813 -0.0678567

-- Pathing for Auchenai Soulpriest Entry: 18493
SET @NPC := 83391;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=238.85509,`position_y`=-84.930984,`position_z`=26.591291 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,238.85509,-84.930984,26.591291,NULL,0,0,0,100,0),
(@PATH,2,239.11743,-51.329662,26.591269,NULL,0,0,0,100,0),
(@PATH,3,238.85509,-84.930984,26.591291,NULL,0,0,0,100,0),
(@PATH,4,239.11603,-118.809,26.59132,NULL,0,0,0,100,0),
(@PATH,5,239.11743,-51.329662,26.591269,NULL,0,0,0,100,0);
-- 0x204CB045C0120F4000016F0004E1BFFA .go xyz 238.85509 -84.930984 26.591291

UPDATE `creature` SET `id1`=18493 WHERE `id1`=18497 AND `guid` IN (83391, 83392);

-- Pathing for Auchenai Vindicator Entry: 18495
SET @NPC := 83392;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=166.70355,`position_y`=-163.66641,`position_z`=26.316566 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,166.70355,-163.66641,26.316566,NULL,0,0,0,100,0),
(@PATH,2,143.57632,-163.27176,12.563573,NULL,0,0,0,100,0),
(@PATH,3,122.65221,-163.04219,13.356737,NULL,0,0,0,100,0),
(@PATH,4,104.99422,-162.99231,14.774395,NULL,0,0,0,100,0),
(@PATH,5,81.24179,-163.2077,15.368842,NULL,0,0,0,100,0),
(@PATH,6,64.53549,-162.75394,15.386806,NULL,0,0,0,100,0),
(@PATH,7,48.272915,-162.58008,15.13582,NULL,0,0,0,100,0),
(@PATH,8,64.53549,-162.75394,15.386806,NULL,0,0,0,100,0),
(@PATH,9,81.24179,-163.2077,15.368842,NULL,0,0,0,100,0),
(@PATH,10,104.99422,-162.99231,14.774395,NULL,0,0,0,100,0),
(@PATH,11,122.65221,-163.04219,13.356737,NULL,0,0,0,100,0),
(@PATH,12,143.57632,-163.27176,12.563573,NULL,0,0,0,100,0);
-- 0x204CB045C0120FC000016F0001E1BFFA .go xyz 166.70355 -163.66641 26.316566

-- Pathing for Auchenai Soulpriest Entry: 18493
SET @NPC := 83405;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-105.24392,`position_y`=-388.10626,`position_z`=26.589207 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-105.24392,-388.10626,26.589207,NULL,0,0,0,100,0),
(@PATH,2,-121.20291,-388.12982,26.58856,NULL,0,0,0,100,0),
(@PATH,3,-139.48105,-387.83615,26.589808,NULL,0,0,0,100,0),
(@PATH,4,-143.4483,-384.72183,26.590303,NULL,0,0,0,100,0),
(@PATH,5,-144.98119,-375.0744,26.59283,NULL,0,0,0,100,0),
(@PATH,6,-144.88542,-342.67935,26.591034,NULL,0,0,0,100,0),
(@PATH,7,-144.98119,-375.0744,26.59283,NULL,0,0,0,100,0),
(@PATH,8,-143.4483,-384.72183,26.590303,NULL,0,0,0,100,0),
(@PATH,9,-139.48105,-387.83615,26.589808,NULL,0,0,0,100,0),
(@PATH,10,-121.20291,-388.12982,26.58856,NULL,0,0,0,100,0);
-- 0x203B1C45C0120F400006ED0001E1DDF1 .go xyz -105.24392 -388.10626 26.589207

-- Pathing for Auchenai Monk Entry: 18497
SET @NPC := 83404;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=222.74164,`position_y`=13.925282,`position_z`=-0.070625804 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,222.74164,13.925282,-0.070625804,NULL,12000,0,0,100,0),
(@PATH,2,238.14801,13.610128,-0.06791845,NULL,12000,0,0,100,0);
-- 0x203B1C45C01210400006ED0002E1DDF1 .go xyz 222.74164 13.925282 -0.070625804

-- Emote State for Monks near Shirrak
DELETE FROM `creature_addon` WHERE (`guid` IN (83395, 83394, 83407, 83409));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(83395, 0, 0, 0, 1, 375, 0, NULL),
(83407, 0, 0, 0, 1, 375, 0, NULL),
(83394, 0, 0, 0, 1, 375, 0, NULL),
(83409, 0, 0, 0, 1, 375, 0, NULL);

-- Delete redundant waypoints
DELETE FROM `waypoint_data` WHERE `id` IN (83374, 83385, 83378, 83406, 83372);
DELETE FROM `creature_addon` WHERE `guid` IN (83374*10, 83385*10, 83378*10, 83406*10, 83372*10);
UPDATE `creature` SET `wander_distance`=0, `MovementType`=0 WHERE `guid` IN (83374, 83385, 83378, 83406, 83372) AND `map`=558;

-- Patrolling Formations
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (83405, 83392, 83386, 83391) AND `memberGUID` IN (83405, 83374, 83392, 83385, 83378, 83386, 83406, 83391, 83372);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(83405, 83405, 0, 0, 3),
(83405, 83374, 3.5, 90, 515),
(83392, 83392, 0, 0, 3),
(83392, 83385, 4, 135, 515),
(83392, 83378, 4, 225, 515),
(83386, 83386, 0, 0, 3),
(83386, 83406, 3.5, 180, 515),
(83391, 83391, 0, 0, 3),
(83391, 83372, 3.5, 180, 515);

-- Static Formations
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (83352,83360,83368,83369,83373,83375,83380,83382,83384,83393,83394,83395,83396,83400,83415,83416,83423,83426,83427,83429,83356,83358) AND `memberGUID` IN (83352,83353,83360,83361,83368,83369,83371,83373,83375,83376,83377,83380,83381,83382,83384,83387,83389,83393,83394,83395,83396,83397,83398,83399,83400,83401,83402,83403,83404,83407,83408,83409,83410,83411,83412,83413,83414,83415,83416,83417,83418,83419,83420,83421,83422,83423,83424,83425,83426,83427,83428,83429,83430,83431,83432,83433,83434,83435,83436,83437,83438,83439,83440,83441,83442,83443,83444,83445,83446,83447,83448,83449,83450,83451,83452,88277,88278,88279,88280,88281,88283,88284,88285,88286,88287,88288,88289,88290,88291,83356,83357,83358,83363);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(83358, 83358, 0, 0, 3),
(83358, 83363, 0, 0, 3),
(83352, 83352, 0, 0, 3),
(83352, 83353, 0, 0, 3),
(83356, 83356, 0, 0, 3),
(83356, 83357, 0, 0, 3),
(83360, 83360, 0, 0, 3),
(83360, 83361, 0, 0, 3),
(83369, 83369, 0, 0, 3),
(83369, 83376, 0, 0, 3),
(83375, 83375, 0, 0, 3),
(83375, 83377, 0, 0, 3),
(83368, 83368, 0, 0, 3),
(83368, 83371, 0, 0, 3),
(83382, 83382, 0, 0, 3),
(83382, 83389, 0, 0, 3),
(83373, 83373, 0, 0, 3),
(83373, 83381, 0, 0, 3),
(83380, 83380, 0, 0, 3),
(83380, 83404, 0, 0, 3),
(83384, 83384, 0, 0, 3),
(83384, 83387, 0, 0, 3),
(83384, 83408, 0, 0, 3),
(83395, 83395, 0, 0, 3),
(83395, 83407, 0, 0, 3),
(83394, 83394, 0, 0, 3),
(83394, 83409, 0, 0, 3),
(83393, 83393, 0, 0, 3),
(83393, 83401, 0, 0, 3),
(83393, 83403, 0, 0, 3),
(83393, 83410, 0, 0, 3),
(83396, 83396, 0, 0, 3),
(83396, 83402, 0, 0, 3),
(83396, 83398, 0, 0, 3),
(83396, 83397, 0, 0, 3),
(83396, 83399, 0, 0, 3),
(83400, 83400, 0, 0, 3),
(83400, 83414, 0, 0, 3),
(83400, 83413, 0, 0, 3),
(83400, 83412, 0, 0, 3),
(83400, 83411, 0, 0, 3),
(83429, 83429, 0, 0, 3),
(83429, 83430, 0, 0, 3),
(83429, 83435, 0, 0, 3),
(83429, 83434, 0, 0, 3),
(83429, 83439, 0, 0, 3),
(83429, 83452, 0, 0, 3),
(83423, 83423, 0, 0, 3),
(83423, 83431, 0, 0, 3),
(83423, 83436, 0, 0, 3),
(83423, 83437, 0, 0, 3),
(83423, 83443, 0, 0, 3),
(83423, 83445, 0, 0, 3),
(83423, 83442, 0, 0, 3),
(83423, 83444, 0, 0, 3),
(83423, 83440, 0, 0, 3),
(83423, 88291, 0, 0, 3),
(83423, 83448, 0, 0, 3),
(83423, 83441, 0, 0, 3),
(83415, 83415, 0, 0, 3),
(83415, 83417, 0, 0, 3),
(83415, 83422, 0, 0, 3),
(83415, 83418, 0, 0, 3),
(83415, 83419, 0, 0, 3),
(83415, 83424, 0, 0, 3),
(83415, 83425, 0, 0, 3),
(83415, 83421, 0, 0, 3),
(83415, 83433, 0, 0, 3),
(83415, 83420, 0, 0, 3),
(83426, 83426, 0, 0, 3),
(83426, 88278, 0, 0, 3),
(83426, 83428, 0, 0, 3),
(83426, 83438, 0, 0, 3),
(83426, 83432, 0, 0, 3),
(83416, 83416, 0, 0, 3),
(83416, 88279, 0, 0, 3),
(83416, 88286, 0, 0, 3),
(83416, 88280, 0, 0, 3),
(83416, 88290, 0, 0, 3),
(83416, 88289, 0, 0, 3),
(83416, 88281, 0, 0, 3),
(83416, 88284, 0, 0, 3),
(83416, 88285, 0, 0, 3),
(83416, 88288, 0, 0, 3),
(83416, 88287, 0, 0, 3),
(83416, 88283, 0, 0, 3),
(83427, 83427, 0, 0, 3),
(83427, 83451, 0, 0, 3),
(83427, 88277, 0, 0, 3),
(83427, 83449, 0, 0, 3),
(83427, 83447, 0, 0, 3),
(83427, 83450, 0, 0, 3),
(83427, 83446, 0, 0, 3);

-- Remove assistance from Reanimated Bones
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|33554432 WHERE `entry` = 18700;

-- Condition for Blue Beam (32930)
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 32930) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 18778) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 32930, 0, 0, 31, 0, 3, 18778, 0, 0, 0, 0, '', 'Blue Beam (32930) can only target Cosmetic Raging Soul (18778)');

-- Use waypoint_scripts to script the 
SET @NPC := 83375;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,131.563,-19.3444,6.32334,5.95491,2147483647,0,493,100,0);
SET @NPC := 83377;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,135.284,-27.3773,9.91618,0.999043,2147483647,0,493,100,0);

-- DELETE creature Pools and replace with id2
DELETE FROM `pool_template` WHERE `description` LIKE '%auchenai%' AND `entry` BETWEEN 1500 AND 1509;
DELETE FROM `pool_creature` WHERE `description` LIKE '%auchenai%' AND `pool_entry` BETWEEN 1500 AND 1509;
DELETE FROM `creature` WHERE `guid` IN (83355,83354,83365,83359,83364,83362,83366,83351,83367,83370) AND `id1`=18495 AND `map`=558;
DELETE FROM `creature_addon` WHERE `guid` IN (83355,83354,83365,83359,83364,83362,83366,83351,83367,83370);
DELETE FROM `linked_respawn` WHERE `guid` IN (83351,83354,83355,83359,83362,83364,83365,83366,83367,83370) AND `linkedGuid`=83388 AND `linkType`=0;
UPDATE `creature` SET `id2`=18495 WHERE `guid` IN (83363,83358,83353,83352,83360,83361,83356,83357,83368,83371) AND `id1`=18493 AND `map`=558;

DELETE FROM `waypoint_scripts` WHERE `id` IN (491, 492, 493) AND `command`=15 AND `guid` IN (18559, 18560, 18561);
INSERT INTO `waypoint_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `guid`) VALUES
(491, 0, 15, 33422, 1, 18559),
(492, 0, 15, 32754, 1, 18560),
(493, 0, 15, 32930, 1, 18561);

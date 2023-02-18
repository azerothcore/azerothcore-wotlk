-- DB update 2022_11_21_00 -> 2022_11_21_01
-- Pandemonius movement
UPDATE `creature` SET `MovementType`=1, `wander_distance`=4.5 WHERE `guid`=91163 AND `id1`=18341;

-- Delete 2 extra Arcane Fiend creatures (are supposed to be summons)
DELETE FROM `creature` WHERE `guid` IN (91245, 91246) AND `id1`=18429 AND `map`=557;
DELETE FROM `linked_respawn` WHERE `guid` IN (91245, 91246) AND `linkedGuid`=91163;

-- Delete redundant waypoints
DELETE FROM `waypoint_data` WHERE `id` IN (83302*10, 83315*10, 91241*10, 91216*10, 83345*10, 91173*10);
DELETE FROM `creature_addon` WHERE `guid` IN (83302, 83315, 91241, 91216, 83345, 91173);
UPDATE `creature` SET `MovementType`=0 WHERE `guid` IN (83302, 83315, 91241, 91216, 83345, 91173) AND `map`=557;

-- Patrolling Formations
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (83301,83320,83329,83344,91172,91202,91215,91240) AND `memberGUID` IN (83301,83302,83315,83320,83329,83330,83331,83344,83345,91172,91173,91202,91203,91215,91216,91240,91241);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(83301, 83301, 0, 0, 3),
(83301, 83302, 3, 90, 515),
(83320, 83320, 0, 0, 3),
(83320, 83315, 4, 90, 515),
(91215, 91215, 0, 0, 3),
(91215, 91216, 4.5, 90, 515),
(91240, 91240, 0, 0, 3),
(91240, 91241, 4.5, 90, 515),
(83344, 83344, 0, 0, 3),
(83344, 83345, 3.5, 90, 515),
(83329, 83329, 0, 0, 3),
(83329, 83330, 2.5, 120, 515),
(83329, 83331, 2.5, 240, 515),
(91172, 91172, 0, 0, 3),
(91172, 91173, 2.5, 90, 515),
(91202, 91202, 0, 0, 3),
(91202, 91203, 3.5, 90, 515);

-- Static Formations
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (83304,83306,83309,83311,83314,83316,83332,83335,83338,83340,83347,86396,91124,91134,91139,91151,91154,91164,91167,91174,91179,91182,91186,91188,91197,91204,91208,91212,91218,91223,91226,91231,91238,91242) AND `memberGUID` IN (83304,83305,83306,83307,83309,83310,83311,83312,83313,83314,83316,83317,83318,83319,83321,83332,83333,83335,83336,83338,83339,83340,83341,83342,83343,83347,83348,86396,91121,91122,91124,91125,91126,91134,91135,91136,91137,91138,91139,91140,91141,91142,91143,91151,91152,91153,91154,91155,91156,91164,91165,91166,91167,91168,91169,91170,91174,91175,91176,91179,91180,91182,91183,91184,91186,91187,91188,91189,91190,91197,91198,91199,91200,91204,91205,91206,91208,91209,91210,91212,91213,91214,91218,91219,91220,91221,91222,91223,91224,91225,91226,91227,91228,91229,91231,91232,91233,91238,91239,91242,91243,91244) AND `groupAI`=3;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(83304, 83304, 0, 0, 3),
(83304, 83305, 0, 0, 3),
(83306, 83306, 0, 0, 3),
(83306, 83307, 0, 0, 3),
(83311, 83311, 0, 0, 3),
(83311, 83312, 0, 0, 3),
(83311, 83313, 0, 0, 3),
(83314, 83314, 0, 0, 3),
(83314, 83319, 0, 0, 3),
(83314, 83321, 0, 0, 3),
(83316, 83316, 0, 0, 3),
(83316, 83317, 0, 0, 3),
(83316, 83318, 0, 0, 3),
(83309, 83309, 0, 0, 3),
(83309, 83310, 0, 0, 3),
(91238, 91238, 0, 0, 3),
(91238, 91239, 0, 0, 3),
(91226, 91226, 0, 0, 3),
(91226, 91227, 0, 0, 3),
(91226, 91228, 0, 0, 3),
(91226, 91229, 0, 0, 3),
(91242, 91242, 0, 0, 3),
(91242, 91243, 0, 0, 3),
(91242, 91244, 0, 0, 3),
(91154, 91154, 0, 0, 3),
(91154, 91155, 0, 0, 3),
(91154, 91156, 0, 0, 3),
(91218, 91218, 0, 0, 3),
(91218, 91219, 0, 0, 3),
(91218, 91220, 0, 0, 3),
(91218, 91221, 0, 0, 3),
(91218, 91222, 0, 0, 3),
(91223, 91223, 0, 0, 3),
(91223, 91224, 0, 0, 3),
(91223, 91225, 0, 0, 3),
(91212, 91212, 0, 0, 3),
(91212, 91213, 0, 0, 3),
(91212, 91214, 0, 0, 3),
(91151, 91151, 0, 0, 3),
(91151, 91152, 0, 0, 3),
(91151, 91153, 0, 0, 3),
(91208, 91208, 0, 0, 3),
(91208, 91209, 0, 0, 3),
(91208, 91210, 0, 0, 3),
(83340, 83340, 0, 0, 3),
(83340, 83341, 0, 0, 3),
(83340, 83342, 0, 0, 3),
(83340, 83343, 0, 0, 3),
(91124, 91124, 0, 0, 3),
(91124, 91125, 0, 0, 3),
(91124, 91126, 0, 0, 3),
(91188, 91188, 0, 0, 3),
(91188, 91189, 0, 0, 3),
(91188, 91190, 0, 0, 3),
(91186, 91186, 0, 0, 3),
(91186, 91187, 0, 0, 3),
(83347, 83347, 0, 0, 3),
(83347, 83348, 0, 0, 3),
(86396, 86396, 0, 0, 3),
(86396, 91121, 0, 0, 3),
(86396, 91122, 0, 0, 3),
(83338, 83338, 0, 0, 3),
(83338, 83339, 0, 0, 3),
(91231, 91231, 0, 0, 3),
(91231, 91232, 0, 0, 3),
(91231, 91233, 0, 0, 3),
(83335, 83335, 0, 0, 3),
(83335, 83336, 0, 0, 3),
(83332, 83332, 0, 0, 3),
(83332, 83333, 0, 0, 3),
(91164, 91164, 0, 0, 3),
(91164, 91165, 0, 0, 3),
(91164, 91166, 0, 0, 3),
(91179, 91179, 0, 0, 3),
(91179, 91180, 0, 0, 3),
(91182, 91182, 0, 0, 3),
(91182, 91183, 0, 0, 3),
(91182, 91184, 0, 0, 3),
(91174, 91174, 0, 0, 3),
(91174, 91175, 0, 0, 3),
(91174, 91176, 0, 0, 3),
(91167, 91167, 0, 0, 3),
(91167, 91168, 0, 0, 3),
(91167, 91169, 0, 0, 3),
(91167, 91170, 0, 0, 3),
(91204, 91204, 0, 0, 3),
(91204, 91205, 0, 0, 3),
(91204, 91206, 0, 0, 3),
(91197, 91197, 0, 0, 3),
(91197, 91198, 0, 0, 3),
(91197, 91199, 0, 0, 3),
(91197, 91200, 0, 0, 3),
(91134, 91134, 0, 0, 3),
(91134, 91135, 0, 0, 3),
(91134, 91136, 0, 0, 3),
(91134, 91137, 0, 0, 3),
(91134, 91138, 0, 0, 3),
(91139, 91139, 0, 0, 3),
(91139, 91140, 0, 0, 3),
(91139, 91141, 0, 0, 3),
(91139, 91142, 0, 0, 3),
(91139, 91143, 0, 0, 3);

-- Pathing for Ethereal Scavenger Entry: 18309
SET @NPC := 83301;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-67.99796,`position_y`=-31.6907,`position_z`=-0.95160854 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-67.99796,-31.6907,-0.95160854,NULL,0,0,0,100,0),
(@PATH,2,-67.722946,-23.282206,-0.9526021,NULL,0,0,0,100,0),
(@PATH,3,-65.677895,-14.919224,-0.9472823,NULL,0,0,0,100,0),
(@PATH,4,-60.18082,-8.535985,-0.9498009,NULL,0,0,0,100,0),
(@PATH,5,-53.91151,-2.550814,-0.9489452,NULL,0,0,0,100,0),
(@PATH,6,-46.68223,0.860986,-0.954333,NULL,0,0,0,100,0),
(@PATH,7,-36.528965,1.502573,-0.9543326,NULL,0,0,0,100,0),
(@PATH,8,-46.68223,0.860986,-0.954333,NULL,0,0,0,100,0),
(@PATH,9,-53.91151,-2.550814,-0.9489452,NULL,0,0,0,100,0),
(@PATH,10,-60.18082,-8.535985,-0.9498009,NULL,0,0,0,100,0),
(@PATH,11,-65.677895,-14.919224,-0.9472823,NULL,0,0,0,100,0),
(@PATH,12,-67.722946,-23.282206,-0.9526021,NULL,0,0,0,100,0);
-- 0x204CB045A011E14000016E000061BBA0 .go xyz -67.99796 -31.6907 -0.95160854

-- Pathing for Ethereal Crypt Raider Entry: 18311
SET @NPC := 83320;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-92.177826,`position_y`=-103.64098,`position_z`=-0.74659944 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-92.177826,-103.64098,-0.74659944,NULL,0,0,0,100,0),
(@PATH,2,-81.34098,-109.3567,-0.49348852,NULL,0,0,0,100,0),
(@PATH,3,-67.74865,-113.65243,-0.77221966,NULL,0,0,0,100,0),
(@PATH,4,-53.918705,-109.43329,-0.31681725,NULL,0,0,0,100,0),
(@PATH,5,-41.28598,-103.35104,-2.4145072,NULL,0,0,0,100,0),
(@PATH,6,-47.81088,-89.45784,-2.09733,NULL,0,0,0,100,0),
(@PATH,7,-57.606106,-82.09547,-2.1152492,NULL,0,0,0,100,0),
(@PATH,8,-68.259636,-79.06529,-2.1130235,NULL,0,0,0,100,0),
(@PATH,9,-80.90324,-84.25588,-1.9863526,NULL,0,0,0,100,0),
(@PATH,10,-87.42079,-91.58448,-1.9592229,NULL,0,0,0,100,0);
-- 0x204CB045A011E1C000016E0001E1BBA1 .go xyz -92.177826 -103.64098 -0.74659944

-- Pathing for Ethereal Priest Entry: 18317
SET @NPC := 91215;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-111.1761,`position_y`=-219.2728,`position_z`=-0.15511577 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-111.1761,-219.2728,-0.15511577,NULL,0,0,0,100,0),
(@PATH,2,-118.24131,-209.97723,-0.6744533,NULL,0,0,0,100,0),
(@PATH,3,-136.36037,-214.06665,-0.44854826,NULL,0,0,0,100,0),
(@PATH,4,-143.3705,-220.97308,-0.5329385,NULL,0,0,0,100,0),
(@PATH,5,-136.36037,-214.06665,-0.44854826,NULL,0,0,0,100,0),
(@PATH,6,-118.24131,-209.97723,-0.6744533,NULL,0,0,0,100,0);
-- 0x204CB045A011E34000016E000361BBA1 .go xyz -111.1761 -219.2728 -0.15511577

-- Pathing for Ethereal Priest Entry: 18317
SET @NPC := 91240;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-32.762417,`position_y`=-223.56038,`position_z`=-0.17517364 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-32.762417,-223.56038,-0.17517364,NULL,1500,0,0,100,0),
(@PATH,2,-49.952377,-221.03786,-0.064427994,NULL,0,0,0,100,0),
(@PATH,3,-73.87033,-218.72505,-0.17712496,NULL,1500,0,0,100,0),
(@PATH,4,-49.952377,-221.03786,-0.064427994,NULL,0,0,0,100,0);
-- 0x204CB045A011E34000016E0004E1BBA1 .go xyz -32.762417 -223.56038 -0.17517364

-- Pathing for Ethereal Darkcaster Entry: 18331
SET @NPC := 83344;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-209.60197,`position_y`=-245.24097,`position_z`=-0.9562541 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-209.60197,-245.24097,-0.9562541,NULL,0,0,0,100,0),
(@PATH,2,-205.8458,-226.60881,-0.95540786,NULL,0,0,0,100,0),
(@PATH,3,-208.29887,-210.52136,0.94156444,NULL,0,0,0,100,0),
(@PATH,4,-216.36972,-203.34883,0.37871146,NULL,0,0,0,100,0),
(@PATH,5,-233.01859,-196.29713,-0.9522191,NULL,0,0,0,100,0),
(@PATH,6,-216.36972,-203.34883,0.37871146,NULL,0,0,0,100,0),
(@PATH,7,-208.29887,-210.52136,0.94156444,NULL,0,0,0,100,0),
(@PATH,8,-205.8458,-226.60881,-0.95540786,NULL,0,0,0,100,0);
-- 0x204CB045A011E6C000016E000261BBA1 .go xyz -209.60197 -245.24097 -0.9562541

-- Pathing for Ethereal Sorcerer Entry: 18313
SET @NPC := 83329;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-373.551,`position_y`=-189.40958,`position_z`=-1.0002968 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-373.551,-189.40958,-1.0002968,NULL,1000,0,0,100,0),
(@PATH,2,-373.39856,-215.54378,-0.95794463,NULL,0,0,0,100,0),
(@PATH,3,-373.33087,-235.899,-0.9565815,NULL,1000,0,0,100,0),
(@PATH,4,-373.39856,-215.54378,-0.95794463,NULL,0,0,0,100,0);
-- 0x204CB045A011E24000016E0005E1BBA1 .go xyz -373.551 -189.40958 -1.0002968

-- Pathing for Nexus Stalker Entry: 18314
SET @NPC := 91172;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-383.9432,`position_y`=-171.95404,`position_z`=-0.9587667 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-383.9432,-171.95404,-0.9587667,NULL,0,0,0,100,0),
(@PATH,2,-374.7526,-176.95155,-0.95391774,NULL,0,0,0,100,0),
(@PATH,3,-365.67285,-175.00563,-0.958769,NULL,0,0,0,100,0),
(@PATH,4,-360.13977,-165.7273,-0.99950916,NULL,0,0,0,100,0),
(@PATH,5,-363.37717,-158.51936,-0.95876485,NULL,0,0,0,100,0),
(@PATH,6,-370.46817,-152.6236,-0.9587616,NULL,0,0,0,100,0),
(@PATH,7,-378.27777,-155.3499,-0.9587637,NULL,0,0,0,100,0),
(@PATH,8,-384.86395,-163.05305,-0.9499411,NULL,0,0,0,100,0);
-- 0x204CB045A011E28000016E000161BBA1 .go xyz -383.9432 -171.95404 -0.9587667

-- Pathing for Ethereal Spellbinder Entry: 18312
SET @NPC := 91202;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-260.95892,`position_y`=7.860175,`position_z`=16.785763 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-260.95892,7.860175,16.785763,NULL,0,0,0,100,0),
(@PATH,2,-276.80426,5.122873,16.787043,NULL,0,0,0,100,0),
(@PATH,3,-299.9862,5.538398,16.78952,NULL,0,0,0,100,0),
(@PATH,4,-320.11002,7.972475,16.793024,NULL,0,0,0,100,0),
(@PATH,5,-299.9862,5.538398,16.78952,NULL,0,0,0,100,0),
(@PATH,6,-276.80426,5.122873,16.787043,NULL,0,0,0,100,0);
-- 0x204CB045A011E20000016E000061BBA1 .go xyz -260.95892 7.860175 16.785763

-- Pathing for Nexus Terror Entry: 19307
SET @NPC := 91194;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-246.69841,`position_y`=9.225306,`position_z`=16.794334 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-246.69841,9.225306,16.794334,NULL,0,0,0,100,0),
(@PATH,2,-231.31323,9.442994,16.808558,NULL,0,0,0,100,0),
(@PATH,3,-214.384,9.683906,16.860193,NULL,0,0,0,100,0),
(@PATH,4,-231.31323,9.442994,16.808558,NULL,0,0,0,100,0);
-- 0x204CB045A012DAC000016E0001E1BBA1 .go xyz -246.69841 9.225306 16.794334

-- Pathing for Nexus Terror Entry: 19307
SET @NPC := 91201;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-283.24142,`position_y`=-4.002039,`position_z`=16.685318 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-283.24142,-4.002039,16.685318,NULL,0,0,0,100,0),
(@PATH,2,-286.58047,2.692342,16.787771,NULL,0,0,0,100,0),
(@PATH,3,-286.7902,15.48573,18.410303,NULL,0,0,0,100,0),
(@PATH,4,-275.94824,25.733856,22.140972,NULL,0,0,0,100,0),
(@PATH,5,-286.72964,15.542957,18.451094,NULL,0,0,0,100,0),
(@PATH,6,-286.58047,2.692342,16.787771,NULL,0,0,0,100,0);
-- 0x204CB045A012DAC000016E000161BBA1 .go xyz -283.24142 -4.002039 16.685318

-- Delete old nodes and pools
DELETE FROM `pool_template` WHERE `entry` IN (2034, 11709) AND `description` LIKE '%Mana-Tomb%';
DELETE FROM `pool_pool` WHERE `mother_pool`=2034 AND `pool_id`=11709 AND `description` LIKE '%Mana-Tomb%';
DELETE FROM `pool_gameobject` WHERE `pool_entry`=11709 AND `guid` IN (43147, 63197);
DELETE FROM `gameobject` WHERE `id` IN (181556, 181557, 181569, 181278) AND `map`=557;

SET @GUID := 104466;
SET @POOL := 13326;
SET @POOLMOTHER := 8320;

DELETE FROM `gameobject` WHERE `id` IN (181556, 181557, 181569, 181278) AND `map`=557 AND `ZoneId`=3792 AND `guid` BETWEEN @GUID+0 AND @GUID+47;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(@GUID+0 , 181278, 557, 3792, 3792, 3, 1, -105.552, -58.9405, -0.821702, 5.46288, 0, 0, -0.398748, 0.91706, 86400, 255, 1, '', 46597),
(@GUID+1 , 181278, 557, 3792, 3792, 3, 1, -95.3467, -108.357, -0.842384, 1.62316, 0, 0, 0.725374, 0.688355, 86400, 255, 1, '', 46597),
(@GUID+2 , 181278, 557, 3792, 3792, 3, 1, -110.722, -193.438, -1.06178, 0, 0, 0, 0, 1, 86400, 255, 1, '', 46597),
(@GUID+3 , 181278, 557, 3792, 3792, 3, 1, -107.263, -249.694, -0.657617, 4.95674, 0, 0, -0.615661, 0.788011, 86400, 255, 1, '', 46597),
(@GUID+4 , 181278, 557, 3792, 3792, 3, 1, -228.783, -221.596, -1.10903, 5.20108, 0, 0, -0.515038, 0.857168, 86400, 255, 1, '', 46597),
(@GUID+5 , 181278, 557, 3792, 3792, 3, 1, -254.457, -177.219, -0.953286, 3.29869, 0, 0, -0.996917, 0.0784664, 86400, 255, 1, '', 46597),
(@GUID+6 , 181278, 557, 3792, 3792, 3, 1, -256.032, -152.779, -0.953339, 0.645772, 0, 0, 0.317305, 0.948324, 86400, 255, 1, '', 46597),
(@GUID+7 , 181278, 557, 3792, 3792, 3, 1, -284.843, -166.549, -2.71548, 4.5204, 0, 0, -0.771625, 0.636078, 86400, 255, 1, '', 46597),
(@GUID+8 , 181278, 557, 3792, 3792, 3, 1, -291.378, -206.457, -2.54264, -2.07694, 0, 0, 0, 1, 86400, 255, 1, '', 0),
(@GUID+9 , 181278, 557, 3792, 3792, 3, 1, -378.636, -241.698, -0.956422, 4.11898, 0, 0, -0.882947, 0.469473, 86400, 255, 1, '', 46597),
(@GUID+10, 181278, 557, 3792, 3792, 3, 1, -379.233, -219.094, -0.957844, 4.76475, 0, 0, -0.688354, 0.725374, 86400, 255, 1, '', 46597),
(@GUID+11, 181278, 557, 3792, 3792, 3, 1, -353.598, -179.432, -0.966642, 1.11701, 0, 0, 0.529919, 0.848048, 86400, 255, 1, '', 46597),
(@GUID+12, 181278, 557, 3792, 3792, 3, 1, -400.56, -172.333, -0.98123, 3.50812, 0, 0, -0.983254, 0.182238, 86400, 255, 1, '', 46597),
(@GUID+13, 181278, 557, 3792, 3792, 3, 1, -367.253, -132.678, -0.966903, 1.58825, 0, 0, 0.71325, 0.70091, 86400, 255, 1, '', 46597),
(@GUID+14, 181278, 557, 3792, 3792, 3, 1, -393.554, -60.8607, -0.982428, 6.03884, 0, 0, -0.121869, 0.992546, 86400, 255, 1, '', 46597),
(@GUID+15, 181278, 557, 3792, 3792, 3, 1, -350.483, -60.3347, -0.974565, 0.925024, 0, 0, 0.446198, 0.894935, 86400, 255, 1, '', 46597),
(@GUID+16, 181278, 557, 3792, 3792, 3, 1, -379.956, -41.4283, -0.967236, 4.08407, 0, 0, -0.891006, 0.453991, 86400, 255, 1, '', 46597),
(@GUID+17, 181278, 557, 3792, 3792, 3, 1, -283.552, -10.902, 16.685, 1.78024, 0, 0, 0.777146, 0.62932, 86400, 255, 1, '', 0),
(@GUID+18, 181278, 557, 3792, 3792, 3, 1, -255.582, 3.04984, 16.7849, 4.4855, 0, 0, -0.782608, 0.622515, 86400, 255, 1, '', 46597),
(@GUID+19, 181278, 557, 3792, 3792, 3, 1, -217.485, -6.14751, 16.7275, 5.91667, 0, 0, -0.182235, 0.983255, 86400, 255, 1, '', 46597),
(@GUID+20, 181278, 557, 3792, 3792, 3, 1, -220.683, 29.1267, 16.7317, 4.15388, 0, 0, -0.874619, 0.48481, 86400, 255, 1, '', 46597),
(@GUID+21, 181556, 557, 3792, 3792, 3, 1, -369.378, -242.433, 1.87701, 2.84488, 0, 0, 0.989016, 0.147811, 86400, 255, 1, '', 46597),
(@GUID+24, 181556, 557, 3792, 3792, 3, 1, -354.641, -150.547, 3.43339, 5.3058, 0, 0, -0.469471, 0.882948, 86400, 255, 1, '', 46597),
(@GUID+27, 181556, 557, 3792, 3792, 3, 1, -417.15, -166.794, 0.833513, 0.122173, 0, 0, 0, 1, 86400, 255, 1, '', 0),
(@GUID+30, 181556, 557, 3792, 3792, 3, 1, -358.643, -85.6369, 2.8462, 3.87463, 0, 0, -0.93358, 0.358368, 86400, 255, 1, '', 46597),
(@GUID+33, 181556, 557, 3792, 3792, 3, 1, -390.365, -85.0705, 2.39504, 4.66003, 0, 0, -0.725374, 0.688355, 86400, 255, 1, '', 46597),
(@GUID+22, 181557, 557, 3792, 3792, 3, 1, -369.378, -242.433, 1.87701, 2.84488, 0, 0, 0.989016, 0.147811, 86400, 255, 1, '', 46597),
(@GUID+25, 181557, 557, 3792, 3792, 3, 1, -354.641, -150.547, 3.43339, 5.3058, 0, 0, -0.469471, 0.882948, 86400, 255, 1, '', 46597),
(@GUID+28, 181557, 557, 3792, 3792, 3, 1, -417.15, -166.794, 0.833513, 0.122173, 0, 0, 0, 1, 86400, 255, 1, '', 0),
(@GUID+31, 181557, 557, 3792, 3792, 3, 1, -358.643, -85.6369, 2.8462, 3.87463, 0, 0, -0.93358, 0.358368, 86400, 255, 1, '', 46597),
(@GUID+34, 181557, 557, 3792, 3792, 3, 1, -390.365, -85.0705, 2.39504, 4.66003, 0, 0, -0.725374, 0.688355, 86400, 255, 1, '', 46597),
(@GUID+23, 181569, 557, 3792, 3792, 3, 1, -369.378, -242.433, 1.87701, 2.84488, 0, 0, 0.989016, 0.147811, 86400, 255, 1, '', 46597),
(@GUID+26, 181569, 557, 3792, 3792, 3, 1, -354.641, -150.547, 3.43339, 5.3058, 0, 0, -0.469471, 0.882948, 86400, 255, 1, '', 46597),
(@GUID+29, 181569, 557, 3792, 3792, 3, 1, -417.15, -166.794, 0.833513, 0.122173, 0, 0, 0, 1, 86400, 255, 1, '', 0),
(@GUID+32, 181569, 557, 3792, 3792, 3, 1, -358.643, -85.6369, 2.8462, 3.87463, 0, 0, -0.93358, 0.358368, 86400, 255, 1, '', 46597),
(@GUID+35, 181569, 557, 3792, 3792, 3, 1, -390.365, -85.0705, 2.39504, 4.66003, 0, 0, -0.725374, 0.688355, 86400, 255, 1, '', 46597),
(@GUID+36, 181556, 557, 3792, 3792, 3, 1, -329.146, -69.739, 0.956257, 3.31614, 0, 0, -0.996194, 0.087165, 86400, 255, 1, '', 46597),
(@GUID+39, 181556, 557, 3792, 3792, 3, 1, -306.768, 18.0337, 15.934, 5.49779, 0, 0, -0.382683, 0.92388, 86400, 255, 1, '', 46597),
(@GUID+42, 181556, 557, 3792, 3792, 3, 1, -245.643, -3.16959, 15.0684, 5.96903, 0, 0, -0.156434, 0.987688, 86400, 255, 1, '', 46597),
(@GUID+45, 181556, 557, 3792, 3792, 3, 1, -269.036, 42.9415, 30.2597, 5.84685, 0, 0, -0.216439, 0.976296, 86400, 255, 1, '', 46597),
(@GUID+37, 181557, 557, 3792, 3792, 3, 1, -329.146, -69.739, 0.956257, 3.31614, 0, 0, -0.996194, 0.087165, 86400, 255, 1, '', 46597),
(@GUID+40, 181557, 557, 3792, 3792, 3, 1, -306.768, 18.0337, 15.934, 5.49779, 0, 0, -0.382683, 0.92388, 86400, 255, 1, '', 46597),
(@GUID+43, 181557, 557, 3792, 3792, 3, 1, -245.643, -3.16959, 15.0684, 5.96903, 0, 0, -0.156434, 0.987688, 86400, 255, 1, '', 46597),
(@GUID+46, 181557, 557, 3792, 3792, 3, 1, -269.036, 42.9415, 30.2597, 5.84685, 0, 0, -0.216439, 0.976296, 86400, 255, 1, '', 46597),
(@GUID+38, 181569, 557, 3792, 3792, 3, 1, -329.146, -69.739, 0.956257, 3.31614, 0, 0, -0.996194, 0.087165, 86400, 255, 1, '', 46597),
(@GUID+41, 181569, 557, 3792, 3792, 3, 1, -306.768, 18.0337, 15.934, 5.49779, 0, 0, -0.382683, 0.92388, 86400, 255, 1, '', 46597),
(@GUID+44, 181569, 557, 3792, 3792, 3, 1, -245.643, -3.16959, 15.0684, 5.96903, 0, 0, -0.156434, 0.987688, 86400, 255, 1, '', 46597),
(@GUID+47, 181569, 557, 3792, 3792, 3, 1, -269.036, 42.9415, 30.2597, 5.84685, 0, 0, -0.216439, 0.976296, 86400, 255, 1, '', 46597);

DELETE FROM `pool_template` WHERE `description` LIKE '%Mana-Tombs%' AND `entry` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+5;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOLMOTHER+0, 1, 'Mana-Tombs - Ancient Lichen - Group 1'),
(@POOLMOTHER+1, 1, 'Mana-Tombs - Ancient Lichen - Group 2'),
(@POOLMOTHER+2, 1, 'Mana-Tombs - Ancient Lichen - Group 3'),
(@POOLMOTHER+3, 1, 'Mana-Tombs - Ancient Lichen - Group 4'),
(@POOLMOTHER+4, 1, 'Mana-Tombs - Ores - Group 1'),
(@POOLMOTHER+5, 1, 'Mana-Tombs - Ores - Group 2');

DELETE FROM `pool_gameobject` WHERE `description` LIKE '%Mana-Tombs%' AND `guid` BETWEEN @GUID+0 AND @GUID+20 AND `pool_entry` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+3;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GUID+0 , @POOLMOTHER+0, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+1 , @POOLMOTHER+0, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+2 , @POOLMOTHER+0, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+3 , @POOLMOTHER+0, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+4 , @POOLMOTHER+1, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+5 , @POOLMOTHER+1, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+6 , @POOLMOTHER+1, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+7 , @POOLMOTHER+1, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+8 , @POOLMOTHER+1, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+9 , @POOLMOTHER+2, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+10, @POOLMOTHER+2, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+11, @POOLMOTHER+2, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+12, @POOLMOTHER+2, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+13, @POOLMOTHER+2, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+14, @POOLMOTHER+2, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+15, @POOLMOTHER+3, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+16, @POOLMOTHER+3, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+17, @POOLMOTHER+3, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+18, @POOLMOTHER+3, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+19, @POOLMOTHER+3, 0, 'Ancient Lichen - Mana-Tombs'),
(@GUID+20, @POOLMOTHER+3, 0, 'Ancient Lichen - Mana-Tombs');

DELETE FROM `pool_template` WHERE `description` LIKE '%Mana-Tombs%' AND `entry` BETWEEN @POOL+0 AND @POOL+8;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL+0, 1, 'Mana-Tombs - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+1, 1, 'Mana-Tombs - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+2, 1, 'Mana-Tombs - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+3, 1, 'Mana-Tombs - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+4, 1, 'Mana-Tombs - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+5, 1, 'Mana-Tombs - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+6, 1, 'Mana-Tombs - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+7, 1, 'Mana-Tombs - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+8, 1, 'Mana-Tombs - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein');

DELETE FROM `pool_pool` WHERE `description` LIKE '%Mana-Tombs%' AND `pool_id` BETWEEN @POOL+0 AND @POOL+8 AND `mother_pool` BETWEEN @POOLMOTHER+4 AND @POOLMOTHER+5;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES
(@POOL+0, @POOLMOTHER+4, 0, 'Mana-Tombs - Adamantite / Khorium / Rich Adamantite - Group 1'),
(@POOL+1, @POOLMOTHER+4, 0, 'Mana-Tombs - Adamantite / Khorium / Rich Adamantite - Group 1'),
(@POOL+2, @POOLMOTHER+4, 0, 'Mana-Tombs - Adamantite / Khorium / Rich Adamantite - Group 1'),
(@POOL+3, @POOLMOTHER+4, 0, 'Mana-Tombs - Adamantite / Khorium / Rich Adamantite - Group 1'),
(@POOL+4, @POOLMOTHER+4, 0, 'Mana-Tombs - Adamantite / Khorium / Rich Adamantite - Group 1'),
(@POOL+5, @POOLMOTHER+5, 0, 'Mana-Tombs - Adamantite / Khorium / Rich Adamantite - Group 1'),
(@POOL+6, @POOLMOTHER+5, 0, 'Mana-Tombs - Adamantite / Khorium / Rich Adamantite - Group 1'),
(@POOL+7, @POOLMOTHER+5, 0, 'Mana-Tombs - Adamantite / Khorium / Rich Adamantite - Group 1'),
(@POOL+8, @POOLMOTHER+5, 0, 'Mana-Tombs - Adamantite / Khorium / Rich Adamantite - Group 1');

DELETE FROM `pool_gameobject` WHERE `description` LIKE '%Mana-Tombs%' AND `guid` BETWEEN @GUID+21 AND @GUID+47 AND `pool_entry` BETWEEN @POOL+0 AND @POOL+8;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GUID+21, @POOL+0, 0, 'Adamantite Deposit - Mana-Tombs'),
(@GUID+24, @POOL+1, 0, 'Adamantite Deposit - Mana-Tombs'),
(@GUID+27, @POOL+2, 0, 'Adamantite Deposit - Mana-Tombs'),
(@GUID+30, @POOL+3, 0, 'Adamantite Deposit - Mana-Tombs'),
(@GUID+33, @POOL+4, 0, 'Adamantite Deposit - Mana-Tombs'),
(@GUID+22, @POOL+0, 5, 'Khorium Vein - Mana-Tombs'),
(@GUID+25, @POOL+1, 5, 'Khorium Vein - Mana-Tombs'),
(@GUID+28, @POOL+2, 5, 'Khorium Vein - Mana-Tombs'),
(@GUID+31, @POOL+3, 5, 'Khorium Vein - Mana-Tombs'),
(@GUID+34, @POOL+4, 5, 'Khorium Vein - Mana-Tombs'),
(@GUID+23, @POOL+0, 40, 'Rich Adamantite Deposit - Mana-Tombs'),
(@GUID+26, @POOL+1, 40, 'Rich Adamantite Deposit - Mana-Tombs'),
(@GUID+29, @POOL+2, 40, 'Rich Adamantite Deposit - Mana-Tombs'),
(@GUID+32, @POOL+3, 40, 'Rich Adamantite Deposit - Mana-Tombs'),
(@GUID+35, @POOL+4, 40, 'Rich Adamantite Deposit - Mana-Tombs'),
(@GUID+36, @POOL+5, 0, 'Adamantite Deposit - Mana-Tombs'),
(@GUID+39, @POOL+6, 0, 'Adamantite Deposit - Mana-Tombs'),
(@GUID+42, @POOL+7, 0, 'Adamantite Deposit - Mana-Tombs'),
(@GUID+45, @POOL+8, 0, 'Adamantite Deposit - Mana-Tombs'),
(@GUID+37, @POOL+5, 5, 'Khorium Vein - Mana-Tombs'),
(@GUID+40, @POOL+6, 5, 'Khorium Vein - Mana-Tombs'),
(@GUID+43, @POOL+7, 5, 'Khorium Vein - Mana-Tombs'),
(@GUID+46, @POOL+8, 5, 'Khorium Vein - Mana-Tombs'),
(@GUID+38, @POOL+5, 40, 'Rich Adamantite Deposit - Mana-Tombs'),
(@GUID+41, @POOL+6, 40, 'Rich Adamantite Deposit - Mana-Tombs'),
(@GUID+44, @POOL+7, 40, 'Rich Adamantite Deposit - Mana-Tombs'),
(@GUID+47, @POOL+8, 40, 'Rich Adamantite Deposit - Mana-Tombs');

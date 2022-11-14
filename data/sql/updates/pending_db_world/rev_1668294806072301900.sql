-- Coilfang Slavehandler spam-prevention
UPDATE `smart_scripts` SET `event_chance`=20 WHERE `entryorguid`=17959 AND `source_type` = 0 AND `id`=5;

-- Equipment ID for slaves
UPDATE `creature` SET `equipment_id`=1 WHERE `id1` IN (17963, 17964);
-- Emotes for Heroic ver
DELETE FROM `creature_template_addon` WHERE `entry` IN (19902, 19904);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(19902, 0, 0, 0, 0, 173, 0, ''),
(19904, 0, 0, 0, 0, 173, 0, '');

-- Change around some Ids to conform to Classic
UPDATE `creature` SET `id1`=17940 WHERE `guid` IN (79147, 79246, 79274, 79150, 79275) AND `id1` IN (17962, 17958);
UPDATE `creature` SET `id1`=17962 WHERE `guid` IN (79847, 79366) AND `id1`=17940;

-- Delete redundant waypoints
DELETE FROM `waypoint_data` WHERE `id` IN (79364*10, 79416*10, 79426*10, 76520*10, 57878*10, 79365*10, 79847*10, 79366*10, 79274*10, 79246*10, 79357*10, 79371*10, 79411*10, 79386*10, 79518*10, 79509*10, 79516*10, 79498*10, 79421*10, 79414*10, 79412*10, 79419*10);
DELETE FROM `creature_addon` WHERE `guid` IN (79364, 79416, 79426, 76520, 57878, 79365, 79847, 79366, 79274, 79246, 79357, 79371, 79411, 79386, 79518, 79509, 79516, 79498, 79421, 79414, 79412, 79419);
UPDATE `creature` SET `MovementType`=0 WHERE `guid` IN (79364, 79416, 79426, 76520, 57878, 79365, 79847, 79366, 79274, 79246, 79357, 79371, 79411, 79386, 79518, 79509, 79516, 79498, 79421, 79414, 79412, 79419) AND `map`=547;

-- Patrolling Formations
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (88902, 72370, 86371, 79363, 79147, 79150, 79275, 135103, 79849, 79367, 79372, 79375, 79420, 79418, 135102) AND `memberGUID` IN (88902, 79364, 72370, 79416, 79426, 86371, 76520, 57878, 79363, 79365, 79147, 79847, 79366, 79150, 79246, 79275, 79274, 135103, 135104, 79849, 79357, 79371, 79367, 79411, 79386, 79372, 79375, 79498, 79516, 79509, 79518, 79420, 79421, 79418, 79414, 79412, 79419, 135102, 135101, 135100);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(88902, 88902, 0, 0, 3),
(88902, 79364, 4, 90, 515),
(79363, 79363, 0, 0, 3),
(79363, 79365, 4, 90, 515),
(79150, 79150, 0, 0, 3),
(79150, 79246, 4, 90, 515),
(79275, 79275, 0, 0, 3),
(79275, 79274, 4, 90, 515),
(135103, 135103, 0, 0, 3),
(135103, 135104, 4, 270, 515),
(135103, 79371, 4, 0, 515),
(79849, 79849, 0, 0, 3),
(79849, 79357, 4, 270, 515),
(79420, 79420, 0, 0, 3),
(79420, 79421, 4, 90, 515),
(72370, 72370, 0, 0, 3),
(72370, 79416, 5, 120, 515),
(72370, 79426, 5, 240, 515),
(86371, 86371, 0, 0, 3),
(86371, 76520, 5, 120, 515),
(86371, 57878, 5, 240, 515),
(79147, 79147, 0, 0, 3),
(79147, 79847, 2.5, 150, 515),
(79147, 79366, 2.5, 210, 515),
(79367, 79367, 0, 0, 3),
(79367, 79411, 3, 135, 515),
(79367, 79386, 3, 225, 515),
(79372, 79372, 0, 0, 3),
(79372, 79498, 3.5, 90, 515),
(79372, 79516, 3.5, 270, 515),
(79375, 79375, 0, 0, 3),
(79375, 79509, 3.5, 90, 515),
(79375, 79518, 3.5, 270, 515),
(135102, 135102, 0, 0, 3),
(135102, 135100, 3.5, 0, 515),
(135102, 135101, 3.5, 180, 515),
(79418, 79418, 0, 0, 3),
(79418, 79414, 3.5, 135, 515),
(79418, 79412, 7, 135, 515),
(79418, 79419, 3.5, 225, 515);

-- Update GroupAI of previously existing packs
UPDATE `creature_formations` SET `groupAI`=`groupAI`|3 WHERE `leaderGUID` IN (79858, 80235, 79524) AND `memberGUID` IN (79858, 80219, 79850, 80235, 79856, 79855, 79524, 80044, 79851, 79852);

-- Static Linking
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (52365,52367,52368,52372,52373,52376,52378,52381,52384,52394,79429,79460,79495,79526,79547,79655,79691,79699,79703,79712,79713,79718,79745,79795,79846,135095) AND `memberGUID` IN (52351,52352,52353,52354,52358,52359,52361,52362,52363,52364,52365,52366,52367,52368,52371,52372,52373,52374,52375,52376,52377,52378,52379,52380,52381,52382,52384,52385,52387,52393,52394,52395,52397,52398,79423,79424,79425,79428,79429,79431,79435,79438,79449,79460,79495,79507,79526,79528,79530,79538,79540,79543,79544,79545,79546,79547,79571,79655,79657,79691,79692,79699,79701,79703,79708,79709,79710,79711,79712,79713,79718,79719,79722,79745,79790,79791,79795,79830,79842,79843,79844,79845,79846,135059,135094,135095,135096,135097,135098,135099) AND `groupAI`=3;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(79718, 79718, 0, 0, 3),
(79718, 79719, 0, 0, 3),
(79429, 79429, 0, 0, 3),
(79429, 79435, 0, 0, 3),
(52384, 52384, 0, 0, 3),
(52384, 52385, 0, 0, 3),
(52384, 52398, 0, 0, 3),
(52372, 52372, 0, 0, 3),
(52372, 52380, 0, 0, 3),
(52368, 52368, 0, 0, 3),
(52368, 52387, 0, 0, 3),
(52367, 52367, 0, 0, 3),
(52367, 52395, 0, 0, 3),
(79547, 79547, 0, 0, 3),
(79547, 79722, 0, 0, 3),
(79547, 52353, 0, 0, 3),
(79547, 79424, 0, 0, 3),
(79495, 79495, 0, 0, 3),
(79495, 79528, 0, 0, 3),
(79495, 79540, 0, 0, 3),
(79495, 79571, 0, 0, 3),
(52394, 52394, 0, 0, 3),
(52394, 52393, 0, 0, 3),
(52394, 52371, 0, 0, 3),
(79655, 79655, 0, 0, 3),
(79655, 79543, 0, 0, 3),
(79655, 79657, 0, 0, 3),
(79655, 79546, 0, 0, 3),
(79655, 79544, 0, 0, 3),
(79655, 79545, 0, 0, 3),
(52373, 52373, 0, 0, 3),
(52373, 52397, 0, 0, 3),
(52373, 52366, 0, 0, 3),
(52381, 52381, 0, 0, 3),
(52381, 52382, 0, 0, 3),
(52365, 52365, 0, 0, 3),
(52365, 52375, 0, 0, 3),
(52365, 52374, 0, 0, 3),
(79703, 79703, 0, 0, 3),
(79703, 52364, 0, 0, 3),
(79703, 52354, 0, 0, 3),
(79703, 79708, 0, 0, 3),
(79526, 79526, 0, 0, 3),
(79526, 52358, 0, 0, 3),
(79526, 52362, 0, 0, 3),
(79795, 79795, 0, 0, 3),
(79795, 79507, 0, 0, 3),
(79795, 52359, 0, 0, 3),
(79795, 52361, 0, 0, 3),
(79691, 79691, 0, 0, 3),
(79691, 79438, 0, 0, 3),
(79691, 79428, 0, 0, 3),
(79691, 52363, 0, 0, 3),
(79846, 79846, 0, 0, 3),
(79846, 79692, 0, 0, 3),
(79846, 79431, 0, 0, 3),
(79846, 79538, 0, 0, 3),
(79699, 79699, 0, 0, 3),
(79699, 79790, 0, 0, 3),
(79699, 79701, 0, 0, 3),
(79699, 79530, 0, 0, 3),
(79460, 79460, 0, 0, 3),
(79460, 79791, 0, 0, 3),
(79460, 79830, 0, 0, 3),
(79460, 52351, 0, 0, 3),
(79460, 79425, 0, 0, 3),
(79745, 79745, 0, 0, 3),
(79745, 79710, 0, 0, 3),
(79745, 79449, 0, 0, 3),
(79745, 79709, 0, 0, 3),
(79712, 79712, 0, 0, 3),
(79712, 79842, 0, 0, 3),
(79712, 79843, 0, 0, 3),
(79712, 52352, 0, 0, 3),
(79712, 79423, 0, 0, 3),
(52378, 52378, 0, 0, 3),
(52378, 52379, 0, 0, 3),
(52376, 52376, 0, 0, 3),
(52376, 52377, 0, 0, 3),
(79713, 79713, 0, 0, 3),
(79713, 79845, 0, 0, 3),
(79713, 79711, 0, 0, 3),
(79713, 79844, 0, 0, 3),
(52381 , 135059, 0, 0, 3),
(135095, 135095, 0, 0, 3),
(135095, 135094, 0, 0, 3),
(135095, 135096, 0, 0, 3),
(135095, 135097, 0, 0, 3),
(135095, 135099, 0, 0, 3),
(135095, 135098, 0, 0, 3);

-- Pathing for Coilfang Technician Entry: 17940
SET @NPC := 79150;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=53.303783,`position_y`=-413.38776,`position_z`=42.375145 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,53.303783,-413.38776,42.375145,NULL,0,0,0,100,0),
(@PATH,2,38.81258,-415.03116,47.454975,NULL,0,0,0,100,0),
(@PATH,3,11.266998,-414.90323,58.969685,NULL,0,0,0,100,0),
(@PATH,4,-11.247518,-412.01126,70.102516,NULL,0,0,0,100,0),
(@PATH,5,-38.72895,-401.16205,79.519264,NULL,0,0,0,100,0),
(@PATH,6,-49.831036,-394.43207,81.02048,NULL,0,0,0,100,0),
(@PATH,7,-38.72895,-401.16205,79.519264,NULL,0,0,0,100,0),
(@PATH,8,-11.247518,-412.01126,70.102516,NULL,0,0,0,100,0),
(@PATH,9,11.266998,-414.90323,58.969685,NULL,0,0,0,100,0),
(@PATH,10,38.81258,-415.03116,47.454975,NULL,0,0,0,100,0);

-- Pathing for Coilfang Technician Entry: 17940
SET @NPC := 79275;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=50.593475,`position_y`=-347.18506,`position_z`=43.32531 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,50.593475,-347.18506,43.32531,NULL,0,0,0,100,0),
(@PATH,2,10.812712,-345.4971,59.181576,NULL,0,0,0,100,0),
(@PATH,3,-11.609047,-348.55582,70.28157,NULL,0,0,0,100,0),
(@PATH,4,-51.178356,-365.4542,81.021706,NULL,0,0,0,100,0),
(@PATH,5,-11.609047,-348.55582,70.28157,NULL,0,0,0,100,0),
(@PATH,6,10.812712,-345.4971,59.181576,NULL,0,0,0,100,0);

-- Pathing for Coilfang Defender Entry: 17958
SET @NPC := 135103;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-57.01482,`position_y`=-380.75848,`position_z`=81.29693 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-57.01482,-380.75848,81.29693,NULL,0,0,0,100,0),
(@PATH,2,-84.22245,-380.4095,78.72163,NULL,0,0,0,100,0),
(@PATH,3,-114.71889,-380.43747,81.247215,NULL,0,0,0,100,0),
(@PATH,4,-84.22245,-380.4095,78.72163,NULL,0,0,0,100,0);

-- Pathing for Coilfang Technician Entry: 17940
SET @NPC := 79849;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-124.27898,`position_y`=-362.85834,`position_z`=80.274536 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-124.27898,-362.85834,80.274536,NULL,0,0,0,100,0),
(@PATH,2,-119.12202,-366.2761,81.00296,NULL,0,0,0,100,0),
(@PATH,3,-119.18936,-394.48737,80.9744,NULL,0,0,0,100,0),
(@PATH,4,-124.20847,-398.524,80.28374,NULL,0,0,0,100,0),
(@PATH,5,-119.18936,-394.48737,80.9744,NULL,0,0,0,100,0),
(@PATH,6,-119.12202,-366.2761,81.00296,NULL,0,0,0,100,0);

-- Pathing for Coilfang Technician Entry: 17940 : Changed to Enchantress (17961)
SET @NPC := 79372;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-227.68805,`position_y`=-363.0566,`position_z`=3.035604 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-227.68805,-363.0566,3.035604,NULL,0,0,0,100,0),
(@PATH,2,-263.95883,-333.90656,3.0356667,NULL,0,0,0,100,0),
(@PATH,3,-254.09215,-355.1459,3.035639,NULL,0,0,0,100,0),
(@PATH,4,-263.95883,-333.90656,3.0356667,NULL,0,0,0,100,0);

-- Pathing for Coilfang Technician Entry: 17940 : Changed to Enchantress (17961)
SET @NPC := 79375;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-269.14896,`position_y`=-421.1905,`position_z`=3.0330684 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-269.14896,-421.1905,3.0330684,NULL,0,0,0,100,0),
(@PATH,2,-255.33366,-407.8583,3.0356631,NULL,0,0,0,100,0),
(@PATH,3,-224.32506,-396.62097,3.0355346,NULL,0,0,0,100,0),
(@PATH,4,-255.33366,-407.8583,3.0356631,NULL,0,0,0,100,0);

-- Pathing for Coilfang Technician Entry: 17940
SET @NPC := 79367;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-291.18933,`position_y`=-380.3938,`position_z`=30.125166 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-291.18933,-380.3938,30.125166,NULL,0,0,0,100,0),
(@PATH,2,-267.8213,-380.56857,20.334038,NULL,0,0,0,100,0),
(@PATH,3,-248.38216,-380.5874,10.425892,NULL,0,0,0,100,0),
(@PATH,4,-229.06407,-380.6496,3.0354943,NULL,0,0,0,100,0),
(@PATH,5,-248.38216,-380.5874,10.425892,NULL,0,0,0,100,0),
(@PATH,6,-267.8213,-380.56857,20.334038,NULL,0,0,0,100,0);

-- Pathing for Rokmar the Crackler Entry: 17991
SET @NPC := 79339;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=18.321169,`position_y`=-448.44757,`position_z`=3.055895 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,18.321169,-448.44757,3.055895,NULL,0,0,0,100,0),
(@PATH,2,-13.558029,-454.80655,2.49773,NULL,0,0,0,100,0),
(@PATH,3,-62.09498,-454.97253,-1.5922983,NULL,0,0,0,100,0),
(@PATH,4,-34.37422,-458.81696,-1.952406,NULL,0,0,0,100,0),
(@PATH,5,-62.09498,-454.97253,-1.5922983,NULL,0,0,0,100,0),
(@PATH,6,-13.558029,-454.80655,2.49773,NULL,0,0,0,100,0);

-- Pathing for Coilfang Defender Entry: 17958
SET @NPC := 79420;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-83.93549,`position_y`=-523.77386,`position_z`=-1.5914233 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-83.93549,-523.77386,-1.5914233,NULL,0,0,0,100,0),
(@PATH,2,-74.375824,-526.5931,-1.5943141,NULL,0,0,0,100,0),
(@PATH,3,-62.04731,-528.7617,-1.5941613,NULL,0,0,0,100,0),
(@PATH,4,-54.048965,-542.6787,-1.5936232,NULL,0,0,0,100,0),
(@PATH,5,-54.877804,-556.5964,-1.5929497,NULL,0,0,0,100,0),
(@PATH,6,-67.603195,-566.9261,-0.6967133,NULL,0,0,0,100,0),
(@PATH,7,-75.75858,-585.0732,1.723919,NULL,0,0,0,100,0),
(@PATH,8,-104.19448,-592.87317,5.20782,NULL,0,0,0,100,0),
(@PATH,9,-103.67276,-611.86194,10.930438,NULL,0,0,0,100,0),
(@PATH,10,-104.19448,-592.87317,5.20782,NULL,0,0,0,100,0),
(@PATH,11,-75.75858,-585.0732,1.723919,NULL,0,0,0,100,0),
(@PATH,12,-67.603195,-566.9261,-0.6967133,NULL,0,0,0,100,0),
(@PATH,13,-54.877804,-556.5964,-1.5929497,NULL,0,0,0,100,0),
(@PATH,14,-54.048965,-542.6787,-1.5936232,NULL,0,0,0,100,0),
(@PATH,15,-62.04731,-528.7617,-1.5941613,NULL,0,0,0,100,0),
(@PATH,16,-74.375824,-526.5931,-1.5943141,NULL,0,0,0,100,0);

-- Pathing for Coilfang Champion Entry: 17957 : Changed to Coilfang Enchantress (17961)
SET @NPC := 79418;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-99.05717,`position_y`=-625.1839,`position_z`=16.924713 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-99.05717,-625.1839,16.924713,NULL,0,0,0,100,0),
(@PATH,2,-97.61304,-672.66565,30.076414,NULL,0,0,0,100,0),
(@PATH,3,-89.53006,-701.02655,36.55273,NULL,0,0,0,100,0),
(@PATH,4,-83.497406,-735.865,36.541836,NULL,0,0,0,100,0),
(@PATH,5,-112.21934,-751.7954,37.091347,NULL,0,0,0,100,0),
(@PATH,6,-83.497406,-735.865,36.541836,NULL,0,0,0,100,0),
(@PATH,7,-89.53006,-701.02655,36.55273,NULL,0,0,0,100,0),
(@PATH,8,-97.61304,-672.66565,30.076414,NULL,0,0,0,100,0);

-- Pathing for Mennu the Betrayer Entry: 17941
SET @NPC := 79362;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=49.4763,`position_y`=-380.21915,`position_z`=3.0355754 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,49.4763,-380.21915,3.0355754,NULL,1000,0,0,100,0),
(@PATH,2,89.26869,-380.23682,15.089901,NULL,0,0,0,100,0),
(@PATH,3,121.63626,-380.37653,29.957338,NULL,1500,0,0,100,0),
(@PATH,4,89.427284,-380.23688,15.121437,NULL,0,0,0,100,0);

-- Pathing for Bogstrok Entry: 17816
SET @NPC := 135102;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-121.42814,`position_y`=-752.9407,`position_z`=37.346226 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-121.42814,-752.9407,37.346226,NULL,0,1,0,100,0),
(@PATH,2,-144.27388,-731.4174,37.89232,NULL,0,1,0,100,0),
(@PATH,3,-172.50328,-720.9616,37.892315,NULL,0,1,0,100,0),
(@PATH,4,-194.77405,-707.0978,37.89232,NULL,0,1,0,100,0),
(@PATH,5,-204.18204,-684.4947,37.353416,NULL,0,1,0,100,0),
(@PATH,6,-194.77405,-707.0978,37.89232,NULL,0,1,0,100,0),
(@PATH,7,-172.50328,-720.9616,37.892315,NULL,0,1,0,100,0),
(@PATH,8,-144.27388,-731.4174,37.89232,NULL,0,1,0,100,0);

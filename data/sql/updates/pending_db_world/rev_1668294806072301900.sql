-- Emote state: 173 (Work)

-- Coilfang Slavehandler spam-prevention
UPDATE `smart_scripts` SET `event_chance`=20 WHERE `entryorguid`=17959 AND `source_type` = 0 AND `id`=5;

-- Equipment ID for slaves
UPDATE `creature` SET `equipment_id`=1 WHERE `id1` IN (17963, 17964);
-- Emotes for Heroic ver
DELETE FROM `creature_template_addon` WHERE `entry` IN (19902, 19904);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(19902, 0, 0, 0, 0, 173, 0, ''),
(19904, 0, 0, 0, 0, 173, 0, '');

UPDATE `creature` SET `id1`=17940 WHERE `guid` IN (79147, 79246, 79274, 79150, 79275) AND `id1` IN (17962, 17958);
UPDATE `creature` SET `id1`=17962 WHERE `guid` IN (79847, 79366) AND `id1`=17940;

DELETE FROM `waypoint_data` WHERE `id` IN (79364*10, 79416*10, 79426*10, 76520*10, 57878*10, 79365*10, 79847*10, 79366*10, 79274*10, 79246*10);
DELETE FROM `creature_addon` WHERE `guid` IN (79364, 79416, 79426, 76520, 57878, 79365, 79847, 79366, 79274, 79246);

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (88902, 72370, 86371, 79363, 79147, 79150, 79275, 135103) AND `memberGUID` IN (88902, 79364, 72370, 79416, 79426, 86371, 76520, 57878, 79363, 79365, 79147, 79847, 79366, 79150, 79246, 79275, 79274, 135103, 135104);
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

(72370, 72370, 0, 0, 3),
(72370, 79416, 5, 120, 515),
(72370, 79426, 5, 240, 515),

(86371, 86371, 0, 0, 3),
(86371, 76520, 5, 120, 515),
(86371, 57878, 5, 240, 515),

(79147, 79147, 0, 0, 3),
(79147, 79847, 2.5, 150, 515),
(79147, 79366, 2.5, 270, 515);

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (79718) AND `memberGUID` IN (79718, 79719) AND `groupAI`=3;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(79718, 79718, 0, 0, 3),
(79718, 79719, 0, 0, 3);

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
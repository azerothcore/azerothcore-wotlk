-- DB update 2023_01_16_11 -> 2023_01_16_12
-- Hillsbrad Peasants
DELETE FROM `creature` WHERE `map`=560 AND `id1` IN (2267, 20424) AND `guid` IN (11511,11559,11560,11561,11562,11563,11564,11565,11568,11569,11599,11600,11601); -- Delete old ones as well
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(11559, 2267, 560, 2367, 0, 3, 1, 1, 1778.6141357421875, 614.4805908203125, 30.4710693359375, 5.348875999450683593, 84600, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 2267 (Area: 0 - Difficulty: 1) (possible waypoints or random movement)
(11560, 2267, 560, 2367, 0, 3, 1, 1, 1781.208984375, 628.57659912109375, 30.4710693359375, 5.546773433685302734, 84600, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 2267 (Area: 0 - Difficulty: 1) (possible waypoints or random movement)
(11561, 2267, 560, 2367, 0, 3, 1, 1, 1781.1407470703125, 613.71392822265625, 30.4710693359375, 2.796445131301879882, 84600, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 2267 (Area: 0 - Difficulty: 1) (possible waypoints or random movement)
(11562, 2267, 560, 2367, 0, 3, 1, 1, 1764.9208984375, 602.0184326171875, 30.4710693359375, 3.171567916870117187, 84600, 15, 0, 0, 0, 1, 0, 0, 0, 47187), -- 2267 (Area: 0 - Difficulty: 1) (possible waypoints or random movement)
(11563, 2267, 560, 2367, 0, 3, 1, 1, 1766.198974609375, 614.63360595703125, 30.4710693359375, 5.433770656585693359, 84600, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 2267 (Area: 0 - Difficulty: 1) (possible waypoints or random movement)
(11564, 2267, 560, 2367, 0, 3, 1, 1, 1751.7391357421875, 579.6617431640625, 30.47285270690917968, 2.566066265106201171, 84600, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 2267 (Area: 0 - Difficulty: 1) (possible waypoints or random movement)
(11565, 2267, 560, 2367, 0, 3, 1, 1, 1761.5758056640625, 602.43212890625, 30.4710693359375, 2.513488531112670898, 84600, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 2267 (Area: 0 - Difficulty: 1) (possible waypoints or random movement)
(11568, 2267, 560, 2367, 0, 3, 1, 1, 1747.37939453125, 575.81146240234375, 30.47285270690917968, 2.353931427001953125, 84600, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 2267 (Area: 0 - Difficulty: 1) (possible waypoints or random movement)
(11569, 2267, 560, 2367, 0, 3, 1, 1, 1742.3624267578125, 591.9937744140625, 30.4728546142578125, 2.352702856063842773, 84600, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 2267 (Area: 0 - Difficulty: 1) (possible waypoints or random movement)
(11599, 2267, 560, 2367, 0, 3, 1, 1, 1746.5233154296875, 602.43536376953125, 30.4710693359375, 5.498256206512451171, 84600, 0, 0, 0, 0, 0, 0, 0, 0, 47187); -- 2267 (Area: 0 - Difficulty: 1) (possible waypoints or random movement)

DELETE FROM `creature_addon` WHERE `guid`=11562;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(11562, 0, 0, 0, 1, 173, 0, NULL);

-- Pathing for Hillsbrad Peasant Entry: 2267
SET @NPC := 11559;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=1760.264,`position_y`=574.13086,`position_z`=30.472853 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,173,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1760.264,574.13086,30.472853,NULL,8000,0,0,100,0),
(@PATH,2,1749.4868,581.12305,30.472853,NULL,0,0,0,100,0),
(@PATH,3,1741.8695,592.16785,30.472853,NULL,0,0,0,100,0),
(@PATH,4,1734.5074,603.5558,30.47107,NULL,8000,0,0,100,0),
(@PATH,5,1741.8695,592.16785,30.472853,NULL,0,0,0,100,0),
(@PATH,6,1749.4868,581.12305,30.472853,NULL,0,0,0,100,0);
-- 0x20422046000236C000581A000020F8E1 .go xyz 1760.264 574.13086 30.472853

-- Pathing for Hillsbrad Peasant Entry: 2267
SET @NPC := 11560;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=1770.8774,`position_y`=611.6829,`position_z`=30.47107 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,173,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1770.8774,611.6829,30.47107,NULL,8000,0,0,100,0),
(@PATH,2,1783.7317,598.0076,30.472853,NULL,0,0,0,100,0),
(@PATH,3,1780.5812,588.0344,30.472853,NULL,0,0,0,100,0),
(@PATH,4,1769.9275,597.5908,30.472853,NULL,0,0,0,100,0),
(@PATH,5,1780.6309,588.19183,30.472853,NULL,0,0,0,100,0),
(@PATH,6,1769.9275,597.5908,30.472853,NULL,0,0,0,100,0),
(@PATH,7,1759.4817,609.4033,30.47107,NULL,0,0,0,100,0),
(@PATH,8,1745.8138,618.2092,30.47107,NULL,0,0,0,100,0),
(@PATH,9,1730.7394,616.9915,30.472857,NULL,0,0,0,100,0),
(@PATH,10,1732.4326,601.99316,30.472857,NULL,0,0,0,100,0),
(@PATH,11,1751.6458,582.6454,30.472853,NULL,8000,0,0,100,0),
(@PATH,12,1732.4326,601.99316,30.472857,NULL,0,0,0,100,0),
(@PATH,13,1730.7394,616.9915,30.472857,NULL,0,0,0,100,0),
(@PATH,14,1745.8138,618.2092,30.47107,NULL,0,0,0,100,0),
(@PATH,15,1759.4817,609.4033,30.47107,NULL,0,0,0,100,0),
(@PATH,16,1769.9275,597.5908,30.472853,NULL,0,0,0,100,0),
(@PATH,17,1780.5812,588.0344,30.472853,NULL,0,0,0,100,0),
(@PATH,18,1783.7317,598.0076,30.472853,NULL,0,0,0,100,0),
(@PATH,19,1780.4778,588.12714,30.472853,NULL,0,0,0,100,0),
(@PATH,20,1783.7317,598.0076,30.472853,NULL,0,0,0,100,0),
(@PATH,21,1774.7311,609.89465,30.47107,NULL,0,0,0,100,0);
-- 0x20422046000236C000581A000020F8E2 .go xyz 1770.8774 611.6829 30.47107

-- Pathing for Hillsbrad Peasant Entry: 2267
SET @NPC := 11561;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=1774.3646,`position_y`=598.88293,`position_z`=30.472853 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,173,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1774.3646,598.88293,30.472853,NULL,8000,0,0,100,0),
(@PATH,2,1770.023,606.1108,30.47107,NULL,0,0,0,100,0),
(@PATH,3,1766.9783,613.7476,30.47107,NULL,0,0,0,100,0),
(@PATH,4,1759.4878,622.2642,30.47107,NULL,0,0,0,100,0),
(@PATH,5,1752.4077,621.83075,30.47107,NULL,0,0,0,100,0),
(@PATH,6,1746.8833,624.65625,30.47107,NULL,0,0,0,100,0),
(@PATH,7,1742.4607,631.35675,30.47107,NULL,0,0,0,100,0),
(@PATH,8,1738.4662,633.0537,30.47107,NULL,8000,0,0,100,0),
(@PATH,9,1746.8833,624.65625,30.47107,NULL,0,0,0,100,0),
(@PATH,10,1752.4077,621.83075,30.47107,NULL,0,0,0,100,0),
(@PATH,11,1759.4878,622.2642,30.47107,NULL,0,0,0,100,0),
(@PATH,12,1766.9783,613.7476,30.47107,NULL,0,0,0,100,0),
(@PATH,13,1770.023,606.1108,30.47107,NULL,0,0,0,100,0);
-- 0x20422046000236C000581A0000A0F8E1 .go xyz 1774.3646 598.88293 30.472853

-- Pathing for Hillsbrad Peasant Entry: 2267
SET @NPC := 11563;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=1726.2867,`position_y`=608.4874,`position_z`=30.472857 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,173,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1726.2867,608.4874,30.472857,NULL,8000,0,0,100,0),
(@PATH,2,1726.7537,598.98914,30.472857,NULL,0,0,0,100,0),
(@PATH,3,1737.6554,585.5795,30.472853,NULL,0,0,0,100,0),
(@PATH,4,1748.0953,575.0922,30.472853,NULL,8000,0,0,100,0),
(@PATH,5,1737.6554,585.5795,30.472853,NULL,0,0,0,100,0),
(@PATH,6,1726.7537,598.98914,30.472857,NULL,0,0,0,100,0);
-- 0x20422046000236C000581A0000A0F8E2 .go xyz 1726.2867 608.4874 30.472857

-- Pathing for Hillsbrad Peasant Entry: 2267
SET @NPC := 11564;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=1762.629,`position_y`=635.8887,`position_z`=30.36947 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,173,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1762.629,635.8887,30.36947,NULL,8000,0,0,100,0),
(@PATH,2,1770.299,625.1401,30.47107,NULL,0,0,0,100,0),
(@PATH,3,1779.0426,614.4683,30.47107,NULL,0,0,0,100,0),
(@PATH,4,1786.866,611.6555,30.47107,NULL,0,0,0,100,0),
(@PATH,5,1794.9326,604.8621,30.47107,NULL,8000,0,0,100,0),
(@PATH,6,1786.866,611.6555,30.47107,NULL,0,0,0,100,0),
(@PATH,7,1779.0426,614.4683,30.47107,NULL,0,0,0,100,0),
(@PATH,8,1770.299,625.1401,30.47107,NULL,0,0,0,100,0);
-- 0x20422046000236C000581A000120F8E1 .go xyz 1762.629 635.8887 30.36947

-- Pathing for Hillsbrad Peasant Entry: 2267
SET @NPC := 11565;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=1773.5377,`position_y`=579.3686,`position_z`=30.472853 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,173,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1773.5377,579.3686,30.472853,NULL,8000,0,0,100,0),
(@PATH,2,1766.2428,583.7906,30.472853,NULL,0,0,0,100,0),
(@PATH,3,1757.1127,590.3584,30.472853,NULL,0,0,0,100,0),
(@PATH,4,1752.4948,598.2504,30.472853,NULL,0,0,0,100,0),
(@PATH,5,1756.1306,601.7549,30.47107,NULL,0,0,0,100,0),
(@PATH,6,1765.9279,602.04865,30.47107,NULL,8000,0,0,100,0),
(@PATH,7,1756.1306,601.7549,30.47107,NULL,0,0,0,100,0),
(@PATH,8,1752.4948,598.2504,30.472853,NULL,0,0,0,100,0),
(@PATH,9,1757.1127,590.3584,30.472853,NULL,0,0,0,100,0),
(@PATH,10,1766.2428,583.7906,30.472853,NULL,0,0,0,100,0);
-- 0x20422046000236C000581A000120F8E2 .go xyz 1773.5377 579.3686 30.472853

-- Pathing for Hillsbrad Peasant Entry: 2267
SET @NPC := 11568;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=1732.4215,`position_y`=618.5181,`position_z`=30.472857 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,173,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1732.4215,618.5181,30.472857,NULL,8000,0,0,100,0),
(@PATH,2,1742.0332,630.94824,30.47107,NULL,0,0,0,100,0),
(@PATH,3,1762.6732,637.54504,30.36947,NULL,0,0,0,100,0),
(@PATH,4,1775.3612,633.8778,30.35685,NULL,0,0,0,100,0),
(@PATH,5,1792.4398,618.3955,30.47107,NULL,0,0,0,100,0),
(@PATH,6,1797.6517,609.0804,30.47107,NULL,8000,0,0,100,0),
(@PATH,7,1792.4398,618.3955,30.47107,NULL,0,0,0,100,0),
(@PATH,8,1775.3612,633.8778,30.35685,NULL,0,0,0,100,0),
(@PATH,9,1762.6732,637.54504,30.36947,NULL,0,0,0,100,0),
(@PATH,10,1742.0332,630.94824,30.47107,NULL,0,0,0,100,0);
-- 0x20422046000236C000581A0001A0F8E1 .go xyz 1732.4215 618.5181 30.472857

-- Pathing for Hillsbrad Peasant Entry: 2267
SET @NPC := 11569;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=1733.5542,`position_y`=626.4067,`position_z`=30.47107 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,173,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1733.5542,626.4067,30.47107,NULL,8000,0,0,100,0),
(@PATH,2,1726.6923,616.3137,30.472857,NULL,0,0,0,100,0),
(@PATH,3,1733.8323,607.43445,30.47107,NULL,0,0,0,100,0),
(@PATH,4,1745.2274,604.0303,30.47107,NULL,0,0,0,100,0),
(@PATH,5,1751.1123,599.5579,30.472853,NULL,8000,0,0,100,0),
(@PATH,6,1745.1508,604.05316,30.47107,NULL,0,0,0,100,0),
(@PATH,7,1733.8323,607.43445,30.47107,NULL,0,0,0,100,0),
(@PATH,8,1726.6923,616.3137,30.472857,NULL,0,0,0,100,0);
-- 0x20422046000236C000581A0002A0F8E1 .go xyz 1733.5542 626.4067 30.47107

-- Pathing for Hillsbrad Peasant Entry: 2267
-- 0x20422046000236C000581A000320F8E1 .go xyz 1781.5918 610.4517 30.47107
SET @NPC := 11599;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=1781.5918,`position_y`=610.4517,`position_z`=30.47107 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,173,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1781.5918,610.4517,30.47107,NULL,8000,0,0,100,0),
(@PATH,2,1776.1965,617.7515,30.47107,NULL,0,0,0,100,0),
(@PATH,3,1772.4537,623.1462,30.47107,NULL,0,0,0,100,0),
(@PATH,4,1763.7234,625.94617,30.47107,NULL,0,0,0,100,0),
(@PATH,5,1757.6306,629.7589,30.47107,NULL,0,0,0,100,0),
(@PATH,6,1753.0732,633.41113,30.36947,NULL,8000,0,0,100,0),
(@PATH,7,1757.6306,629.7589,30.47107,NULL,0,0,0,100,0),
(@PATH,8,1763.7234,625.94617,30.47107,NULL,0,0,0,100,0),
(@PATH,9,1772.4537,623.1462,30.47107,NULL,0,0,0,100,0),
(@PATH,10,1776.1965,617.7515,30.47107,NULL,0,0,0,100,0);

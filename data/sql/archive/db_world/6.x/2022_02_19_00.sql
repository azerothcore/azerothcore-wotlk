-- DB update 2022_02_18_06 -> 2022_02_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_18_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_18_06 2022_02_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645226316218841996'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645226316218841996');

-- Pathing for Doomwhisperer Entry: 18981
SET @NPC := 68255;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-400.11264,`position_y`=1841.9849,`position_z`=80.27914,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-400.11264,1841.9849,80.27914,0,0,0,0,100,0),
(@PATH,2,-400.11264,1857.457,86.373985,0,0,0,0,100,0),
(@PATH,3,-410.29895,1866.5201,89.43929,0,0,0,0,100,0),
(@PATH,4,-424.30197,1866.5419,86.0129,0,0,0,0,100,0),
(@PATH,5,-433.35168,1858.2439,82.271866,0,0,0,0,100,0),
(@PATH,6,-433.42242,1841.6847,76.67714,0,0,0,0,100,0),
(@PATH,7,-426.1557,1833.5712,74.89999,0,0,0,0,100,0),
(@PATH,8,-409.477,1833.5017,76.62655,0,0,0,0,100,0);

-- Pathing for Doomwhisperer Entry: 18981
SET @NPC := 68256;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=157.54276,`position_y`=1733.5149,`position_z`=38.611526,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,157.54276,1733.5149,38.611526,0,0,0,0,100,0),
(@PATH,2,166.43541,1725.1803,36.081596,0,0,0,0,100,0),
(@PATH,3,166.53304,1708.7853,32.844048,0,0,0,0,100,0),
(@PATH,4,158.23543,1699.9324,32.428844,0,0,0,0,100,0),
(@PATH,5,141.30193,1700.3922,35.5888,0,0,0,0,100,0),
(@PATH,6,133.09378,1707.621,38.3699,0,0,0,0,100,0),
(@PATH,7,133.29851,1725.683,41.11819,0,0,0,0,100,0),
(@PATH,8,141.1874,1733.4866,40.99495,0,0,0,0,100,0);

-- Pathing for Doomwhisperer Entry: 18981
SET @NPC := 68257;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=166.50195,`position_y`=1692.5322,`position_z`=29.492321,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,166.50195,1692.5322,29.492321,0,0,0,0,100,0),
(@PATH,2,182.03798,1714.4326,33.160423,0,0,0,0,100,0),
(@PATH,3,172.67564,1738.2897,36.8002,0,0,0,0,100,0),
(@PATH,4,143.19371,1742.7427,40.86995,0,0,0,0,100,0),
(@PATH,5,116.05689,1750.4852,43.10199,0,0,0,0,100,0),
(@PATH,6,91.98966,1747.1569,44.71682,0,0,0,0,100,0),
(@PATH,7,60.37603,1748.6595,46.42101,0,0,0,0,100,0),
(@PATH,8,34.465714,1766.2246,51.232166,0,0,0,0,100,0),
(@PATH,9,10.548285,1781.5095,57.04717,0,0,0,0,100,0),
(@PATH,10,-29.27067,1793.3755,59.415462,0,0,0,0,100,0),
(@PATH,11,-57.016655,1800.7504,58.51186,0,0,0,0,100,0),
(@PATH,12,-83.34218,1842.7513,65.709854,0,0,0,0,100,0),
(@PATH,13,-107.1626,1862.1539,76.25923,0,0,0,0,100,0),
(@PATH,14,-107.38124,1907.3741,78.938774,0,0,0,0,100,0),
(@PATH,15,-62.921604,1910.0017,71.05396,0,0,0,0,100,0),
(@PATH,16,-59.871365,1866.7263,68.021164,0,0,0,0,100,0),
(@PATH,17,-31.091635,1871.4506,60.590405,0,0,0,0,100,0),
(@PATH,18,-6.90153,1859.9799,63.717434,0,0,0,0,100,0),
(@PATH,19,32.65066,1833.8201,51.624966,0,0,0,0,100,0),
(@PATH,20,60.1773,1799.2845,49.101593,0,0,0,0,100,0),
(@PATH,21,93.83564,1774.7561,46.201584,0,0,0,0,100,0),
(@PATH,22,110.25,1733.9355,42.97052,0,0,0,0,100,0),
(@PATH,23,120.96484,1710.2461,40.30154,0,0,0,0,100,0),
(@PATH,24,133.50139,1691.4039,35.34657,0,0,0,0,100,0);

-- Pathing for Doomwhisperer Entry: 18981
SET @NPC := 68258;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-93.22461,`position_y`=1867.1748,`position_z`=74.322296,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-93.22461,1867.1748,74.322296,0,0,0,0,100,0),
(@PATH,2,-76.06424,1866.8044,71.28177,0,0,0,0,100,0),
(@PATH,3,-66.98736,1875.132,70.149445,0,0,0,0,100,0),
(@PATH,4,-66.68766,1891.1537,70.76224,0,0,0,0,100,0),
(@PATH,5,-74.25586,1900.082,72.578285,0,0,0,0,100,0),
(@PATH,6,-93.01351,1900.1233,76.08512,0,0,0,0,100,0),
(@PATH,7,-100.21029,1890.971,77.570946,0,0,0,0,100,0),
(@PATH,8,-99.9713,1875.8649,76.63138,0,0,0,0,100,0);

-- Pathing for Doomwhisperer Entry: 18981
SET @NPC := 68259;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-564.8403,`position_y`=1790.9039,`position_z`=62.956295,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-564.8403,1790.9039,62.956295,0,0,0,0,100,0),
(@PATH,2,-557.6235,1799.8295,63.241207,0,0,0,0,100,0),
(@PATH,3,-542.10297,1799.9752,60.186764,0,0,0,0,100,0),
(@PATH,4,-533.65765,1794.1727,57.655758,0,0,0,0,100,0),
(@PATH,5,-533.43286,1773.9478,53.588253,0,0,0,0,100,0),
(@PATH,6,-541.1907,1766.7448,53.654903,0,0,0,0,100,0),
(@PATH,7,-557.87836,1766.8654,56.43005,0,0,0,0,100,0),
(@PATH,8,-566.7337,1775.5707,60.367893,0,0,0,0,100,0);

-- Pathing for Doomwhisperer Entry: 18981
SET @NPC := 68260;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-442.94412,`position_y`=1860.3776,`position_z`=81.36537,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-442.94412,1860.3776,81.36537,0,0,0,0,100,0),
(@PATH,2,-436.1084,1874.7408,86.51704,0,0,0,0,100,0),
(@PATH,3,-391.63812,1873.5605,95.141235,0,0,0,0,100,0),
(@PATH,4,-391.6425,1829.1959,77.0229,0,0,0,0,100,0),
(@PATH,5,-437.52225,1827.6423,71.6324,0,0,0,0,100,0),
(@PATH,6,-468.6086,1811.8113,59.085255,0,0,0,0,100,0),
(@PATH,7,-501.2281,1813.5881,60.5808,0,0,0,0,100,0),
(@PATH,8,-533.56836,1810.1852,61.90804,0,0,0,0,100,0),
(@PATH,9,-529.05414,1760.4601,51.323673,0,0,0,0,100,0),
(@PATH,10,-500.14203,1799.8684,54.842052,0,0,0,0,100,0),
(@PATH,11,-476.1835,1838.418,70.07411,0,0,0,0,100,0);

-- Pathing for Subjugator Shi'aziv Entry: 19282
SET @NPC := 68851;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=61.394096,`position_y`=1830.152,`position_z`=42.73946,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,61.394096,1830.152,42.73946,0,0,0,0,100,0),
(@PATH,2,56.41504,1842.1111,42.807007,0,0,0,0,100,0),
(@PATH,3,45.974285,1851.9163,45.318848,0,0,0,0,100,0),
(@PATH,4,24.965387,1857.5209,54.0798,0,0,0,0,100,0),
(@PATH,5,12.386285,1857.2231,59.04086,0,0,0,0,100,0),
(@PATH,6,2.089518,1853.4475,63.623013,0,0,0,0,100,0),
(@PATH,7,-10.910156,1844.1191,69.454254,0,0,0,0,100,0),
(@PATH,8,-15.760091,1833.5153,71.190094,0,0,0,0,100,0),
(@PATH,9,-13.492296,1816.2227,66.9124,0,0,0,0,100,0),
(@PATH,10,-13.571073,1802.3794,64.31023,0,0,0,0,100,0),
(@PATH,11,-13.028646,1783.1434,61.35052,0,0,0,0,100,0),
(@PATH,12,-3.038954,1762.001,55.163452,0,0,0,0,100,0),
(@PATH,13,9.053386,1752.6764,51.47461,0,0,0,0,100,0),
(@PATH,14,21.679688,1744.5908,48.73108,0,0,0,0,100,0),
(@PATH,15,30.34668,1750.9869,49.41211,0,0,0,0,100,0),
(@PATH,16,42.703995,1761.8077,49.7766,0,0,0,0,100,0),
(@PATH,17,48.186634,1777.8743,51.45816,0,0,0,0,100,0),
(@PATH,18,55.35232,1790.6544,51.11136,0,0,0,0,100,0),
(@PATH,19,57.881184,1800.5813,49.18709,0,0,0,0,100,0),
(@PATH,20,59.40788,1812.9431,46.47115,0,0,0,0,100,0);
-- 0x204CB0424012D48000006F000060EED2 .go xyz 61.394096 1830.152 42.73946

-- Pathing for Subjugator Yalqiz Entry: 19335
SET @NPC := 68916;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-489.20834,`position_y`=1714.0068,`position_z`=58.483906,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-489.20834,1714.0068,58.483906,0,0,0,0,100,0),
(@PATH,2,-496.63553,1719.4497,60.84511,0,0,0,0,100,0),
(@PATH,3,-505.47272,1714.4742,59.55276,0,0,0,0,100,0),
(@PATH,4,-516.50244,1708.1036,57.89871,0,0,0,0,100,0),
(@PATH,5,-533.43024,1692.1309,53.877502,0,0,0,0,100,0),
(@PATH,6,-532.11334,1686.3058,51.65182,0,0,0,0,100,0),
(@PATH,7,-526.8643,1677.8087,47.36276,0,0,0,0,100,0),
(@PATH,8,-510.7744,1675.9634,47.51254,0,0,0,0,100,0),
(@PATH,9,-490.4778,1679.859,49.243214,0,0,0,0,100,0),
(@PATH,10,-482.0579,1687.7589,51.388966,0,0,0,0,100,0),
(@PATH,11,-480.32016,1701.1799,55.152363,0,0,0,0,100,0);
-- 0x204CB0424012E1C000006F000060EED3 .go xyz -489.20834 1714.0068 58.483906

-- Pathing for Dreadcaller Entry: 19434
SET @NPC := 69499;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-572.3224,`position_y`=1983.454,`position_z`=91.76091,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-572.3224,1983.454,91.76091,0,0,0,0,100,0),
(@PATH,2,-557.3419,2005.0006,98.851204,0,0,0,0,100,0),
(@PATH,3,-557.43933,2036.3041,98.764565,0,0,0,0,100,0),
(@PATH,4,-560.0819,2057.4458,95.99662,0,0,0,0,100,0),
(@PATH,5,-540.46075,2062.9016,104.11625,0,0,0,0,100,0),
(@PATH,6,-537.59515,2087.596,103.06349,0,0,0,0,100,0),
(@PATH,7,-530.3494,2104.4849,104.04554,0,0,0,0,100,0),
(@PATH,8,-541.99414,2123.1543,96.39017,0,0,0,0,100,0),
(@PATH,9,-543.137,2144.7395,93.31396,0,0,0,0,100,0),
(@PATH,10,-542.054,2123.2705,96.457794,0,0,0,0,100,0),
(@PATH,11,-530.3494,2104.4849,104.04554,0,0,0,0,100,0),
(@PATH,12,-537.59515,2087.596,103.06349,0,0,0,0,100,0),
(@PATH,13,-540.46075,2062.9016,104.11625,0,0,0,0,100,0),
(@PATH,14,-560.0819,2057.4458,95.99662,0,0,0,0,100,0),
(@PATH,15,-557.43933,2036.3041,98.764565,0,0,0,0,100,0),
(@PATH,16,-557.3419,2005.0006,98.851204,0,0,0,0,100,0);

-- Pathing for Dreadcaller Entry: 19434
SET @NPC := 69503;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-510.05405,`position_y`=1977.3759,`position_z`=84.205055,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-510.05405,1977.3759,84.205055,0,0,0,0,100,0),
(@PATH,2,-489.69867,2005.691,90.195114,0,0,0,0,100,0),
(@PATH,3,-474.18164,2037.0684,93.60107,0,0,0,0,100,0),
(@PATH,4,-455.81033,2061.5684,92.97818,0,0,0,0,100,0),
(@PATH,5,-451.51205,2087.3486,91.93046,0,0,0,0,100,0),
(@PATH,6,-464.7294,2121.2507,90.47635,0,0,0,0,100,0),
(@PATH,7,-447.5143,2146.8337,86.96053,0,0,0,0,100,0),
(@PATH,8,-464.7294,2121.2507,90.47635,0,0,0,0,100,0),
(@PATH,9,-451.51205,2087.3486,91.93046,0,0,0,0,100,0),
(@PATH,10,-455.81033,2061.5684,92.97818,0,0,0,0,100,0),
(@PATH,11,-474.18155,2037.1077,93.44042,0,0,0,0,100,0),
(@PATH,12,-489.69867,2005.691,90.195114,0,0,0,0,100,0);

-- Pathing for Dreadcaller Entry: 19434
SET @NPC := 69504;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-525.70953,`position_y`=1978.7291,`position_z`=82.57639,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-525.70953,1978.7291,82.57639,0,0,0,0,100,0),
(@PATH,2,-523.7537,2008.2125,82.431755,0,0,0,0,100,0),
(@PATH,3,-511.72113,2037.9528,81.80964,0,0,0,0,100,0),
(@PATH,4,-498.47278,2070.1345,81.06277,0,0,0,0,100,0),
(@PATH,5,-488.34702,2106.762,78.89144,0,0,0,0,100,0),
(@PATH,6,-497.1836,2127.2341,74.31515,0,0,0,0,100,0),
(@PATH,7,-500.62708,2153.6875,69.16727,0,0,0,0,100,0),
(@PATH,8,-497.1836,2127.2341,74.31515,0,0,0,0,100,0),
(@PATH,9,-488.34702,2106.762,78.89144,0,0,0,0,100,0),
(@PATH,10,-498.4414,2070.1348,81.045555,0,0,0,0,100,0),
(@PATH,11,-511.72113,2037.9528,81.80964,0,0,0,0,100,0),
(@PATH,12,-523.7537,2008.2125,82.431755,0,0,0,0,100,0);

-- Pathing for Vorakem Doomspeaker Entry: 18679 RARE one of 4 spawn points now pathed.
SET @NPC := 151930;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-474.33823,`position_y`=1819.8663,`position_z`=63.420826,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-474.33823,1819.8663,63.420826,0,0,0,0,100,0),
(@PATH,2,-482.40625,1788.6814,50.299965,0,0,0,0,100,0),
(@PATH,3,-490.86795,1760.4255,48.43352,0,0,0,0,100,0),
(@PATH,4,-513.6165,1746.5256,48.456852,0,0,0,0,100,0),
(@PATH,5,-550.99567,1737.6821,51.733818,0,0,0,0,100,0),
(@PATH,6,-567.51495,1756.9401,57.18463,0,0,0,0,100,0),
(@PATH,7,-575.14813,1777.0631,62.810642,0,0,0,0,100,0),
(@PATH,8,-570.4212,1804.2767,66.147995,0,0,0,0,100,0),
(@PATH,9,-552.91473,1816.3512,65.27522,0,0,0,0,100,0),
(@PATH,10,-515.1938,1817.6239,58.753407,0,0,0,0,100,0),
(@PATH,11,-488.46548,1810.9634,60.213062,0,0,0,0,100,0),
(@PATH,12,-455.20987,1803.6133,60.738354,0,0,0,0,100,0),
(@PATH,13,-410.95444,1813.9729,70.741394,0,0,0,0,100,0),
(@PATH,14,-395.25998,1816.9355,72.955154,0,0,0,0,100,0),
(@PATH,15,-387.70898,1843.7389,82.95431,0,0,0,0,100,0),
(@PATH,16,-397.00217,1871.1877,92.73352,0,0,0,0,100,0),
(@PATH,17,-413.73633,1874.1592,92.10692,0,0,0,0,100,0),
(@PATH,18,-439.11295,1877.4731,86.94172,0,0,0,0,100,0),
(@PATH,19,-456.0472,1857.2223,78.3766,0,0,0,0,100,0);

-- Pathing for Dread Tactician Entry: 16959
SET @NPC := 59170;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-295.15604,`position_y`=1585.1027,`position_z`=45.233437,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-295.15604,1585.1027,45.233437,0,0,0,0,100,0),
(@PATH,2,-312.2053,1568.9924,46.25256,0,0,0,0,100,0),
(@PATH,3,-334.09836,1543.7533,45.24116,0,0,0,0,100,0),
(@PATH,4,-330.7915,1499.6769,33.410545,0,0,0,0,100,0),
(@PATH,5,-305.97418,1485.3833,29.533348,0,0,0,0,100,0),
(@PATH,6,-278.9746,1485.0664,26.669733,0,0,0,0,100,0),
(@PATH,7,-267.62842,1503.7903,27.890972,0,0,0,0,100,0),
(@PATH,8,-278.5529,1506.7487,29.443096,0,0,0,0,100,0),
(@PATH,9,-296.352,1498.0455,30.372492,0,0,0,0,100,0),
(@PATH,10,-317.38873,1501.7198,33.08825,0,0,0,0,100,0),
(@PATH,11,-325.35477,1509.3131,35.206413,0,0,0,0,100,0),
(@PATH,12,-328.65067,1539.1844,42.729454,0,0,0,0,100,0),
(@PATH,13,-307.07666,1556.2144,41.623863,0,0,0,0,100,0),
(@PATH,14,-282.09195,1553.3859,35.782814,0,0,0,0,100,0),
(@PATH,15,-268.9562,1558.2101,34.82322,0,0,0,0,100,0),
(@PATH,16,-276.4884,1575.9408,38.929726,0,0,0,0,100,0);

-- Pathing for Dread Tactician Entry: 16959
SET @NPC := 59171;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-89.56852,`position_y`=1516.2761,`position_z`=31.522285,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-89.56852,1516.2761,31.522285,0,0,0,0,100,0),
(@PATH,2,-88.208984,1545.248,39.61205,0,0,0,0,100,0),
(@PATH,3,-110.45606,1566.6775,42.097195,0,0,0,0,100,0),
(@PATH,4,-134.73026,1571.1938,40.62461,0,0,0,0,100,0),
(@PATH,5,-164.36969,1573.1732,35.20005,0,0,0,0,100,0),
(@PATH,6,-164.08405,1579.8978,36.366066,0,0,0,0,100,0),
(@PATH,7,-144.3336,1584.4817,41.059303,0,0,0,0,100,0),
(@PATH,8,-109.36263,1581.0221,46.17117,0,0,0,0,100,0),
(@PATH,9,-84.37858,1569.6322,46.29124,0,0,0,0,100,0),
(@PATH,10,-69.36133,1540.2734,37.61205,0,0,0,0,100,0),
(@PATH,11,-72.20546,1515.6168,32.322334,0,0,0,0,100,0),
(@PATH,12,-85.16211,1487.4629,27.806923,0,0,0,0,100,0),
(@PATH,13,-102.48839,1477.5349,27.377157,0,0,0,0,100,0),
(@PATH,14,-137.48215,1476.9768,26.370176,0,0,0,0,100,0),
(@PATH,15,-153.94423,1488.0822,27.13812,0,0,0,0,100,0),
(@PATH,16,-178.74902,1510.9625,27.167452,0,0,0,0,100,0),
(@PATH,17,-185.49626,1510.2062,26.951632,0,0,0,0,100,0),
(@PATH,18,-169.9961,1488.499,26.564991,0,0,0,0,100,0),
(@PATH,19,-147.77473,1475.0769,25.78192,0,0,0,0,100,0),
(@PATH,20,-120.52837,1482.918,28.664022,0,0,0,0,100,0),
(@PATH,21,-94.96957,1495.6917,30.731728,0,0,0,0,100,0);

-- Pathing for Terrorfiend Entry: 16951
SET @NPC := 59117;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3.567763,`position_y`=3504.7368,`position_z`=60.200336,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3.567763,3504.7368,60.200336,0,0,0,0,100,0),
(@PATH,2,12.402127,3516.1917,61.581196,0,0,0,0,100,0),
(@PATH,3,12.751953,3542.7322,60.610134,0,0,0,0,100,0),
(@PATH,4,16.714247,3512.792,61.790424,0,0,0,0,100,0),
(@PATH,5,33.830677,3492.9504,60.209126,0,0,0,0,100,0),
(@PATH,6,41.888348,3480.3452,60.413105,0,0,0,0,100,0),
(@PATH,7,54.298122,3483.8857,60.849873,0,0,0,0,100,0),
(@PATH,8,63.191517,3503.4907,61.273342,0,0,0,0,100,0),
(@PATH,9,64.31907,3523.5847,60.259304,0,0,0,0,100,0),
(@PATH,10,53.26872,3532.8147,60.875393,0,0,0,0,100,0),
(@PATH,11,66.68658,3554.2395,60.39821,0,0,0,0,100,0),
(@PATH,12,53.917534,3535.6243,60.23781,0,0,0,0,100,0),
(@PATH,13,64.269424,3521.1702,60.081203,0,0,0,0,100,0),
(@PATH,14,83.99688,3518.7317,61.831196,0,0,0,0,100,0),
(@PATH,15,90.631836,3534.5256,61.198868,0,0,0,0,100,0),
(@PATH,16,114.03828,3521.1843,60.94695,0,0,0,0,100,0),
(@PATH,17,150.33054,3515.607,60.41457,0,0,0,0,100,0),
(@PATH,18,159.06602,3493.54,60.98869,0,0,0,0,100,0),
(@PATH,19,180.18948,3470.4077,60.36099,0,0,0,0,100,0),
(@PATH,20,157.98172,3507.0388,60.17397,0,0,0,0,100,0),
(@PATH,21,124.221,3518.9814,60.497364,0,0,0,0,100,0),
(@PATH,22,92.90053,3521.582,60.139423,0,0,0,0,100,0),
(@PATH,23,85.53622,3496.3584,59.786045,0,0,0,0,100,0),
(@PATH,24,92.90053,3521.582,60.139423,0,0,0,0,100,0),
(@PATH,25,124.221,3518.9814,60.497364,0,0,0,0,100,0),
(@PATH,26,157.98172,3507.0388,60.17397,0,0,0,0,100,0),
(@PATH,27,180.18948,3470.4077,60.36099,0,0,0,0,100,0),
(@PATH,28,159.06602,3493.54,60.98869,0,0,0,0,100,0),
(@PATH,29,150.33054,3515.607,60.41457,0,0,0,0,100,0),
(@PATH,30,114.03828,3521.1843,60.94695,0,0,0,0,100,0),
(@PATH,31,90.631836,3534.5256,61.198868,0,0,0,0,100,0),
(@PATH,32,83.99688,3518.7317,61.831196,0,0,0,0,100,0),
(@PATH,33,64.269424,3521.1702,60.081203,0,0,0,0,100,0),
(@PATH,34,53.917534,3535.6243,60.23781,0,0,0,0,100,0),
(@PATH,35,66.68658,3554.2395,60.39821,0,0,0,0,100,0),
(@PATH,36,53.26872,3532.8147,60.875393,0,0,0,0,100,0),
(@PATH,37,64.31907,3523.5847,60.259304,0,0,0,0,100,0),
(@PATH,38,63.191517,3503.4907,61.273342,0,0,0,0,100,0),
(@PATH,39,54.298122,3483.8857,60.849873,0,0,0,0,100,0),
(@PATH,40,41.888348,3480.3452,60.413105,0,0,0,0,100,0),
(@PATH,41,33.830677,3492.9504,60.209126,0,0,0,0,100,0),
(@PATH,42,16.714247,3512.792,61.790424,0,0,0,0,100,0),
(@PATH,43,12.751953,3542.7322,60.610134,0,0,0,0,100,0),
(@PATH,44,12.402127,3516.1917,61.581196,0,0,0,0,100,0);

-- Pathing for Terrorfiend Entry: 16951
SET @NPC := 59112;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=139.45465,`position_y`=3492.2668,`position_z`=63.600018,`curhealth`=1,`curmana`=0 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,139.45465,3492.2668,63.600018,0,0,0,0,100,0),
(@PATH,2,166.66211,3470.2207,62.100018,0,0,0,0,100,0),
(@PATH,3,200.3527,3461.319,62.823513,0,0,0,0,100,0),
(@PATH,4,233.67665,3457.6814,62.559986,0,0,0,0,100,0),
(@PATH,5,266.2675,3434.2861,63.17107,0,0,0,0,100,0),
(@PATH,6,233.67665,3457.6814,62.559986,0,0,0,0,100,0),
(@PATH,7,200.3527,3461.319,62.823513,0,0,0,0,100,0),
(@PATH,8,166.66867,3470.181,61.940823,0,0,0,0,100,0);

-- Pathing for Bonechewer Raider Entry: 16925
SET @NPC := 58708;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-333.0693,`position_y`=2627.497,`position_z`=41.20707 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,17408,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-333.0693,2627.497,41.20707,0,0,0,0,100,0),
(@PATH,2,-314.10547,2611.4246,40.944252,0,0,0,0,100,0),
(@PATH,3,-312.70056,2588.055,41.26893,0,0,0,0,100,0),
(@PATH,4,-300.88733,2569.0312,40.75892,0,0,0,0,100,0),
(@PATH,5,-299.0996,2549.5664,41.5057,0,0,0,0,100,0),
(@PATH,6,-303.79843,2522.7349,42.36698,0,0,0,0,100,0),
(@PATH,7,-299.07388,2549.5547,41.542564,0,0,0,0,100,0),
(@PATH,8,-300.88733,2569.0312,40.75892,0,0,0,0,100,0),
(@PATH,9,-312.70056,2588.055,41.26893,0,0,0,0,100,0),
(@PATH,10,-314.10547,2611.4246,40.944252,0,0,0,0,100,0);

-- Pathing for Bonechewer Raider Entry: 16925
SET @NPC := 29980;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-355.80392,`position_y`=2661.4302,`position_z`=41.94869 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,17408,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-355.80392,2661.4302,41.94869,0,0,0,0,100,0),
(@PATH,2,-345.59753,2673.298,37.361477,0,0,0,0,100,0),
(@PATH,3,-331.67078,2681.8074,33.13684,0,0,0,0,100,0),
(@PATH,4,-318.90857,2687.2388,30.458128,0,0,0,0,100,0),
(@PATH,5,-317.85205,2695.4302,28.832518,0,0,0,0,100,0),
(@PATH,6,-324.4281,2717.2317,24.64143,0,0,0,0,100,0),
(@PATH,7,-319.3905,2730.4993,22.588207,0,0,0,0,100,0),
(@PATH,8,-322.38223,2746.8567,18.341698,0,0,0,0,100,0),
(@PATH,9,-341.0169,2752.74,18.493107,0,0,0,0,100,0),
(@PATH,10,-322.38223,2746.8567,18.341698,0,0,0,0,100,0),
(@PATH,11,-319.3905,2730.4993,22.588207,0,0,0,0,100,0),
(@PATH,12,-324.4281,2717.2317,24.64143,0,0,0,0,100,0),
(@PATH,13,-317.85205,2695.4302,28.832518,0,0,0,0,100,0),
(@PATH,14,-318.90857,2687.2388,30.458128,0,0,0,0,100,0),
(@PATH,15,-331.67078,2681.8074,33.13684,0,0,0,0,100,0),
(@PATH,16,-345.59753,2673.298,37.361477,0,0,0,0,100,0);

-- Pathing for Bonechewer Raider Entry: 16925
SET @NPC := 58710;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-179.32472,`position_y`=2412.1216,`position_z`=48.049675 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,17408,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-179.32472,2412.1216,48.049675,0,0,0,0,100,0),
(@PATH,2,-182.65298,2395.4773,50.123314,0,0,0,0,100,0),
(@PATH,3,-177.50235,2388.4993,51.210716,0,0,0,0,100,0),
(@PATH,4,-171.63947,2374.9531,54.302025,0,0,0,0,100,0),
(@PATH,5,-168.40721,2360.0513,56.960583,0,0,0,0,100,0),
(@PATH,6,-167.21858,2346.2454,59.363537,0,0,0,0,100,0),
(@PATH,7,-176.93669,2336.8157,59.973522,0,0,0,0,100,0),
(@PATH,8,-167.21858,2346.2454,59.363537,0,0,0,0,100,0),
(@PATH,9,-168.40721,2360.0513,56.960583,0,0,0,0,100,0),
(@PATH,10,-171.63947,2374.9531,54.302025,0,0,0,0,100,0),
(@PATH,11,-177.50235,2388.4993,51.210716,0,0,0,0,100,0),
(@PATH,12,-182.65298,2395.4773,50.123314,0,0,0,0,100,0);

-- Pathing for Bonechewer Raider Entry: 16925
SET @NPC := 58705;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-393.1904,`position_y`=2889.1326,`position_z`=7.4396896 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,17408,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-393.1904,2889.1326,7.4396896,0,0,0,0,100,0),
(@PATH,2,-405.51758,2909.7344,15.205551,0,0,0,0,100,0),
(@PATH,3,-422.75626,2911.7122,18.937973,0,0,0,0,100,0),
(@PATH,4,-439.79425,2924.293,19.83089,0,0,0,0,100,0),
(@PATH,5,-444.5871,2941.0083,15.811787,0,0,0,0,100,0),
(@PATH,6,-436.8235,2954.842,10.215107,0,0,0,0,100,0),
(@PATH,7,-447.32587,2970.301,8.519625,0,0,0,0,100,0),
(@PATH,8,-436.8235,2954.842,10.215107,0,0,0,0,100,0),
(@PATH,9,-444.5871,2941.0083,15.811787,0,0,0,0,100,0),
(@PATH,10,-439.79425,2924.293,19.83089,0,0,0,0,100,0),
(@PATH,11,-422.75626,2911.7122,18.937973,0,0,0,0,100,0),
(@PATH,12,-405.54245,2909.7732,15.1020355,0,0,0,0,100,0);

-- Pathing for Bonechewer Raider Entry: 16925
SET @NPC := 58704;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-484.85156,`position_y`=2978.231,`position_z`=10.56395 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,17408,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-484.85156,2978.231,10.56395,0,0,0,0,100,0),
(@PATH,2,-470.42795,2965.707,12.804433,0,0,0,0,100,0),
(@PATH,3,-455.43442,2971.357,8.522066,0,0,0,0,100,0),
(@PATH,4,-438.72614,2965.0664,8.5927925,0,0,0,0,100,0),
(@PATH,5,-446.6874,2950.046,14.318378,0,0,0,0,100,0),
(@PATH,6,-442.1708,2931.7703,18.081501,0,0,0,0,100,0),
(@PATH,7,-430.70285,2914.2336,19.780014,0,0,0,0,100,0),
(@PATH,8,-402.7578,2912.6475,13.955551,0,0,0,0,100,0),
(@PATH,9,-405.8217,2887.4688,13.373669,0,0,0,0,100,0),
(@PATH,10,-402.64267,2912.6287,13.927109,0,0,0,0,100,0),
(@PATH,11,-430.5879,2914.2148,19.830551,0,0,0,0,100,0),
(@PATH,12,-442.1708,2931.7703,18.081501,0,0,0,0,100,0),
(@PATH,13,-446.6874,2950.046,14.318378,0,0,0,0,100,0),
(@PATH,14,-438.72614,2965.0664,8.5927925,0,0,0,0,100,0),
(@PATH,15,-455.43442,2971.357,8.522066,0,0,0,0,100,0),
(@PATH,16,-470.3711,2965.7168,12.63268,0,0,0,0,100,0);

-- Pathing for Bonechewer Raider Entry: 16925
SET @NPC := 58703;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-182.98262,`position_y`=2754.4424,`position_z`=29.359642 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,17408,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-182.98262,2754.4424,29.359642,0,0,0,0,100,0),
(@PATH,2,-167.27911,2762.397,35.033104,0,0,0,0,100,0),
(@PATH,3,-153.41086,2770.5464,38.923515,0,0,0,0,100,0),
(@PATH,4,-145.51408,2778.5596,39.842705,0,0,0,0,100,0),
(@PATH,5,-150.62086,2789.044,37.583183,0,0,0,0,100,0),
(@PATH,6,-171.18394,2783.7551,32.133442,0,0,0,0,100,0),
(@PATH,7,-189.0068,2784.242,27.13271,0,0,0,0,100,0),
(@PATH,8,-190.6546,2803.8613,24.178295,0,0,0,0,100,0),
(@PATH,9,-187.46225,2812.5396,24.02644,0,0,0,0,100,0),
(@PATH,10,-185.15848,2822.96,22.96394,0,0,0,0,100,0),
(@PATH,11,-186.74487,2838.4292,21.392303,0,0,0,0,100,0),
(@PATH,12,-181.95459,2844.1023,22.213226,0,0,0,0,100,0),
(@PATH,13,-162.62413,2836.6028,27.339367,0,0,0,0,100,0),
(@PATH,14,-146.12909,2856.5813,28.25343,0,0,0,0,100,0),
(@PATH,15,-162.62413,2836.6028,27.339367,0,0,0,0,100,0),
(@PATH,16,-181.95459,2844.1023,22.213226,0,0,0,0,100,0),
(@PATH,17,-186.74487,2838.4292,21.392303,0,0,0,0,100,0),
(@PATH,18,-185.15848,2822.96,22.96394,0,0,0,0,100,0),
(@PATH,19,-187.46225,2812.5396,24.02644,0,0,0,0,100,0),
(@PATH,20,-190.6546,2803.8613,24.178295,0,0,0,0,100,0),
(@PATH,21,-189.0068,2784.242,27.13271,0,0,0,0,100,0),
(@PATH,22,-171.18394,2783.7551,32.133442,0,0,0,0,100,0),
(@PATH,23,-150.62086,2789.044,37.583183,0,0,0,0,100,0),
(@PATH,24,-145.51408,2778.5596,39.842705,0,0,0,0,100,0),
(@PATH,25,-153.41086,2770.5464,38.923515,0,0,0,0,100,0),
(@PATH,26,-167.27911,2762.397,35.033104,0,0,0,0,100,0);

-- Pathing for Bonechewer Raider Entry: 16925
SET @NPC := 58707;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-167.91798,`position_y`=2587.1328,`position_z`=39.15184 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,17408,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-167.91798,2587.1328,39.15184,0,0,0,0,100,0),
(@PATH,2,-170.89156,2594.0034,38.989365,0,0,0,0,100,0),
(@PATH,3,-163.80977,2600.0264,39.704742,0,0,0,0,100,0),
(@PATH,4,-167.0926,2612.1177,39.605923,0,0,0,0,100,0),
(@PATH,5,-164.81042,2624.6167,41.011383,0,0,0,0,100,0),
(@PATH,6,-172.30147,2637.9514,40.82253,0,0,0,0,100,0),
(@PATH,7,-169.16624,2646.859,41.711445,0,0,0,0,100,0),
(@PATH,8,-169.92262,2658.6233,42.08022,0,0,0,0,100,0),
(@PATH,9,-171.7312,2672.7693,42.522045,0,0,0,0,100,0),
(@PATH,10,-181.24826,2687.2483,39.84602,0,0,0,0,100,0),
(@PATH,11,-171.7312,2672.7693,42.522045,0,0,0,0,100,0),
(@PATH,12,-169.92262,2658.6233,42.08022,0,0,0,0,100,0),
(@PATH,13,-169.16624,2646.859,41.711445,0,0,0,0,100,0),
(@PATH,14,-172.30147,2637.9514,40.82253,0,0,0,0,100,0),
(@PATH,15,-164.81042,2624.6167,41.011383,0,0,0,0,100,0),
(@PATH,16,-167.0926,2612.1177,39.605923,0,0,0,0,100,0),
(@PATH,17,-163.80977,2600.0264,39.704742,0,0,0,0,100,0),
(@PATH,18,-170.89156,2594.0034,38.989365,0,0,0,0,100,0);

-- Pathing for Bonechewer Raider Entry: 16925
SET @NPC := 58709;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-294.74057,`position_y`=2486.1965,`position_z`=39.986763 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,17408,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-294.74057,2486.1965,39.986763,0,0,0,0,100,0),
(@PATH,2,-284.57855,2477.3665,40.42182,0,0,0,0,100,0),
(@PATH,3,-297.11038,2470.6064,40.85517,0,0,0,0,100,0),
(@PATH,4,-297.7681,2457.1558,41.471195,0,0,0,0,100,0),
(@PATH,5,-287.72488,2443.6045,43.267094,0,0,0,0,100,0),
(@PATH,6,-297.65518,2433.133,43.743546,0,0,0,0,100,0),
(@PATH,7,-296.91296,2419.6938,45.004898,0,0,0,0,100,0),
(@PATH,8,-283.33234,2417.445,46.531998,0,0,0,0,100,0),
(@PATH,9,-274.4911,2399.8975,49.778664,0,0,0,0,100,0),
(@PATH,10,-283.4122,2378.754,49.444923,0,0,0,0,100,0),
(@PATH,11,-274.4911,2399.8975,49.778664,0,0,0,0,100,0),
(@PATH,12,-283.33234,2417.445,46.531998,0,0,0,0,100,0),
(@PATH,13,-296.91296,2419.6938,45.004898,0,0,0,0,100,0),
(@PATH,14,-297.65518,2433.133,43.743546,0,0,0,0,100,0),
(@PATH,15,-287.72488,2443.6045,43.267094,0,0,0,0,100,0),
(@PATH,16,-297.7681,2457.1558,41.471195,0,0,0,0,100,0),
(@PATH,17,-297.11038,2470.6064,40.85517,0,0,0,0,100,0),
(@PATH,18,-284.57855,2477.3665,40.42182,0,0,0,0,100,0);

-- Pathing for Tagar Spinebreaker Entry: 19443
SET @NPC := 85987;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-180.73253,`position_y`=2840.1667,`position_z`=23.000702 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-180.73253,2840.1667,23.000702,0,0,0,0,100,0),
(@PATH,2,-165.3999,2836.7878,26.73048,0,0,0,0,100,0),
(@PATH,3,-148.44771,2826.1829,33.976418,0,0,0,0,100,0),
(@PATH,4,-149.44527,2809.8828,35.488747,0,0,0,0,100,0),
(@PATH,5,-161.59299,2806.9485,32.174904,0,0,0,0,100,0),
(@PATH,6,-175.54439,2802.3525,28.92329,0,0,0,0,100,0),
(@PATH,7,-188.46767,2810.5212,24.094921,0,0,0,0,100,0),
(@PATH,8,-186.12239,2795.5034,26.38808,0,0,0,0,100,0),
(@PATH,9,-152.85352,2788.3652,37.116875,0,0,0,0,100,0),
(@PATH,10,-130.35672,2775.5452,41.480064,0,0,0,0,100,0),
(@PATH,11,-118.91873,2750.039,49.628666,0,0,0,0,100,0),
(@PATH,12,-105.78239,2731.5012,52.56415,0,0,0,0,100,0),
(@PATH,13,-109.77897,2700.4583,50.216007,0,0,0,0,100,0),
(@PATH,14,-136.54475,2692.5806,46.02975,0,0,0,0,100,0),
(@PATH,15,-167.03163,2686.46,43.08601,0,0,0,0,100,0),
(@PATH,16,-173.8719,2678.0442,42.39021,0,0,0,0,100,0),
(@PATH,17,-169.27815,2651.4932,41.80959,0,0,0,0,100,0),
(@PATH,18,-166.301,2628.3018,41.239655,0,0,0,0,100,0),
(@PATH,19,-164.80984,2612.3525,39.959625,0,0,0,0,100,0),
(@PATH,20,-162.83182,2603.218,39.822174,0,0,0,0,100,0),
(@PATH,21,-168.36334,2594.324,39.292587,0,0,0,0,100,0),
(@PATH,22,-161.93185,2585.89,39.861015,0,0,0,0,100,0),
(@PATH,23,-140.91954,2565.5798,41.344887,0,0,0,0,100,0),
(@PATH,24,-146.71484,2543.3213,41.35856,0,0,0,0,100,0),
(@PATH,25,-162.32063,2537.2864,42.567543,0,0,0,0,100,0),
(@PATH,26,-172.34918,2527.5469,41.081963,0,0,0,0,100,0),
(@PATH,27,-177.55148,2518.2568,40.714043,0,0,0,0,100,0),
(@PATH,28,-175.16563,2507.058,42.243828,0,0,0,0,100,0),
(@PATH,29,-163.22688,2495.3784,43.848873,0,0,0,0,100,0),
(@PATH,30,-142.46675,2500.6746,45.44909,0,0,0,0,100,0),
(@PATH,31,-125.05936,2492.918,46.72667,0,0,0,0,100,0),
(@PATH,32,-118.48584,2470.2834,46.80577,0,0,0,0,100,0),
(@PATH,33,-129.53337,2458.865,47.11806,0,0,0,0,100,0),
(@PATH,34,-137.662,2446.2883,45.332626,0,0,0,0,100,0),
(@PATH,35,-143.6135,2429.3025,48.670307,0,0,0,0,100,0),
(@PATH,36,-155.9585,2418.1587,44.624165,0,0,0,0,100,0),
(@PATH,37,-170.86676,2413.7427,48.186516,0,0,0,0,100,0),
(@PATH,38,-181.61177,2401.9646,49.195427,0,0,0,0,100,0),
(@PATH,39,-181.4586,2393.3577,50.290062,0,0,0,0,100,0),
(@PATH,40,-174.02588,2386.1682,51.767113,0,0,0,0,100,0),
(@PATH,41,-169.87056,2379.3284,53.68618,0,0,0,0,100,0),
(@PATH,42,-168.52002,2364.6008,56.289562,0,0,0,0,100,0),
(@PATH,43,-167.87294,2349.3083,58.749645,0,0,0,0,100,0),
(@PATH,44,-168.67648,2338.4624,60.569225,0,0,0,0,100,0),
(@PATH,45,-177.4344,2325.3066,62.10829,0,0,0,0,100,0),
(@PATH,46,-193.972,2316.471,55.185318,0,0,0,0,100,0),
(@PATH,47,-224.26807,2309.8142,49.53231,0,0,0,0,100,0),
(@PATH,48,-244.99983,2311.9019,51.73676,0,0,0,0,100,0),
(@PATH,49,-258.90323,2325.336,56.744205,0,0,0,0,100,0),
(@PATH,50,-270.11795,2336.4402,54.068264,0,0,0,0,100,0),
(@PATH,51,-285.83356,2348.487,51.24258,0,0,0,0,100,0),
(@PATH,52,-275.53027,2365.6165,50.668728,0,0,0,0,100,0),
(@PATH,53,-277.8916,2385.711,48.822,0,0,0,0,100,0),
(@PATH,54,-276.86295,2401.864,49.40187,0,0,0,0,100,0),
(@PATH,55,-282.97598,2416.1016,46.818253,0,0,0,0,100,0),
(@PATH,56,-296.67487,2419.1567,44.976578,0,0,0,0,100,0),
(@PATH,57,-297.5943,2428.9663,44.063004,0,0,0,0,100,0),
(@PATH,58,-290.92426,2436.451,43.875492,0,0,0,0,100,0),
(@PATH,59,-293.61343,2451.263,42.09815,0,0,0,0,100,0),
(@PATH,60,-299.42102,2460.9336,41.187626,0,0,0,0,100,0),
(@PATH,61,-291.53787,2471.7947,40.73017,0,0,0,0,100,0),
(@PATH,62,-300.1674,2481.248,40.285805,0,0,0,0,100,0),
(@PATH,63,-316.477,2478.6626,38.431313,0,0,0,0,100,0),
(@PATH,64,-336.8055,2478.9639,29.2773,0,0,0,0,100,0),
(@PATH,65,-366.60358,2481.7075,27.007036,0,0,0,0,100,0),
(@PATH,66,-382.4619,2489.2385,35.944138,0,0,0,0,100,0),
(@PATH,67,-384.27344,2500.5776,43.13384,0,0,0,0,100,0),
(@PATH,68,-372.57944,2518.9688,44.3698,0,0,0,0,100,0),
(@PATH,69,-356.1326,2524.8704,43.68792,0,0,0,0,100,0),
(@PATH,70,-341.2596,2517.1814,42.199883,0,0,0,0,100,0),
(@PATH,71,-324.73026,2514.0073,39.774696,0,0,0,0,100,0),
(@PATH,72,-308.2558,2522.323,42.33207,0,0,0,0,100,0),
(@PATH,73,-303.01553,2544.1267,42.1657,0,0,0,0,100,0),
(@PATH,74,-306.46387,2559.6125,43.08623,0,0,0,0,100,0),
(@PATH,75,-319.70108,2564.6467,44.56841,0,0,0,0,100,0),
(@PATH,76,-326.02637,2576.755,44.598763,0,0,0,0,100,0),
(@PATH,77,-315.11752,2592.7844,41.116096,0,0,0,0,100,0),
(@PATH,78,-315.11615,2608.5195,41.109413,0,0,0,0,100,0),
(@PATH,79,-340.187,2619.5437,42.697315,0,0,0,0,100,0),
(@PATH,80,-353.40903,2634.2236,39.989338,0,0,0,0,100,0),
(@PATH,81,-360.7138,2656.5867,43.492878,0,0,0,0,100,0),
(@PATH,82,-343.86783,2682.2961,35.192898,0,0,0,0,100,0),
(@PATH,83,-333.8743,2701.39,29.5256,0,0,0,0,100,0),
(@PATH,84,-324.5292,2712.5708,25.903393,0,0,0,0,100,0),
(@PATH,85,-322.72928,2726.5747,23.196606,0,0,0,0,100,0),
(@PATH,86,-328.44092,2738.122,21.601707,0,0,0,0,100,0),
(@PATH,87,-344.13916,2742.767,22.06757,0,0,0,0,100,0),
(@PATH,88,-370.19467,2739.405,27.66764,0,0,0,0,100,0),
(@PATH,89,-394.21548,2733.2817,34.96598,0,0,0,0,100,0),
(@PATH,90,-417.46875,2742.0251,40.00116,0,0,0,0,100,0),
(@PATH,91,-437.00967,2742.231,45.185448,0,0,0,0,100,0),
(@PATH,92,-464.1363,2757.4255,49.97451,0,0,0,0,100,0),
(@PATH,93,-482.14127,2780.4436,50.48174,0,0,0,0,100,0),
(@PATH,94,-474.82205,2803.1702,44.831837,0,0,0,0,100,0),
(@PATH,95,-458.1045,2835.9102,34.73303,0,0,0,0,100,0),
(@PATH,96,-431.37708,2863.7495,23.182325,0,0,0,0,100,0),
(@PATH,97,-410.33908,2897.4436,16.297375,0,0,0,0,100,0),
(@PATH,98,-431.36655,2916.5745,19.332748,0,0,0,0,100,0),
(@PATH,99,-444.449,2935.541,17.371601,0,0,0,0,100,0),
(@PATH,100,-438.6376,2967.6208,7.9428425,0,0,0,0,100,0),
(@PATH,101,-444.449,2935.541,17.371601,0,0,0,0,100,0),
(@PATH,102,-431.36655,2916.5745,19.332748,0,0,0,0,100,0),
(@PATH,103,-410.33908,2897.4436,16.297375,0,0,0,0,100,0),
(@PATH,104,-431.37708,2863.7495,23.182325,0,0,0,0,100,0),
(@PATH,105,-458.1045,2835.9102,34.73303,0,0,0,0,100,0),
(@PATH,106,-474.82205,2803.1702,44.831837,0,0,0,0,100,0),
(@PATH,107,-482.14127,2780.4436,50.48174,0,0,0,0,100,0),
(@PATH,108,-464.1363,2757.4255,49.97451,0,0,0,0,100,0),
(@PATH,109,-437.00967,2742.231,45.185448,0,0,0,0,100,0),
(@PATH,110,-417.46875,2742.0251,40.00116,0,0,0,0,100,0),
(@PATH,111,-394.21548,2733.2817,34.96598,0,0,0,0,100,0),
(@PATH,112,-370.19467,2739.405,27.66764,0,0,0,0,100,0),
(@PATH,113,-344.13916,2742.767,22.06757,0,0,0,0,100,0),
(@PATH,114,-328.44092,2738.122,21.601707,0,0,0,0,100,0),
(@PATH,115,-322.72928,2726.5747,23.196606,0,0,0,0,100,0),
(@PATH,116,-324.5292,2712.5708,25.903393,0,0,0,0,100,0),
(@PATH,117,-333.8743,2701.39,29.5256,0,0,0,0,100,0),
(@PATH,118,-343.86783,2682.2961,35.192898,0,0,0,0,100,0),
(@PATH,119,-360.7138,2656.5867,43.492878,0,0,0,0,100,0),
(@PATH,120,-353.40903,2634.2236,39.989338,0,0,0,0,100,0),
(@PATH,121,-340.187,2619.5437,42.697315,0,0,0,0,100,0),
(@PATH,122,-315.11615,2608.5195,41.109413,0,0,0,0,100,0),
(@PATH,123,-315.11752,2592.7844,41.116096,0,0,0,0,100,0),
(@PATH,124,-326.02637,2576.755,44.598763,0,0,0,0,100,0),
(@PATH,125,-319.70108,2564.6467,44.56841,0,0,0,0,100,0),
(@PATH,126,-306.46387,2559.6125,43.08623,0,0,0,0,100,0),
(@PATH,127,-303.01553,2544.1267,42.1657,0,0,0,0,100,0),
(@PATH,128,-308.2558,2522.323,42.33207,0,0,0,0,100,0),
(@PATH,129,-324.73026,2514.0073,39.774696,0,0,0,0,100,0),
(@PATH,130,-341.2596,2517.1814,42.199883,0,0,0,0,100,0),
(@PATH,131,-356.1326,2524.8704,43.68792,0,0,0,0,100,0),
(@PATH,132,-372.57944,2518.9688,44.3698,0,0,0,0,100,0),
(@PATH,133,-384.27344,2500.5776,43.13384,0,0,0,0,100,0),
(@PATH,134,-382.4619,2489.2385,35.944138,0,0,0,0,100,0),
(@PATH,135,-366.60358,2481.7075,27.007036,0,0,0,0,100,0),
(@PATH,136,-336.8055,2478.9639,29.2773,0,0,0,0,100,0),
(@PATH,137,-316.477,2478.6626,38.431313,0,0,0,0,100,0),
(@PATH,138,-300.1674,2481.248,40.285805,0,0,0,0,100,0),
(@PATH,139,-291.53787,2471.7947,40.73017,0,0,0,0,100,0),
(@PATH,140,-299.42102,2460.9336,41.187626,0,0,0,0,100,0),
(@PATH,141,-293.61343,2451.263,42.09815,0,0,0,0,100,0),
(@PATH,142,-290.92426,2436.451,43.875492,0,0,0,0,100,0),
(@PATH,143,-297.5943,2428.9663,44.063004,0,0,0,0,100,0),
(@PATH,144,-296.67487,2419.1567,44.976578,0,0,0,0,100,0),
(@PATH,145,-283.0039,2416.1074,46.688004,0,0,0,0,100,0),
(@PATH,146,-276.86295,2401.864,49.40187,0,0,0,0,100,0),
(@PATH,147,-277.8916,2385.711,48.822,0,0,0,0,100,0),
(@PATH,148,-275.53027,2365.6165,50.668728,0,0,0,0,100,0),
(@PATH,149,-285.83356,2348.487,51.24258,0,0,0,0,100,0),
(@PATH,150,-270.11795,2336.4402,54.068264,0,0,0,0,100,0),
(@PATH,151,-258.90323,2325.336,56.744205,0,0,0,0,100,0),
(@PATH,152,-244.99983,2311.9019,51.73676,0,0,0,0,100,0),
(@PATH,153,-224.26807,2309.8142,49.53231,0,0,0,0,100,0),
(@PATH,154,-193.972,2316.471,55.185318,0,0,0,0,100,0),
(@PATH,155,-177.4344,2325.3066,62.10829,0,0,0,0,100,0),
(@PATH,156,-168.67648,2338.4624,60.569225,0,0,0,0,100,0),
(@PATH,157,-167.87294,2349.3083,58.749645,0,0,0,0,100,0),
(@PATH,158,-168.52002,2364.6008,56.289562,0,0,0,0,100,0),
(@PATH,159,-169.87056,2379.3284,53.68618,0,0,0,0,100,0),
(@PATH,160,-174.02734,2386.164,51.76809,0,0,0,0,100,0),
(@PATH,161,-181.4586,2393.3577,50.290062,0,0,0,0,100,0),
(@PATH,162,-181.61177,2401.9646,49.195427,0,0,0,0,100,0),
(@PATH,163,-170.86676,2413.7427,48.186516,0,0,0,0,100,0),
(@PATH,164,-155.9585,2418.1587,44.624165,0,0,0,0,100,0),
(@PATH,165,-143.6135,2429.3025,48.670307,0,0,0,0,100,0),
(@PATH,166,-137.662,2446.2883,45.332626,0,0,0,0,100,0),
(@PATH,167,-129.53337,2458.865,47.11806,0,0,0,0,100,0),
(@PATH,168,-118.48584,2470.2834,46.80577,0,0,0,0,100,0),
(@PATH,169,-125.05936,2492.918,46.72667,0,0,0,0,100,0),
(@PATH,170,-142.46675,2500.6746,45.44909,0,0,0,0,100,0),
(@PATH,171,-163.22688,2495.3784,43.848873,0,0,0,0,100,0),
(@PATH,172,-175.16563,2507.058,42.243828,0,0,0,0,100,0),
(@PATH,173,-177.55148,2518.2568,40.714043,0,0,0,0,100,0),
(@PATH,174,-172.34918,2527.5469,41.081963,0,0,0,0,100,0),
(@PATH,175,-162.32063,2537.2864,42.567543,0,0,0,0,100,0),
(@PATH,176,-146.71153,2543.3176,41.380287,0,0,0,0,100,0),
(@PATH,177,-140.91954,2565.5798,41.344887,0,0,0,0,100,0),
(@PATH,178,-161.93185,2585.89,39.861015,0,0,0,0,100,0),
(@PATH,179,-168.36334,2594.324,39.292587,0,0,0,0,100,0),
(@PATH,180,-162.83182,2603.218,39.822174,0,0,0,0,100,0),
(@PATH,181,-164.80984,2612.3525,39.959625,0,0,0,0,100,0),
(@PATH,182,-166.31055,2628.29,41.17447,0,0,0,0,100,0),
(@PATH,183,-169.27815,2651.4932,41.80959,0,0,0,0,100,0),
(@PATH,184,-173.8719,2678.0442,42.39021,0,0,0,0,100,0),
(@PATH,185,-167.03163,2686.46,43.08601,0,0,0,0,100,0),
(@PATH,186,-136.54475,2692.5806,46.02975,0,0,0,0,100,0),
(@PATH,187,-109.77897,2700.4583,50.216007,0,0,0,0,100,0),
(@PATH,188,-105.78239,2731.5012,52.56415,0,0,0,0,100,0),
(@PATH,189,-118.91873,2750.039,49.628666,0,0,0,0,100,0),
(@PATH,190,-130.35672,2775.5452,41.480064,0,0,0,0,100,0),
(@PATH,191,-152.85211,2788.343,37.01861,0,0,0,0,100,0),
(@PATH,192,-186.1211,2795.4814,26.455463,0,0,0,0,100,0),
(@PATH,193,-188.46767,2810.5212,24.094921,0,0,0,0,100,0),
(@PATH,194,-175.54439,2802.3525,28.92329,0,0,0,0,100,0),
(@PATH,195,-161.59299,2806.9485,32.174904,0,0,0,0,100,0),
(@PATH,196,-149.44527,2809.8828,35.488747,0,0,0,0,100,0),
(@PATH,197,-148.44771,2826.1829,33.976418,0,0,0,0,100,0),
(@PATH,198,-165.3999,2836.7878,26.73048,0,0,0,0,100,0);

-- Pathing for Scout Vanura Entry: 16797
SET @NPC := 57800;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=192.0898,`position_y`=4333.3423,`position_z`=116.44409 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,192.0898,4333.3423,116.44409,0,0,0,0,100,0),
(@PATH,2,154.94,4333.245,107.50594,0,0,0,0,100,0),
(@PATH,3,122.91753,4333.3857,104.86842,0,0,0,0,100,0),
(@PATH,4,90.34354,4333.2275,101.48336,0,0,0,0,100,0),
(@PATH,5,73.1186,4333.1577,101.05235,0,0,0,0,100,0),
(@PATH,6,59.680775,4332.9043,96.16065,0,0,0,0,100,0),
(@PATH,7,73.1186,4333.1577,101.05235,0,0,0,0,100,0),
(@PATH,8,90.34354,4333.2275,101.48336,0,0,0,0,100,0),
(@PATH,9,122.91753,4333.3857,104.86842,0,0,0,0,100,0),
(@PATH,10,154.94,4333.245,107.50594,0,0,0,0,100,0);

-- Pathing for Honor Hold Defender Entry: 16842
SET @NPC := 57948;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-694.93475,`position_y`=2767.0405,`position_z`=95.037445 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-694.93475,2767.0405,95.037445,0,1000,0,0,100,0),
(@PATH,2,-675.24805,2770.6348,93.46518,0,0,0,0,100,0),
(@PATH,3,-660.2137,2763.4387,90.42306,0,1000,0,0,100,0),
(@PATH,4,-675.24805,2770.6348,93.46518,0,0,0,0,100,0);

-- Pathing for Shattered Hand Captain Entry: 16870
SET @NPC := 58210;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-332.40833,`position_y`=2863.274,`position_z`=-47.211987 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-332.40833,2863.274,-47.211987,0,0,0,0,100,0),
(@PATH,2,-340.50162,2857.5168,-43.90273,0,10000,0,0,100,0),
(@PATH,3,-331.96707,2861.0574,-46.64607,0,0,0,0,100,0),
(@PATH,4,-302.23712,2844.8008,-43.38203,0,0,0,0,100,0),
(@PATH,5,-298.5156,2824.7869,-39.235798,0,0,0,0,100,0),
(@PATH,6,-295.14767,2799.8042,-35.91434,0,0,0,0,100,0),
(@PATH,7,-289.08508,2769.4944,-29.577915,0,0,0,0,100,0),
(@PATH,8,-291.53394,2785.8982,-33.417027,0,0,0,0,100,0),
(@PATH,9,-298.31116,2782.176,-32.286167,0,0,0,0,100,0),
(@PATH,10,-299.14856,2800.1082,-35.88094,0,0,0,0,100,0),
(@PATH,11,-310.44876,2837.034,-41.41804,0,0,0,0,100,0);

-- Pathing for Shattered Hand Captain Entry: 16870
SET @NPC := 58214;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-214.12881,`position_y`=2566.5652,`position_z`=7.1540327 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-214.12881,2566.5652,7.1540327,0,0,0,0,100,0),
(@PATH,2,-208.87471,2546.6384,11.437114,0,10000,0,0,100,0),
(@PATH,3,-215.03563,2565.2344,6.987895,0,0,0,0,100,0),
(@PATH,4,-210.11018,2584.3247,5.281192,0,10000,0,0,100,0);

-- Pathing for Shattered Hand Berserker Entry: 16878
SET @NPC := 58296;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-433.02628,`position_y`=3016.6592,`position_z`=-16.493732 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-433.02628,3016.6592,-16.493732,0,0,0,0,100,0),
(@PATH,2,-406.45746,3022.2385,-16.148197,0,0,0,0,100,0),
(@PATH,3,-384.4923,3027.4856,-16.353851,0,0,0,0,100,0),
(@PATH,4,-369.7765,3031.6306,-16.328512,0,0,0,0,100,0),
(@PATH,5,-331.88126,3040.104,-16.655672,0,0,0,0,100,0),
(@PATH,6,-323.32254,3038.5364,-16.43634,0,0,0,0,100,0),
(@PATH,7,-318.31235,3033.3577,-15.979837,0,0,0,0,100,0),
(@PATH,8,-289.71497,3032.069,-8.278463,0,0,0,0,100,0),
(@PATH,9,-279.97885,3038.2961,-4.9714665,0,0,0,0,100,0),
(@PATH,10,-282.3609,3047.8403,-4.3587236,0,0,0,0,100,0),
(@PATH,11,-269.63672,3050.605,-4.484898,0,0,0,0,100,0),
(@PATH,12,-242.58171,3041.7646,-4.300512,0,0,0,0,100,0),
(@PATH,13,-230.12532,3038.0112,-4.321488,0,0,0,0,100,0),
(@PATH,14,-242.58171,3041.7646,-4.300512,0,0,0,0,100,0),
(@PATH,15,-269.63672,3050.605,-4.484898,0,0,0,0,100,0),
(@PATH,16,-282.3609,3047.8403,-4.3587236,0,0,0,0,100,0),
(@PATH,17,-279.97885,3038.2961,-4.9714665,0,0,0,0,100,0),
(@PATH,18,-289.71497,3032.069,-8.278463,0,0,0,0,100,0),
(@PATH,19,-318.31235,3033.3577,-15.979837,0,0,0,0,100,0),
(@PATH,20,-323.32254,3038.5364,-16.43634,0,0,0,0,100,0),
(@PATH,21,-331.88126,3040.104,-16.655672,0,0,0,0,100,0),
(@PATH,22,-369.7765,3031.6306,-16.328512,0,0,0,0,100,0),
(@PATH,23,-384.4923,3027.4856,-16.353851,0,0,0,0,100,0),
(@PATH,24,-406.3353,3022.2678,-16.148197,0,0,0,0,100,0);

-- Pathing for Wrathguard Entry: 18975
SET @NPC := 68154;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=199.47882,`position_y`=1776.2356,`position_z`=28.954777 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,199.47882,1776.2356,28.954777,0,0,0,0,100,0),
(@PATH,2,166.00388,1777.2031,29.389055,0,0,0,0,100,0),
(@PATH,3,132.9256,1784.8197,34.336433,0,0,0,0,100,0),
(@PATH,4,100.18389,1786.1387,43.37623,0,0,0,0,100,0),
(@PATH,5,66.35449,1788.0028,47.293976,0,0,0,0,100,0),
(@PATH,6,100.18389,1786.1387,43.37623,0,0,0,0,100,0),
(@PATH,7,132.9256,1784.8197,34.336433,0,0,0,0,100,0),
(@PATH,8,166.00388,1777.2031,29.389055,0,0,0,0,100,0);

-- Pathing for Wrathguard Entry: 18975
SET @NPC := 68157;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=18.84923,`position_y`=1900.276,`position_z`=57.985737 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,18.84923,1900.276,57.985737,0,0,0,0,100,0),
(@PATH,2,21.599827,1851.4813,55.474453,0,0,0,0,100,0),
(@PATH,3,43.01769,1815.0681,50.769978,0,0,0,0,100,0),
(@PATH,4,70.83545,1784.6724,47.515182,0,0,0,0,100,0),
(@PATH,5,43.01769,1815.0681,50.769978,0,0,0,0,100,0),
(@PATH,6,21.599827,1851.4813,55.474453,0,0,0,0,100,0);

-- Pathing for Wrathguard Entry: 18975
SET @NPC := 68161;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=29.397896,`position_y`=1911.3108,`position_z`=63.881123 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,29.397896,1911.3108,63.881123,0,0,0,0,100,0),
(@PATH,2,-0.840169,1917.0441,63.7397,0,0,0,0,100,0),
(@PATH,3,-34.653973,1918.2496,67.54456,0,0,0,0,100,0),
(@PATH,4,-67.30029,1914.8502,72.19828,0,0,0,0,100,0),
(@PATH,5,-101.69667,1914.25,78.29522,0,0,0,0,100,0),
(@PATH,6,-134.64258,1914.8025,82.21902,0,0,0,0,100,0),
(@PATH,7,-166.33307,1902.8188,90.71694,0,0,0,0,100,0),
(@PATH,8,-134.64258,1914.8025,82.21902,0,0,0,0,100,0),
(@PATH,9,-101.69667,1914.25,78.29522,0,0,0,0,100,0),
(@PATH,10,-67.30029,1914.8502,72.19828,0,0,0,0,100,0),
(@PATH,11,-34.653973,1918.2496,67.54456,0,0,0,0,100,0),
(@PATH,12,-0.840169,1917.0441,63.7397,0,0,0,0,100,0);

-- Pathing for Wrathguard Entry: 18975
SET @NPC := 68162;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-1.181803,`position_y`=1915.2938,`position_z`=62.612503 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1.181803,1915.2938,62.612503,0,0,0,0,100,0),
(@PATH,2,-34.283096,1926.1013,69.50684,0,0,0,0,100,0),
(@PATH,3,-67.38694,1935.8473,75.6259,0,0,0,0,100,0),
(@PATH,4,-100.55697,1945.6774,80.93402,0,0,0,0,100,0),
(@PATH,5,-133.14117,1945.1892,84.09149,0,0,0,0,100,0),
(@PATH,6,-100.55697,1945.6774,80.93402,0,0,0,0,100,0),
(@PATH,7,-67.38694,1935.8473,75.6259,0,0,0,0,100,0),
(@PATH,8,-34.283096,1926.1013,69.50684,0,0,0,0,100,0);

-- Pathing for Wrathguard Entry: 18975
SET @NPC := 68176;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-499.8939,`position_y`=1853.1816,`position_z`=72.6393 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-499.8939,1853.1816,72.6393,0,0,0,0,100,0),
(@PATH,2,-533.82794,1849.1228,68.49065,0,0,0,0,100,0),
(@PATH,3,-573.05005,1833.3685,70.09721,0,0,0,0,100,0),
(@PATH,4,-582.4371,1799.727,68.27963,0,0,0,0,100,0),
(@PATH,5,-599.6403,1775.8641,70.31271,0,0,0,0,100,0),
(@PATH,6,-582.4371,1799.727,68.27963,0,0,0,0,100,0),
(@PATH,7,-573.05005,1833.3685,70.09721,0,0,0,0,100,0),
(@PATH,8,-533.82794,1849.1228,68.49065,0,0,0,0,100,0);

-- Pathing for Wrathguard Entry: 18975
SET @NPC := 68177;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-580.01984,`position_y`=1819.008,`position_z`=69.8571 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-580.01984,1819.008,69.8571,0,0,0,0,100,0),
(@PATH,2,-539.0947,1844.5924,68.747604,0,0,0,0,100,0),
(@PATH,3,-497.37955,1869.0419,78.03767,0,0,0,0,100,0),
(@PATH,4,-457.23285,1876.6077,83.269966,0,0,0,0,100,0),
(@PATH,5,-412.63782,1886.7565,96.04051,0,0,0,0,100,0),
(@PATH,6,-382.01715,1886.2919,102.95996,0,0,0,0,100,0),
(@PATH,7,-348.26178,1887.623,113.055435,0,0,0,0,100,0),
(@PATH,8,-382.01715,1886.2919,102.95996,0,0,0,0,100,0),
(@PATH,9,-412.63782,1886.7565,96.04051,0,0,0,0,100,0),
(@PATH,10,-457.23285,1876.6077,83.269966,0,0,0,0,100,0),
(@PATH,11,-497.37955,1869.0419,78.03767,0,0,0,0,100,0),
(@PATH,12,-539.0947,1844.5924,68.747604,0,0,0,0,100,0);

-- Pathing for Wrathguard Entry: 18975
SET @NPC := 68184;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-500.1953,`position_y`=1822.9857,`position_z`=63.424183 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-500.1953,1822.9857,63.424183,0,0,0,0,100,0),
(@PATH,2,-466.83344,1820.2477,61.12444,0,0,0,0,100,0),
(@PATH,3,-433.4209,1814.834,68.06526,0,0,0,0,100,0),
(@PATH,4,-400.62173,1819.8728,73.272644,0,0,0,0,100,0),
(@PATH,5,-366.69412,1817.8268,76.597244,0,0,0,0,100,0),
(@PATH,6,-342.91684,1847.1057,89.360466,0,0,0,0,100,0),
(@PATH,7,-321.9264,1843.7704,89.96937,0,0,0,0,100,0),
(@PATH,8,-342.91684,1847.1057,89.360466,0,0,0,0,100,0),
(@PATH,9,-366.69412,1817.8268,76.597244,0,0,0,0,100,0),
(@PATH,10,-400.62173,1819.8728,73.272644,0,0,0,0,100,0),
(@PATH,11,-433.4209,1814.834,68.06526,0,0,0,0,100,0),
(@PATH,12,-466.83344,1820.2477,61.12444,0,0,0,0,100,0);

-- Pathing for Wrathguard Entry: 18975
SET @NPC := 68164;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-133.83751,`position_y`=1956.5762,`position_z`=89.81796 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-133.83751,1956.5762,89.81796,0,0,0,0,100,0),
(@PATH,2,-153.56418,1934.0231,85.20651,0,0,0,0,100,0),
(@PATH,3,-167.2844,1902.9731,91.05674,0,0,0,0,100,0),
(@PATH,4,-200.12918,1900.8837,95.283424,0,0,0,0,100,0),
(@PATH,5,-245.59517,1900.106,96.52262,0,0,0,0,100,0),
(@PATH,6,-250.93196,1858.3867,95.78839,0,0,0,0,100,0),
(@PATH,7,-282.15952,1845.359,92.331116,0,0,0,0,100,0),
(@PATH,8,-322.88303,1837.8336,87.534065,0,0,0,0,100,0),
(@PATH,9,-282.15952,1845.359,92.331116,0,0,0,0,100,0),
(@PATH,10,-250.93196,1858.3867,95.78839,0,0,0,0,100,0),
(@PATH,11,-245.59517,1900.106,96.52262,0,0,0,0,100,0),
(@PATH,12,-200.12918,1900.8837,95.283424,0,0,0,0,100,0),
(@PATH,13,-167.2844,1902.9731,91.05674,0,0,0,0,100,0),
(@PATH,14,-153.56418,1934.0231,85.20651,0,0,0,0,100,0);

-- Pathing for Wrathguard Entry: 18975
SET @NPC := 68181;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-592.561,`position_y`=1833.3932,`position_z`=72.922165 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-592.561,1833.3932,72.922165,0,0,0,0,100,0),
(@PATH,2,-567.2493,1855.1188,74.70073,0,0,0,0,100,0),
(@PATH,3,-534.5244,1884.1324,79.65556,0,0,0,0,100,0),
(@PATH,4,-494.36307,1906.9249,90.01911,0,0,0,0,100,0),
(@PATH,5,-534.5244,1884.1324,79.65556,0,0,0,0,100,0),
(@PATH,6,-567.2493,1855.1188,74.70073,0,0,0,0,100,0);

-- Pathing for Mo'arg Forgefiend Entry: 16946
SET @NPC := 58977;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=464.7622,`position_y`=2488.8564,`position_z`=156.6905 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,464.7622,2488.8564,156.6905,0,0,0,0,100,0),
(@PATH,2,435.61328,2460.0283,143.49786,0,0,0,0,100,0),
(@PATH,3,400.83566,2454.159,145.87096,0,0,0,0,100,0),
(@PATH,4,377.1379,2448.386,152.2784,0,0,0,0,100,0),
(@PATH,5,364.94016,2466.368,155.61246,0,0,0,0,100,0),
(@PATH,6,340.49475,2467.4893,161.90724,0,0,0,0,100,0),
(@PATH,7,344.97696,2491.313,161.01381,0,0,0,0,100,0),
(@PATH,8,342.02798,2510.2747,161.78798,0,0,0,0,100,0),
(@PATH,9,339.76016,2528.9788,162.16298,0,0,0,0,100,0),
(@PATH,10,370.8831,2546.8894,152.60211,0,0,0,0,100,0),
(@PATH,11,404.55768,2534.0322,148.89934,0,0,0,0,100,0),
(@PATH,12,434.78946,2532.6057,153.8877,0,0,0,0,100,0),
(@PATH,13,462.0394,2528.9888,161.53479,0,0,0,0,100,0),
(@PATH,14,464.53262,2500.708,158.13013,0,0,0,0,100,0),
(@PATH,15,462.0394,2528.9888,161.53479,0,0,0,0,100,0),
(@PATH,16,434.78946,2532.6057,153.8877,0,0,0,0,100,0),
(@PATH,17,404.55768,2534.0322,148.89934,0,0,0,0,100,0),
(@PATH,18,370.94922,2546.8643,152.48907,0,0,0,0,100,0),
(@PATH,19,339.76016,2528.9788,162.16298,0,0,0,0,100,0),
(@PATH,20,342.02798,2510.2747,161.78798,0,0,0,0,100,0),
(@PATH,21,344.97696,2491.313,161.01381,0,0,0,0,100,0),
(@PATH,22,340.49475,2467.4893,161.90724,0,0,0,0,100,0),
(@PATH,23,364.94016,2466.368,155.61246,0,0,0,0,100,0),
(@PATH,24,377.1379,2448.386,152.2784,0,0,0,0,100,0),
(@PATH,25,400.83566,2454.159,145.87096,0,0,0,0,100,0),
(@PATH,26,435.50235,2459.9575,143.46759,0,0,0,0,100,0);

-- Pathing for Mo'arg Forgefiend Entry: 16946
SET @NPC := 58978;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=367.56558,`position_y`=2531.288,`position_z`=153.44394 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,367.56558,2531.288,153.44394,0,0,0,0,100,0),
(@PATH,2,398.63586,2527.3586,149.28818,0,0,0,0,100,0),
(@PATH,3,395.47836,2500.9463,149.16159,0,0,0,0,100,0),
(@PATH,4,387.30225,2499.5247,150.45584,0,0,0,0,100,0),
(@PATH,5,399.48227,2519.981,149.89096,0,0,0,0,100,0),
(@PATH,6,406.9428,2533.1711,148.97871,0,0,0,0,100,0),
(@PATH,7,448.06702,2525.6692,156.69727,0,0,0,0,100,0),
(@PATH,8,456.0293,2499.8818,155.58858,0,0,0,0,100,0),
(@PATH,9,434.04407,2479.9814,147.43208,0,0,0,0,100,0),
(@PATH,10,399.73917,2485.5525,148.12552,0,0,0,0,100,0),
(@PATH,11,381.84268,2486.9626,151.55875,0,0,0,0,100,0),
(@PATH,12,367.82584,2472.4219,154.54947,0,0,0,0,100,0),
(@PATH,13,356.6569,2483.301,157.84315,0,0,0,0,100,0),
(@PATH,14,351.37045,2500.8545,158.66298,0,0,0,0,100,0),
(@PATH,15,357.88644,2513.2974,157.32106,0,0,0,0,100,0);

-- Pathing for Mo'arg Forgefiend Entry: 16946
SET @NPC := 58979;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=512.1336,`position_y`=2781.9998,`position_z`=210.70447 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,512.1336,2781.9998,210.70447,0,0,0,0,100,0),
(@PATH,2,533.5712,2764.4314,214.23453,0,0,0,0,100,0),
(@PATH,3,563.8275,2764.2769,220.99161,0,0,0,0,100,0),
(@PATH,4,596.60077,2779.521,224.63826,0,0,0,0,100,0),
(@PATH,5,600.44446,2798.629,222.42854,0,0,0,0,100,0),
(@PATH,6,599.44824,2811.425,219.6513,0,0,0,0,100,0),
(@PATH,7,588.9837,2829.2493,219.6789,0,0,0,0,100,0),
(@PATH,8,561.5564,2834.301,216.89613,0,0,0,0,100,0),
(@PATH,9,536.1294,2829.6191,214.0218,0,0,0,0,100,0),
(@PATH,10,512.00793,2818.8887,210.72125,0,0,0,0,100,0),
(@PATH,11,500.9739,2804.0317,208.25275,0,0,0,0,100,0);

-- Pathing for Mag'har Hunter Entry: 16912
SET @NPC := 58673;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=299.40247,`position_y`=3817.2166,`position_z`=165.12822 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,207,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,299.40247,3817.2166,165.12822,0,0,0,0,100,0),
(@PATH,2,266.58447,3800.4814,176.58769,0,0,0,0,100,0),
(@PATH,3,266.91553,3767.5496,184.13387,0,0,0,0,100,0),
(@PATH,4,266.64514,3737.4983,179.37576,0,0,0,0,100,0),
(@PATH,5,300.77072,3709.9849,179.40353,0,0,0,0,100,0),
(@PATH,6,333.15738,3695.2197,179.40353,0,0,0,0,100,0),
(@PATH,7,367.02072,3694.7036,179.40353,0,0,0,0,100,0),
(@PATH,8,400.3877,3713.132,179.40353,0,0,0,0,100,0),
(@PATH,9,433.6806,3733.8977,182.26677,0,0,0,0,100,0),
(@PATH,10,466.6365,3733.7136,185.96526,0,0,0,0,100,0),
(@PATH,11,500.03165,3737.6138,184.72603,0,0,0,0,100,0),
(@PATH,12,533.35803,3734.5266,186.08772,0,0,0,0,100,0),
(@PATH,13,565.54816,3739.3906,197.14705,0,0,0,0,100,0),
(@PATH,14,533.35803,3734.5266,186.08772,0,0,0,0,100,0),
(@PATH,15,500.03165,3737.6138,184.72603,0,0,0,0,100,0),
(@PATH,16,466.6365,3733.7136,185.96526,0,0,0,0,100,0),
(@PATH,17,433.6806,3733.8977,182.26677,0,0,0,0,100,0),
(@PATH,18,400.3877,3713.132,179.40353,0,0,0,0,100,0),
(@PATH,19,367.02072,3694.7036,179.40353,0,0,0,0,100,0),
(@PATH,20,333.15738,3695.2197,179.40353,0,0,0,0,100,0),
(@PATH,21,300.77072,3709.9849,179.40353,0,0,0,0,100,0),
(@PATH,22,266.64514,3737.4983,179.37576,0,0,0,0,100,0),
(@PATH,23,266.91553,3767.5496,184.13387,0,0,0,0,100,0),
(@PATH,24,266.58447,3800.4814,176.58769,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_19_00' WHERE sql_rev = '1645226316218841996';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

-- DB update 2022_01_03_06 -> 2022_01_03_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_03_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_03_06 2022_01_03_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640810407986738722'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640810407986738722');

-- Lordamere Internment Camp, Alterac Mountains.

-- Pathing for Dalaran Shield Guard Entry: 2271
SET @NPC := 17100;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-32.355145,`position_y`=208.55615,`position_z`=51.054737 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-32.355145,208.55615,51.054737,0,0,0,0,100,0),
(@PATH,2,-38.276585,193.03975,50.697132,0,0,0,0,100,0),
(@PATH,3,-55.892307,179.72311,53.4359,0,0,0,0,100,0),
(@PATH,4,-73.063805,169.88026,55.730824,0,0,0,0,100,0),
(@PATH,5,-95.5618,165.89182,55.68179,0,0,0,0,100,0),
(@PATH,6,-107.29145,165.8908,55.90705,0,0,0,0,100,0),
(@PATH,7,-120.07357,168.47345,57.092762,0,0,0,0,100,0),
(@PATH,8,-137.58176,182.38333,59.77922,0,0,0,0,100,0),
(@PATH,9,-154.17986,195.82135,66.6989,0,0,0,0,100,0),
(@PATH,10,-165.67578,209.67383,75.102196,0,0,0,0,100,0),
(@PATH,11,-154.17969,195.82227,66.75969,0,0,0,0,100,0),
(@PATH,12,-137.58176,182.38333,59.77922,0,0,0,0,100,0),
(@PATH,13,-120.07357,168.47345,57.092762,0,0,0,0,100,0),
(@PATH,14,-107.29145,165.8908,55.90705,0,0,0,0,100,0),
(@PATH,15,-95.5618,165.89182,55.68179,0,0,0,0,100,0),
(@PATH,16,-73.063805,169.88026,55.730824,0,0,0,0,100,0),
(@PATH,17,-55.892307,179.72311,53.4359,0,0,0,0,100,0),
(@PATH,18,-38.36133,193,50.66637,0,0,0,0,100,0);

-- Pathing for Dalaran Shield Guard Entry: 2271
SET @NPC := 17349;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-108.96669,`position_y`=257.86514,`position_z`=54.283314 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-108.96669,257.86514,54.283314,0,0,0,0,100,0),
(@PATH,2,-88.62929,242.37663,53.4005,0,0,0,0,100,0),
(@PATH,3,-75.92909,239.36743,53.4005,0,0,0,0,100,0),
(@PATH,4,-77.69108,232.12717,53.4005,0,0,0,0,100,0),
(@PATH,5,-75.92909,239.36743,53.4005,0,0,0,0,100,0),
(@PATH,6,-88.62929,242.37663,53.4005,0,0,0,0,100,0);

-- Pathing for Dalaran Shield Guard Entry: 2271
SET @NPC := 17351;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-31.500923,`position_y`=278.97083,`position_z`=51.421616 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-31.500923,278.97083,51.421616,0,0,0,0,100,0),
(@PATH,2,-27.046604,262.70944,50.024612,0,0,0,0,100,0),
(@PATH,3,-39.53228,249.88643,52.695988,0,0,0,0,100,0),
(@PATH,4,-57.560005,246.28258,53.333195,0,0,0,0,100,0),
(@PATH,5,-79.26709,254.46906,53.4005,0,0,0,0,100,0),
(@PATH,6,-94.71495,268.95483,53.4005,0,0,0,0,100,0),
(@PATH,7,-88.63612,287.2965,53.4005,0,0,0,0,100,0),
(@PATH,8,-72.70492,305.8437,53.4005,0,0,0,0,100,0),
(@PATH,9,-54.308105,302.8976,53.93578,0,0,0,0,100,0),
(@PATH,10,-38.630753,292.62357,53.384155,0,0,0,0,100,0);

-- Pathing for Dalaran Shield Guard Entry: 2271
SET @NPC := 17296;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-55.76226,`position_y`=330.72452,`position_z`=57.279408 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-55.76226,330.72452,57.279408,0,0,0,0,100,0),
(@PATH,2,-31.236816,321.35553,55.616596,0,0,0,0,100,0),
(@PATH,3,-12.078342,297.37747,48.737656,0,0,0,0,100,0),
(@PATH,4,-8.439128,276.88614,46.27928,0,0,0,0,100,0),
(@PATH,5,-11.101454,259.6914,47.303177,0,0,0,0,100,0),
(@PATH,6,-16.930664,241.2523,47.471878,0,0,0,0,100,0),
(@PATH,7,-22.342936,229.616,49.67693,0,0,0,0,100,0),
(@PATH,8,-35.915203,210.17006,51.585636,0,0,0,0,100,0),
(@PATH,9,-22.342936,229.616,49.67693,0,0,0,0,100,0),
(@PATH,10,-16.930664,241.2523,47.471878,0,0,0,0,100,0),
(@PATH,11,-11.101454,259.6914,47.303177,0,0,0,0,100,0),
(@PATH,12,-8.439128,276.88614,46.27928,0,0,0,0,100,0),
(@PATH,13,-12.078342,297.37747,48.737656,0,0,0,0,100,0),
(@PATH,14,-31.236816,321.35553,55.616596,0,0,0,0,100,0);

-- Pathing for Dalaran Shield Guard Entry: 2271
SET @NPC := 17104;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-164.33789,`position_y`=229.98828,`position_z`=78.852196 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-164.33789,229.98828,78.852196,0,0,0,0,100,0),
(@PATH,2,-164.6652,243.98799,82.06407,0,0,0,0,100,0),
(@PATH,3,-156.50792,258.5564,82.20836,0,0,0,0,100,0),
(@PATH,4,-142.0262,267.90353,81.649635,0,0,0,0,100,0),
(@PATH,5,-131.44943,268.33005,79.61506,0,0,0,0,100,0),
(@PATH,6,-123.06852,273.3409,78.35676,0,0,0,0,100,0),
(@PATH,7,-117.13862,284.13507,79.228584,0,0,0,0,100,0),
(@PATH,8,-118.26373,304.2776,80.007774,0,0,0,0,100,0),
(@PATH,9,-118.92475,325.15933,76.85323,0,0,0,0,100,0),
(@PATH,10,-118.26373,304.2776,80.007774,0,0,0,0,100,0),
(@PATH,11,-117.13862,284.13507,79.228584,0,0,0,0,100,0),
(@PATH,12,-123.06852,273.3409,78.35676,0,0,0,0,100,0),
(@PATH,13,-131.44943,268.33005,79.61506,0,0,0,0,100,0),
(@PATH,14,-142.0262,267.90353,81.649635,0,0,0,0,100,0),
(@PATH,15,-156.50792,258.5564,82.20836,0,0,0,0,100,0),
(@PATH,16,-164.6652,243.98799,82.06407,0,0,0,0,100,0);

-- Pathing for Dalaran Theurgist Entry: 2272
SET @NPC := 17113;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-94.942604,`position_y`=200.3881,`position_z`=53.4005 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-94.942604,200.3881,53.4005,0,0,0,0,100,0),
(@PATH,2,-105.71739,199.64977,53.4005,0,0,0,0,100,0),
(@PATH,3,-118.01329,206.39719,53.4005,0,0,0,0,100,0),
(@PATH,4,-127.29389,206.22157,53.5255,0,0,0,0,100,0),
(@PATH,5,-131.83263,205.91634,53.6505,0,0,0,0,100,0),
(@PATH,6,-131.57205,210.97987,53.5255,0,0,0,0,100,0),
(@PATH,7,-139.15251,221.10225,53.487938,0,0,0,0,100,0),
(@PATH,8,-131.57205,210.97987,53.5255,0,0,0,0,100,0),
(@PATH,9,-131.83263,205.91634,53.6505,0,0,0,0,100,0),
(@PATH,10,-127.29389,206.22157,53.5255,0,0,0,0,100,0),
(@PATH,11,-118.01329,206.39719,53.4005,0,0,0,0,100,0),
(@PATH,12,-105.71739,199.64977,53.4005,0,0,0,0,100,0);

-- Pathing for Dalaran Theurgist Entry: 2272
SET @NPC := 17347;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-54.00586,`position_y`=243.52327,`position_z`=53.333195 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-54.00586,243.52327,53.333195,0,0,0,0,100,0),
(@PATH,2,-78.11936,252.80273,53.4005,0,0,0,0,100,0),
(@PATH,3,-96.24246,262.62613,53.4005,0,0,0,0,100,0),
(@PATH,4,-94.327965,279.87003,53.4005,0,0,0,0,100,0),
(@PATH,5,-88.60927,297.4607,53.4005,0,0,0,0,100,0),
(@PATH,6,-77.20654,306.1083,53.4005,0,0,0,0,100,0),
(@PATH,7,-52.8221,302.43402,53.99938,0,0,0,0,100,0),
(@PATH,8,-32.198784,280.3938,51.7556,0,0,0,0,100,0),
(@PATH,9,-27.629557,263.85104,50.16426,0,0,0,0,100,0),
(@PATH,10,-36.70622,250.68628,52.267765,0,0,0,0,100,0);

-- Pathing for Dalaran Shield Guard Entry: 2271
SET @NPC := 17288;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-85.084206,`position_y`=187.97604,`position_z`=53.4005 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-85.084206,187.97604,53.4005,0,0,0,0,100,0),
(@PATH,2,-79.01248,197.44395,53.4005,0,0,0,0,100,0),
(@PATH,3,-73.34153,198.22838,53.4005,0,0,0,0,100,0),
(@PATH,4,-76.0899,207.64236,53.4005,0,0,0,0,100,0),
(@PATH,5,-71.50054,214.64662,53.4005,0,0,0,0,100,0),
(@PATH,6,-64.79574,220.7848,53.3028,0,0,0,0,100,0),
(@PATH,7,-63.47228,225.30081,53.3028,0,0,0,0,100,0),
(@PATH,8,-71.50054,214.64662,53.4005,0,0,0,0,100,0),
(@PATH,9,-76.0899,207.64236,53.4005,0,0,0,0,100,0),
(@PATH,10,-73.34153,198.22838,53.4005,0,0,0,0,100,0),
(@PATH,11,-79.01248,197.44395,53.4005,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_03_07' WHERE sql_rev = '1640810407986738722';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

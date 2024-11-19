-- DB update 2021_12_19_04 -> 2021_12_19_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_19_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_19_04 2021_12_19_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639785806037594546'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639785806037594546');

-- Underlight Mines

-- Add missing pickaxe equipment for the mining npcs
DELETE FROM `creature_equip_template` WHERE `CreatureID` IN (16334,16335) AND `ID`=2;
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`,`VerifiedBuild`) VALUES
(16334,2,2901,0,0,0),(16335,2,2901,0,0,0);

-- Update mining npcs to use pickaxes
UPDATE `creature` SET `equipment_id`=2 WHERE `guid` IN (82601,82598,82594,82593,82596,82595,82591,82584,82586,82583,82587,82576);

-- Remove emote from all Blackpaw Gnolls and Scavengers
UPDATE `creature_template_addon` SET `emote`=0 WHERE `entry` IN (16334,16335);

-- Add emote for mining Blackpaw Gnolls and Scavengers
DELETE FROM `creature_addon` WHERE `guid` IN (82601,82598,82594,82593,82596,82595,82591,82584,82586,82583,82587,82576);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES 
(82601,0,0,0,1,233,0, ''),(82598,0,0,0,1,233,0, ''),(82594,0,0,0,1,233,0, ''),(82593,0,0,0,1,233,0, ''),(82596,0,0,0,1,233,0, ''),
(82595,0,0,0,1,233,0, ''),(82591,0,0,0,1,233,0, ''),(82584,0,0,0,1,233,0, ''),(82586,0,0,0,1,233,0, ''),(82583,0,0,0,1,233,0, ''),
(82587,0,0,0,1,233,0, ''),(82576,0,0,0,1,233,0, '');

-- Pathing for Blackpaw Shaman Entry: 16337
SET @NPC := 82605;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=7062.772,`position_y`=-6229.693,`position_z`=22.586903 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7062.772,-6229.693,22.586903,0,0,0,0,100,0),
(@PATH,2,7072.1196,-6223.7114,23.786423,0,0,0,0,100,0),
(@PATH,3,7076.0054,-6215.559,23.291483,0,0,0,0,100,0),
(@PATH,4,7077.0728,-6207.834,22.160383,0,0,0,0,100,0),
(@PATH,5,7071.6914,-6201.8047,23.119867,0,0,0,0,100,0),
(@PATH,6,7071.983,-6188.415,20.750038,0,0,0,0,100,0),
(@PATH,7,7071.6235,-6202.0938,23.143425,0,0,0,0,100,0),
(@PATH,8,7081.1694,-6206.3823,21.908098,0,0,0,0,100,0),
(@PATH,9,7093.895,-6205.9854,21.908957,0,0,0,0,100,0),
(@PATH,10,7105.1265,-6212.3643,22.043737,0,0,0,0,100,0),
(@PATH,11,7111.915,-6228.706,20.697754,0,0,0,0,100,0),
(@PATH,12,7137.2417,-6219.641,22.989492,0,0,0,0,100,0),
(@PATH,13,7148.6885,-6215.7144,22.983673,0,0,0,0,100,0),
(@PATH,14,7137.2417,-6219.641,22.989492,0,0,0,0,100,0),
(@PATH,15,7111.915,-6228.706,20.697754,0,0,0,0,100,0),
(@PATH,16,7105.1426,-6212.3735,22.050264,0,0,0,0,100,0),
(@PATH,17,7093.895,-6205.9854,21.908957,0,0,0,0,100,0),
(@PATH,18,7081.1694,-6206.3823,21.908098,0,0,0,0,100,0),
(@PATH,19,7071.6235,-6202.0938,23.143425,0,0,0,0,100,0),
(@PATH,20,7071.983,-6188.415,20.750038,0,0,0,0,100,0),
(@PATH,21,7071.6914,-6201.8047,23.119867,0,0,0,0,100,0),
(@PATH,22,7077.0728,-6207.834,22.160383,0,0,0,0,100,0),
(@PATH,23,7076.0054,-6215.559,23.291483,0,0,0,0,100,0),
(@PATH,24,7072.1196,-6223.7114,23.786423,0,0,0,0,100,0);

-- Pathing for Blackpaw Shaman Entry: 16337
SET @NPC := 82582;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=7015.5405,`position_y`=-6240.3853,`position_z`=4.995731 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7015.5405,-6240.3853,4.995731,0,0,0,0,100,0),
(@PATH,2,7006.427,-6247.241,6.075204,0,0,0,0,100,0),
(@PATH,3,7003.605,-6255.737,5.629813,0,0,0,0,100,0),
(@PATH,4,7000.46,-6265.9766,6.8266463,0,0,0,0,100,0),
(@PATH,5,7008.461,-6272.834,5.1952734,0,0,0,0,100,0),
(@PATH,6,7017.209,-6275.1895,6.9610434,0,0,0,0,100,0),
(@PATH,7,7027.53,-6277.966,8.607683,0,0,0,0,100,0),
(@PATH,8,7040.23,-6279.4634,9.062558,0,0,0,0,100,0),
(@PATH,9,7058.8823,-6274.784,13.937899,0,0,0,0,100,0),
(@PATH,10,7073.38,-6265.707,16.486921,0,0,0,0,100,0),
(@PATH,11,7075.0337,-6255.051,17.369122,0,0,0,0,100,0),
(@PATH,12,7070.5376,-6242.628,20.185184,0,0,0,0,100,0),
(@PATH,13,7065.898,-6230.5483,22.730297,0,0,0,0,100,0),
(@PATH,14,7070.5176,-6242.576,20.206448,0,0,0,0,100,0),
(@PATH,15,7075.0337,-6255.051,17.369122,0,0,0,0,100,0),
(@PATH,16,7073.38,-6265.707,16.486921,0,0,0,0,100,0),
(@PATH,17,7058.8823,-6274.784,13.937899,0,0,0,0,100,0),
(@PATH,18,7040.23,-6279.4634,9.062558,0,0,0,0,100,0),
(@PATH,19,7027.53,-6277.966,8.607683,0,0,0,0,100,0),
(@PATH,20,7017.209,-6275.1895,6.9610434,0,0,0,0,100,0),
(@PATH,21,7008.461,-6272.834,5.1952734,0,0,0,0,100,0),
(@PATH,22,7000.46,-6265.9766,6.8266463,0,0,0,0,100,0),
(@PATH,23,7003.605,-6255.737,5.629813,0,0,0,0,100,0),
(@PATH,24,7006.427,-6247.241,6.075204,0,0,0,0,100,0);

-- Pathing for Blackpaw Shaman Entry: 16337
SET @NPC := 82632;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=7174.768,`position_y`=-6253.7837,`position_z`=20.301943 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7174.768,-6253.7837,20.301943,0,0,0,0,100,0),
(@PATH,2,7176.9907,-6222.223,18.881855,0,0,0,0,100,0),
(@PATH,3,7182.5337,-6194.3804,20.085768,0,0,0,0,100,0),
(@PATH,4,7188.647,-6152.618,16.02846,0,0,0,0,100,0),
(@PATH,5,7208.869,-6170.7715,18.681154,0,0,0,0,100,0),
(@PATH,6,7217.7285,-6211.787,20.43858,0,0,0,0,100,0),
(@PATH,7,7231.867,-6231.401,21.402447,0,0,0,0,100,0),
(@PATH,8,7246.706,-6241.632,20.523369,0,0,0,0,100,0),
(@PATH,9,7265.992,-6239.153,20.692924,0,0,0,0,100,0),
(@PATH,10,7270.2773,-6250.8735,19.707134,0,0,0,0,100,0),
(@PATH,11,7249.682,-6278.63,20.356133,0,0,0,0,100,0),
(@PATH,12,7227.8735,-6291.4194,21.60026,0,0,0,0,100,0),
(@PATH,13,7199.47,-6295.778,22.861763,0,0,0,0,100,0),
(@PATH,14,7181.401,-6281.5767,21.252876,0,0,0,0,100,0);

-- Pathing for Blackpaw Shaman Entry: 16337
SET @NPC := 82629;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=7206.099,`position_y`=-6260.198,`position_z`=19.865225 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7206.099,-6260.198,19.865225,0,0,0,0,100,0),
(@PATH,2,7202.176,-6249.9014,20.181387,0,0,0,0,100,0),
(@PATH,3,7205.274,-6247.2515,19.894278,0,10000,0,0,100,0),
(@PATH,4,7193.7075,-6231.7983,19.137836,0,0,0,0,100,0),
(@PATH,5,7178.007,-6232.294,18.671772,0,0,0,0,100,0),
(@PATH,6,7171.1816,-6223.721,18.976093,0,0,0,0,100,0),
(@PATH,7,7163.4395,-6204.9453,20.295692,0,0,0,0,100,0),
(@PATH,8,7155.929,-6193.152,21.279963,0,0,0,0,100,0),
(@PATH,9,7148.0127,-6188.8774,21.607721,0,10000,0,0,100,0),
(@PATH,10,7168.5713,-6210.4497,18.914326,0,0,0,0,100,0),
(@PATH,11,7188.2573,-6212.594,18.506733,0,0,0,0,100,0),
(@PATH,12,7212.736,-6227.561,19.159649,0,0,0,0,100,0),
(@PATH,13,7244.22,-6239.3447,21.113823,0,0,0,0,100,0),
(@PATH,14,7255.945,-6262.5146,18.857841,0,0,0,0,100,0),
(@PATH,15,7252.325,-6289.195,19.99871,0,10000,0,0,100,0),
(@PATH,16,7256.8384,-6281.7227,19.855644,0,0,0,0,100,0),
(@PATH,17,7267.5264,-6279.764,19.5511,0,10000,0,0,100,0),
(@PATH,18,7252.879,-6263.5186,18.857841,0,0,0,0,100,0),
(@PATH,19,7226.827,-6258.0063,19.138662,0,0,0,0,100,0);

-- Pathing for Blackpaw Shaman Entry: 16337
SET @NPC := 82628;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=7233.241,`position_y`=-6233.217,`position_z`=20.966412 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7233.241,-6233.217,20.966412,0,0,0,0,100,0),
(@PATH,2,7228.212,-6209.174,20.31358,0,10000,0,0,100,0),
(@PATH,3,7229.354,-6220.3657,19.81358,0,0,0,0,100,0),
(@PATH,4,7199.55,-6237.72,20.050722,0,0,0,0,100,0),
(@PATH,5,7188.8813,-6232.1265,18.830463,0,0,0,0,100,0),
(@PATH,6,7169.0723,-6227.0366,19.95876,0,0,0,0,100,0),
(@PATH,7,7160.527,-6232.8345,22.145302,0,10000,0,0,100,0),
(@PATH,8,7174.0854,-6210.7456,18.205463,0,0,0,0,100,0),
(@PATH,9,7206.3296,-6204.702,17.68687,0,0,0,0,100,0),
(@PATH,10,7210.871,-6180.092,17.427492,0,0,0,0,100,0),
(@PATH,11,7211.994,-6141.432,14.527667,0,0,0,0,100,0),
(@PATH,12,7218.574,-6135.2017,16.512897,0,10000,0,0,100,0),
(@PATH,13,7210.7617,-6176.5874,18.003908,0,0,0,0,100,0),
(@PATH,14,7215.765,-6201.112,18.580181,0,0,0,0,100,0),
(@PATH,15,7223.6113,-6231.929,19.19041,0,0,0,0,100,0),
(@PATH,16,7249.5566,-6239.418,19.982841,0,0,0,0,100,0),
(@PATH,17,7249.893,-6233.6206,20.988823,0,10000,0,0,100,0);

-- Pathing for Blackpaw Shaman Entry: 16337
SET @NPC := 82606;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=7154.87,`position_y`=-6176.0073,`position_z`=20.392511 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7154.87,-6176.0073,20.392511,0,0,0,0,100,0),
(@PATH,2,7125.8594,-6165.1294,25.690186,0,0,0,0,100,0),
(@PATH,3,7114.416,-6191.459,36.087124,0,0,0,0,100,0),
(@PATH,4,7106.0923,-6212.848,43.067257,0,0,0,0,100,0),
(@PATH,5,7109.2456,-6256.087,47.521248,0,0,0,0,100,0),
(@PATH,6,7133.0103,-6269.15,49.097347,0,0,0,0,100,0),
(@PATH,7,7147.7827,-6288.0024,49.091217,0,0,0,0,100,0),
(@PATH,8,7166.6685,-6306.105,43.313866,0,0,0,0,100,0),
(@PATH,9,7193.2314,-6316.1934,34.55825,0,0,0,0,100,0),
(@PATH,10,7220.419,-6326.2754,36.288784,0,0,0,0,100,0),
(@PATH,11,7251.5317,-6330.9736,41.791443,0,0,0,0,100,0),
(@PATH,12,7283.9834,-6324.9805,47.502823,0,0,0,0,100,0),
(@PATH,13,7306.887,-6300.2627,52.11318,0,0,0,0,100,0),
(@PATH,14,7313.2407,-6280.996,51.934364,0,0,0,0,100,0),
(@PATH,15,7322.9653,-6253.698,50.193363,0,0,0,0,100,0),
(@PATH,16,7317.9443,-6216.206,37.87001,0,0,0,0,100,0),
(@PATH,17,7287.097,-6205.182,38.57908,0,0,0,0,100,0),
(@PATH,18,7261.4224,-6182.3,30.300783,0,0,0,0,100,0),
(@PATH,19,7245.549,-6156.0757,23.289946,0,0,0,0,100,0),
(@PATH,20,7215.6636,-6159.185,19.243366,0,0,0,0,100,0),
(@PATH,21,7185.2773,-6177.0537,18.387403,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_19_05' WHERE sql_rev = '1639785806037594546';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

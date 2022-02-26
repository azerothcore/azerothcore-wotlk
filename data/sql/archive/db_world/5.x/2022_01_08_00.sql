-- DB update 2022_01_07_04 -> 2022_01_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_07_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_07_04 2022_01_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641660333161433796'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641660333161433796');

-- Pathing for Timbermaw Woodbender Entry: 11553 "Incorrect"
SET @NPC := 39353;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=7262.698,`position_y`=-2180.8948,`position_z`=557.196 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7262.698,-2180.8948,557.196,0,0,0,0,100,0),
(@PATH,2,7274.4595,-2160.9036,557.14734,0,0,0,0,100,0),
(@PATH,3,7284.0923,-2149.5735,553.56024,0,0,0,0,100,0),
(@PATH,4,7300.049,-2151.2666,549.91626,0,0,0,0,100,0),
(@PATH,5,7312.691,-2157.7156,547.0074,0,0,0,0,100,0),
(@PATH,6,7316.772,-2171.5781,543.11725,0,0,0,0,100,0),
(@PATH,7,7319.2915,-2188.173,539.6659,0,0,0,0,100,0),
(@PATH,8,7327.252,-2194.8096,537.00745,0,0,0,0,100,0),
(@PATH,9,7347.722,-2200.0183,535.4332,0,0,0,0,100,0),
(@PATH,10,7366.664,-2205.3677,536.4962,0,0,0,0,100,0),
(@PATH,11,7381.741,-2204.7158,534.778,0,0,0,0,100,0),
(@PATH,12,7366.8125,-2205.4097,536.4895,0,0,0,0,100,0),
(@PATH,13,7347.722,-2200.0183,535.4332,0,0,0,0,100,0),
(@PATH,14,7327.252,-2194.8096,537.00745,0,0,0,0,100,0),
(@PATH,15,7319.2915,-2188.173,539.6659,0,0,0,0,100,0),
(@PATH,16,7316.772,-2171.5781,543.11725,0,0,0,0,100,0),
(@PATH,17,7312.691,-2157.7156,547.0074,0,0,0,0,100,0),
(@PATH,18,7300.049,-2151.2666,549.91626,0,0,0,0,100,0),
(@PATH,19,7284.0923,-2149.5735,553.56024,0,0,0,0,100,0),
(@PATH,20,7274.5044,-2160.8274,557.11523,0,0,0,0,100,0);

-- Pathing for Timbermaw Mystic Entry: 11552 "Incorrect changed entry also"
SET @NPC := 39360;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `id`=11552, `wander_distance`=0,`MovementType`=2,`position_x`=7024.654,`position_y`=-2120.0369,`position_z`=586.62036 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7024.654,-2120.0369,586.62036,0,0,0,0,100,0),
(@PATH,2,7047.0483,-2116.423,586.34766,0,0,0,0,100,0),
(@PATH,3,7064.598,-2116.144,585.7502,0,0,0,0,100,0),
(@PATH,4,7081.2227,-2115.8333,583.0045,0,0,0,0,100,0),
(@PATH,5,7095.828,-2121.545,579.1437,0,0,0,0,100,0),
(@PATH,6,7098.671,-2134.8757,575.7117,0,0,0,0,100,0),
(@PATH,7,7095.828,-2121.545,579.1437,0,0,0,0,100,0),
(@PATH,8,7081.2227,-2115.8333,583.0045,0,0,0,0,100,0),
(@PATH,9,7064.598,-2116.144,585.7502,0,0,0,0,100,0),
(@PATH,10,7047.0483,-2116.423,586.34766,0,0,0,0,100,0);

-- Pathing for Timbermaw Mystic Entry: 11552 "Incorrect changed entry also"
SET @NPC := 39721;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `id`=11552, `wander_distance`=0,`MovementType`=2,`position_x`=6828.4224,`position_y`=-2103.566,`position_z`=626.02405 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6828.4224,-2103.566,626.02405,0,0,0,0,100,0),
(@PATH,2,6861.4165,-2118.6768,624.6056,0,0,0,0,100,0),
(@PATH,3,6872.077,-2119.138,621.5977,0,0,0,0,100,0),
(@PATH,4,6889.064,-2104.1106,618.3598,0,0,0,0,100,0),
(@PATH,5,6904.9697,-2087.5867,616.86084,0,0,0,0,100,0),
(@PATH,6,6931.437,-2081.785,615.07227,0,0,0,0,100,0),
(@PATH,7,6949.078,-2077.9133,612.65717,0,0,0,0,100,0),
(@PATH,8,6973.9424,-2077.5493,609.558,0,0,0,0,100,0),
(@PATH,9,6992.606,-2068.7454,607.9045,0,0,0,0,100,0),
(@PATH,10,7003.5815,-2069.1577,608.60815,0,0,0,0,100,0),
(@PATH,11,7013.248,-2074.6565,605.43604,0,0,0,0,100,0),
(@PATH,12,7018.2583,-2092.1829,601.68787,0,0,0,0,100,0),
(@PATH,13,7020.4116,-2103.1484,601.8558,0,0,0,0,100,0),
(@PATH,14,7025.168,-2115.448,604.9562,0,0,0,0,100,0),
(@PATH,15,7020.4116,-2103.1484,601.8558,0,0,0,0,100,0),
(@PATH,16,7018.2583,-2092.1829,601.68787,0,0,0,0,100,0),
(@PATH,17,7013.248,-2074.6565,605.43604,0,0,0,0,100,0),
(@PATH,18,7003.5815,-2069.1577,608.60815,0,0,0,0,100,0),
(@PATH,19,6992.606,-2068.7454,607.9045,0,0,0,0,100,0),
(@PATH,20,6973.9424,-2077.5493,609.558,0,0,0,0,100,0),
(@PATH,21,6949.078,-2077.9133,612.65717,0,0,0,0,100,0),
(@PATH,22,6931.437,-2081.785,615.07227,0,0,0,0,100,0),
(@PATH,23,6904.9697,-2087.5867,616.86084,0,0,0,0,100,0),
(@PATH,24,6889.153,-2104.018,618.35596,0,0,0,0,100,0),
(@PATH,25,6872.077,-2119.138,621.5977,0,0,0,0,100,0),
(@PATH,26,6861.4165,-2118.6768,624.6056,0,0,0,0,100,0);

-- Pathing for Timbermaw Woodbender Entry: 11553 "Incorrect"
SET @NPC := 39354;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=7262.7397,`position_y`=-2183.3271,`position_z`=557.58405 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7262.7397,-2183.3271,557.58405,0,0,0,0,100,0),
(@PATH,2,7252.95,-2193.2385,561.02966,0,0,0,0,100,0),
(@PATH,3,7236.648,-2193.1848,564.55255,0,0,0,0,100,0),
(@PATH,4,7215.199,-2189.851,565.8182,0,0,0,0,100,0),
(@PATH,5,7198.736,-2188.6199,565.2573,0,0,0,0,100,0),
(@PATH,6,7183.26,-2183.0771,566.4539,0,0,0,0,100,0),
(@PATH,7,7165.0083,-2165.2192,565.9755,0,0,0,0,100,0),
(@PATH,8,7120.0884,-2156.9907,567.9588,0,0,0,0,100,0),
(@PATH,9,7104.307,-2151.73,571.6856,0,0,0,0,100,0),
(@PATH,10,7098.6963,-2136.9543,575.4121,0,0,0,0,100,0),
(@PATH,11,7104.307,-2151.73,571.6856,0,0,0,0,100,0),
(@PATH,12,7120.0884,-2156.9907,567.9588,0,0,0,0,100,0),
(@PATH,13,7142.976,-2161.157,566.864,0,0,0,0,100,0),
(@PATH,14,7165.0083,-2165.2192,565.9755,0,0,0,0,100,0),
(@PATH,15,7183.26,-2183.0771,566.4539,0,0,0,0,100,0),
(@PATH,16,7198.736,-2188.6199,565.2573,0,0,0,0,100,0),
(@PATH,17,7215.199,-2189.851,565.8182,0,0,0,0,100,0),
(@PATH,18,7236.648,-2193.1848,564.55255,0,0,0,0,100,0),
(@PATH,19,7252.917,-2193.2725,561.06744,0,0,0,0,100,0);

-- Pathing for Timbermaw Woodbender Entry: 11553 "Incorrect"
SET @NPC := 39685;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=7025.4727,`position_y`=-2127.1677,`position_z`=602.7232 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7025.4727,-2127.1677,602.7232,0,0,0,0,100,0),
(@PATH,2,7022.205,-2154.9758,594.70917,0,0,0,0,100,0),
(@PATH,3,7022.0615,-2176.411,592.74426,0,0,0,0,100,0),
(@PATH,4,7005.8994,-2190.9524,587.4094,0,0,0,0,100,0),
(@PATH,5,6993.098,-2203.7297,586.919,0,0,0,0,100,0),
(@PATH,6,6985.287,-2222.6372,583.6212,0,0,0,0,100,0),
(@PATH,7,6978.5156,-2237.384,582.9467,0,0,0,0,100,0),
(@PATH,8,6972.6904,-2252.3657,584.45984,0,0,0,0,100,0),
(@PATH,9,6963.7446,-2262.8352,587.898,0,0,0,0,100,0),
(@PATH,10,6938.0693,-2262.1265,589.9028,0,0,0,0,100,0),
(@PATH,11,6916.3027,-2284.507,589.89453,0,0,0,0,100,0),
(@PATH,12,6938.0693,-2262.1265,589.9028,0,0,0,0,100,0),
(@PATH,13,6963.7446,-2262.8352,587.898,0,0,0,0,100,0),
(@PATH,14,6972.6904,-2252.3657,584.45984,0,0,0,0,100,0),
(@PATH,15,6978.5156,-2237.384,582.9467,0,0,0,0,100,0),
(@PATH,16,6985.287,-2222.6372,583.6212,0,0,0,0,100,0),
(@PATH,17,6993.098,-2203.7297,586.919,0,0,0,0,100,0),
(@PATH,18,7005.8994,-2190.9524,587.4094,0,0,0,0,100,0),
(@PATH,19,7022.0615,-2176.411,592.74426,0,0,0,0,100,0),
(@PATH,20,7022.205,-2154.9758,594.70917,0,0,0,0,100,0);

-- Pathing for Kernda Entry: 11558 "Missing"
SET @NPC := 39359;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=7000.1743,`position_y`=-2123.9153,`position_z`=588.4974 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7000.1743,-2123.9153,588.4974,0,0,0,0,100,0),
(@PATH,2,7031.818,-2119.0874,586.555,0,0,0,0,100,0),
(@PATH,3,7049.333,-2116.2026,586.42816,0,0,0,0,100,0),
(@PATH,4,7059.7974,-2115.566,586.4103,0,0,0,0,100,0),
(@PATH,5,7085.1753,-2116.5076,582.4193,0,0,0,0,100,0),
(@PATH,6,7059.8647,-2115.5618,586.44867,0,0,0,0,100,0),
(@PATH,7,7049.333,-2116.2026,586.42816,0,0,0,0,100,0),
(@PATH,8,7031.818,-2119.0874,586.555,0,0,0,0,100,0);

UPDATE `creature` SET `wander_distance`=0,`MovementType`=0 WHERE `guid` IN (39717,39718,39722,39726,39356,39357,39358,40366);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_08_00' WHERE sql_rev = '1641660333161433796';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

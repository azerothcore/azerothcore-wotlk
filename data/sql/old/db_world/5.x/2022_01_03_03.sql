-- DB update 2022_01_03_02 -> 2022_01_03_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_03_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_03_02 2022_01_03_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640708083968225794'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640708083968225794');

-- Forsaken Raiders missing auras.
DELETE FROM `creature_template_addon` WHERE `entry`=17108;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (17108,0,0,0,1,0,0, '6718 8601');
UPDATE `creature_addon` SET `auras`='6718 8601' WHERE `guid` IN (15577,15702,15705);

-- Pathing for Forsaken Raider Entry: 17108
SET @NPC := 15576;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-323.04807,`position_y`=-707.5532,`position_z`=57.673595 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '6718 8601');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-323.04807,-707.5532,57.673595,0,0,0,0,100,0),
(@PATH,2,-326.25027,-702.3287,57.721058,0,0,0,0,100,0),
(@PATH,3,-331.1091,-698.3443,57.188877,0,0,0,0,100,0),
(@PATH,4,-337.51675,-695.01044,57.514492,0,0,0,0,100,0),
(@PATH,5,-345.35587,-695.147,57.678593,0,0,0,0,100,0),
(@PATH,6,-351.54834,-697.48004,57.642933,0,0,0,0,100,0),
(@PATH,7,-357.77838,-702.645,57.74414,0,0,0,0,100,0),
(@PATH,8,-360.8693,-709.2741,57.71433,0,0,0,0,100,0),
(@PATH,9,-362.51764,-716.524,57.62908,0,0,0,0,100,0),
(@PATH,10,-359.88306,-724.0493,57.734444,0,0,0,0,100,0),
(@PATH,11,-354.63373,-729.42645,57.71353,0,0,0,0,100,0),
(@PATH,12,-342.9415,-734.2522,57.67711,0,0,0,0,100,0),
(@PATH,13,-333.0178,-731.9668,57.650803,0,0,0,0,100,0),
(@PATH,14,-325.69794,-725.50653,57.713326,0,0,0,0,100,0),
(@PATH,15,-321.80838,-716.3792,57.634827,0,0,0,0,100,0);

-- Pathing for Forsaken Raider Entry: 17108
SET @NPC := 15703;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-334.4402,`position_y`=-714.2187,`position_z`=57.73389 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '6718 8601');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-334.4402,-714.2187,57.73389,0,0,0,0,100,0),
(@PATH,2,-339.19547,-710.28723,57.73348,0,0,0,0,100,0),
(@PATH,3,-339.19547,-710.28723,57.73348,0,0,0,0,100,0),
(@PATH,4,-343.0306,-706.07947,57.73381,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_03_03' WHERE sql_rev = '1640708083968225794';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

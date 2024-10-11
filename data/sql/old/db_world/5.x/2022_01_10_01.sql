-- DB update 2022_01_10_00 -> 2022_01_10_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_10_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_10_00 2022_01_10_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641677125615651909'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641677125615651909');

-- Pathing for Meggi Peppinrocker Entry: 11754
SET @NPC := 42312;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=6712.424,`position_y`=-4694.9053,`position_z`=721.4019 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6712.424,-4694.9053,721.4019,0,0,0,0,100,0),
(@PATH,2,6720.713,-4657.2407,720.9419,0,0,0,0,100,0),
(@PATH,3,6727.289,-4634.758,721.07715,0,0,0,0,100,0),
(@PATH,4,6726.4507,-4618.407,721.0268,0,0,0,0,100,0),
(@PATH,5,6727.289,-4634.758,721.07715,0,0,0,0,100,0),
(@PATH,6,6720.713,-4657.2407,720.9419,0,0,0,0,100,0),
(@PATH,7,6712.424,-4694.9053,721.4019,0,0,0,0,100,0),
(@PATH,8,6721.999,-4669.791,720.9736,0,0,0,0,100,0),
(@PATH,9,6745.51,-4669.717,722.94446,0,0,0,0,100,0),
(@PATH,10,6757.705,-4671.6973,723.93164,0,0,0,0,100,0),
(@PATH,11,6745.629,-4669.6865,723.00854,0,0,0,0,100,0),
(@PATH,12,6721.999,-4669.791,720.9736,0,0,0,0,100,0);

-- Pathing for Everlook Bruiser Entry: 11190
SET @NPC := 42293;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=6725.201,`position_y`=-4617.387,`position_z`=721.484 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6725.201,-4617.387,721.484,0,0,0,0,100,0),
(@PATH,2,6726.097,-4632.5474,721.035,0,0,0,0,100,0),
(@PATH,3,6722.884,-4647.2964,721.115,0,0,0,0,100,0),
(@PATH,4,6718.9707,-4660.717,720.99,0,0,0,0,100,0),
(@PATH,5,6718.0796,-4669.557,720.9736,0,0,0,0,100,0),
(@PATH,6,6717.7407,-4679.6636,721.0959,0,0,0,0,100,0),
(@PATH,7,6714.0225,-4691.308,721.3486,0,0,0,0,100,0),
(@PATH,8,6717.968,-4679.837,721.11664,0,0,0,0,100,0),
(@PATH,9,6724.6177,-4671.613,721.06757,0,0,0,0,100,0),
(@PATH,10,6728.09,-4670.1694,720.8073,0,0,0,0,100,0),
(@PATH,11,6735.9556,-4669.475,721.44666,0,0,0,0,100,0),
(@PATH,12,6744.62,-4670.9326,722.73645,0,0,0,0,100,0),
(@PATH,13,6757.7974,-4670.8237,723.8214,0,0,0,0,100,0),
(@PATH,14,6753.2734,-4669.212,723.9066,0,0,0,0,100,0),
(@PATH,15,6740.137,-4666.286,722.3732,0,0,0,0,100,0),
(@PATH,16,6732.994,-4661.645,720.905,0,0,0,0,100,0),
(@PATH,17,6733.887,-4654.246,721.36566,0,0,0,0,100,0),
(@PATH,18,6738.181,-4643.1562,721.6838,0,0,0,0,100,0),
(@PATH,19,6744.223,-4645.4683,722.17804,0,0,0,0,100,0),
(@PATH,20,6749.9595,-4651.49,724.42523,0,0,0,0,100,0),
(@PATH,21,6750.3325,-4660.2275,724.72894,0,0,0,0,100,0),
(@PATH,22,6746.7485,-4666.85,723.57275,0,0,0,0,100,0),
(@PATH,23,6741.2056,-4667.9946,722.3617,0,0,0,0,100,0),
(@PATH,24,6732.619,-4665.0825,720.9668,0,0,0,0,100,0),
(@PATH,25,6725.346,-4656.4434,720.865,0,0,0,0,100,0),
(@PATH,26,6723.4326,-4648.2964,721.115,0,0,0,0,100,0),
(@PATH,27,6725.489,-4639.336,721.24,0,0,0,0,100,0),
(@PATH,28,6725.974,-4625.1816,720.91,0,0,0,0,100,0);

-- Pathing for Everlook Bruiser Entry: 11190
SET @NPC := 42289;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=6712.8013,`position_y`=-4640.0044,`position_z`=721.4033 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6712.8013,-4640.0044,721.4033,0,0,0,0,100,0),
(@PATH,2,6718.815,-4649.531,721.1697,0,0,0,0,100,0),
(@PATH,3,6719.4937,-4656.592,721.08813,0,0,0,0,100,0),
(@PATH,4,6716.9497,-4663.692,720.99,0,0,0,0,100,0),
(@PATH,5,6711.768,-4667.4287,721.0986,0,0,0,0,100,0),
(@PATH,6,6716.9497,-4663.692,720.99,0,0,0,0,100,0),
(@PATH,7,6719.4937,-4656.592,721.08813,0,0,0,0,100,0),
(@PATH,8,6718.815,-4649.531,721.1697,0,0,0,0,100,0);

-- Add missing random movement
UPDATE `creature` SET `wander_distance`=1,`MovementType`=1 WHERE `guid` IN (42284);
UPDATE `creature` SET `wander_distance`=2,`MovementType`=1 WHERE `guid` IN (42278,42280,42281,42285,42286,42287,42288,42290,42291);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_10_01' WHERE sql_rev = '1641677125615651909';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

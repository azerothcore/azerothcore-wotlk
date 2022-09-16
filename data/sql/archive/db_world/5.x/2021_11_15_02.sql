-- DB update 2021_11_15_01 -> 2021_11_15_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_15_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_15_01 2021_11_15_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636906059131132400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636906059131132400');

-- Pathing for  Entry: 9736 'TDB FORMAT' 
SET @NPC := 45749;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2, `position_x`=-190.45914,`position_y`=-475.58322,`position_z`=87.390236 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@NPC,@PATH,0,0,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-190.45914,-475.58322,87.390236,0,13000,0,@PATH,100,0),
(@PATH,2,-199.65863,-475.6469,87.39023,0,0,0,0,100,0),
(@PATH,3,-203.73833,-478.1855,87.39023,0,13000,0,@PATH,100,0),
(@PATH,4,-197.6343,-470.7975,87.39023,0,0,0,0,100,0),
(@PATH,5,-196.37569,-464.7719,87.39023,0,0,0,0,100,0),
(@PATH,6,-198.07956,-461.35336,87.39023,0,0,0,0,100,0),
(@PATH,7,-202.55379,-460.19125,87.39023,0,13000,0,@PATH,100,0),
(@PATH,8,-190.45914,-475.58322,87.390236,0,0,0,0,100,0);
-- 0x2031001CA0098200001DF100000A7F8B .go xyz -190.45914 -475.58322 87.390236

DELETE FROM `waypoint_scripts` WHERE `id` = @PATH AND `guid` = @NPC;
INSERT INTO `waypoint_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`, `guid`) VALUES
(@PATH, 11, 1, 1, 0, 0, 0, 0, 0, 0, @NPC);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_15_02' WHERE sql_rev = '1636906059131132400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

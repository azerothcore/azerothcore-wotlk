-- DB update 2021_06_09_01 -> 2021_06_09_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_09_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_09_01 2021_06_09_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622618904028016440'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622618904028016440');

SET @AKUMAI = 27433;
SET @PATH = @AKUMAI * 10;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @AKUMAI;

DELETE FROM `creature_addon` WHERE `guid` = @AKUMAI;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(@AKUMAI, @PATH, 0, 0, 0, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -835.87, -419.49, -33.8904, 0, 0, 0, 0, 100, 0),
(@PATH, 2, -833.91, -391.22, -33.8904, 1.928, 10000, 0, 0, 100, 0),
(@PATH, 3, -835.87, -419.49, -33.8904, 0, 0, 0, 0, 100, 0),
(@PATH, 4, -832.57, -461.36, -34.0912, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -850.49, -467.74, -34.0226, 0, 0, 0, 0, 100, 0),
(@PATH, 6, -848.45, -453.86, -33.8922, 1.253, 10000, 0, 0, 100, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_09_02' WHERE sql_rev = '1622618904028016440';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

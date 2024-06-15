-- DB update 2021_11_28_01 -> 2021_11_28_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_28_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_28_01 2021_11_28_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637134824779324732'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637134824779324732');

SET @newPathId = 42143 * 10;

-- Change Spawn time

UPDATE `creature` SET `spawntimesecs` = 5400, `MovementType` = 2 WHERE `guid` = 42143;

-- Insert new path

UPDATE `creature_addon` SET `path_id` = @newPathId WHERE `guid` = 42143;

INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`) VALUES
(@newPathId, 1, 1960, -346, 35.5772, 10000),
(@newPathId, 2, 1952, -421, 35.5772, 10000),
(@newPathId, 3, 2046, -419, 35.5772, 10000),
(@newPathId, 4, 2056, -357, 35.5772, 10000);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_28_02' WHERE sql_rev = '1637134824779324732';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

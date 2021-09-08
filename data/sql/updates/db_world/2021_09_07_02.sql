-- DB update 2021_09_07_01 -> 2021_09_07_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_07_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_07_01 2021_09_07_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630679189870696600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630679189870696600');

SET @POOL = 60010;
SET @WATERBARREL = 32742;
SET @FOODCRATE = 32287;

DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL, 1, 'Water Barrel (29275) / Food Crate (30758) - Stormwind City');

DELETE FROM `pool_gameobject`WHERE `pool_entry`=@POOL;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@WATERBARREL, @POOL, 0, 'Water Barrel (29275) - Stormwind City'),
(@FOODCRATE, @POOL, 0, 'Food Crate (30758) - Stormwind City');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_07_02' WHERE sql_rev = '1630679189870696600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

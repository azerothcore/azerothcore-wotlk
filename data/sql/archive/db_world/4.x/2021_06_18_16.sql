-- DB update 2021_06_18_15 -> 2021_06_18_16
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_18_15';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_18_15 2021_06_18_16 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1623792334812044570'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623792334812044570');

SET @POOL = 60004;
SET @WATERBARREL = 1462;
SET @FOODCRATE = 10677;

DELETE FROM `pool_template` WHERE `entry` = @POOL;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@POOL, 1, 'Water Barrel (1462) / Food Crate (10677) - Kharanos');

DELETE FROM `pool_gameobject` WHERE `guid` IN (@WATERBARREL, @FOODCRATE) AND `pool_entry` = @POOL;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@WATERBARREL, @POOL, 0, 'Water Barrel (1462) - Kharanos'),
(@FOODCRATE, @POOL, 0, 'Food Crate (10677) - Kharanos');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_18_16' WHERE sql_rev = '1623792334812044570';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

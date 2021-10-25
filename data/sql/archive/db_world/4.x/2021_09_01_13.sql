-- DB update 2021_09_01_12 -> 2021_09_01_13
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_12';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_12 2021_09_01_13 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630139869353251128'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630139869353251128');

-- Slightly changes the position of a Small Thorium Vein so it can be mined
UPDATE `gameobject` SET `position_x` = -7275, `position_y` = -788, `position_z` = 299.15 WHERE `id` = 324 AND `guid` = 154;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_13' WHERE sql_rev = '1630139869353251128';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

-- DB update 2021_07_16_01 -> 2021_07_16_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_16_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_16_01 2021_07_16_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626119631085426000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626119631085426000');

UPDATE `gameobject` SET `position_x` = -3333.07, `position_y` = -1774.95, `position_z` = 115.58 WHERE `id` = 1623 AND `guid` = 4198;
UPDATE `gameobject` SET `position_x` = -4292.46, `position_y` = -2271.48, `position_z` = 109.59 WHERE `id` = 1623 AND `guid` = 4252;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_16_02' WHERE sql_rev = '1626119631085426000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

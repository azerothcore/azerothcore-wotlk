-- DB update 2021_07_16_00 -> 2021_07_16_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_16_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_16_00 2021_07_16_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626116879969851100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626116879969851100');

-- move the Groomsblood down on the ground
UPDATE `gameobject` SET `position_x` = -11810.63, `position_y` = -3047.32, `position_z` = 9.84 WHERE `id` = 142145 AND `guid` = 16527;
UPDATE `gameobject` SET `position_x` = -11685.57, `position_y` = -3211.47, `position_z` = 12.53 WHERE `id` = 142145 AND `guid` = 16504;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_16_01' WHERE sql_rev = '1626116879969851100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

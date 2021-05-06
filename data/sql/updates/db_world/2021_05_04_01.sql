-- DB update 2021_05_04_00 -> 2021_05_04_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_04_00 2021_05_04_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620068494045251800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620068494045251800');

UPDATE `gameobject` SET `position_x`=-11422.49, `position_y`=11.69, `position_z`=45.235 WHERE `guid`=34036;
UPDATE `gameobject` SET `position_x`=-11547.95, `position_y`=-178.38, `position_z`=15.896 WHERE `guid`=65255;
UPDATE `gameobject` SET `position_x`=-12039.91, `position_y`=-289.09, `position_z`=25.124 WHERE `guid`=11969;


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

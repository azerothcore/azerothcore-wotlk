-- DB update 2022_01_06_04 -> 2022_01_06_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_06_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_06_04 2022_01_06_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641446334563754297'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641446334563754297');

--
UPDATE `smart_scripts` SET `event_type` = 1, `event_param1` = 6000, `event_param2` = 11000, `target_type` = 19, `target_param1` = 24042, `target_param2` = 40 WHERE `entryorguid` = 23760 AND `source_type` = 0 AND `id` = 3;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_06_05' WHERE sql_rev = '1641446334563754297';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

-- DB update 2021_07_07_06 -> 2021_07_07_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_07_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_07_06 2021_07_07_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625384990443326741'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625384990443326741');

UPDATE `smart_scripts` SET `action_param1` = 8599, `comment` = 'Amani Berserker - Between 0-30% Health - Cast \'Enrage\' (No Repeat)' WHERE `entryorguid` = 15643 AND `source_type` = 0 AND `id` = 0;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_07_07' WHERE sql_rev = '1625384990443326741';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

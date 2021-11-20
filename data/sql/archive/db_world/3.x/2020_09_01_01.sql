-- DB update 2020_09_01_00 -> 2020_09_01_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_09_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_09_01_00 2020_09_01_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1597499028423474100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1597499028423474100');

UPDATE `command` SET `name` = "character deleted purge", `help` = "Syntax: .character deleted purge [#keepDays]\r\nCompletely removes all characters from the database that where deleted more than #keepDays ago. If #keepDays not provided the used value from worldserver.conf option 'CharDelete.KeepDays'. If 'CharDelete.KeepDays' option is disabled (set to value 0) then this command can't be used without the specifying #keepDays parameter." WHERE (`name` = "character deleted old");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

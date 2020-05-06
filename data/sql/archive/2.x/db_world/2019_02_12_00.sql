-- DB update 2019_02_11_00 -> 2019_02_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_02_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_02_11_00 2019_02_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1549462763029736000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1549462763029736000');

DELETE FROM `trinity_string` WHERE `entry` BETWEEN 5062 AND 5071;
DELETE FROM `command` WHERE `name` IN ('spy follow', 'spy unfollow', 'spy groupfollow', 'spy groupunfollow', 'spy clear', 'spy status');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

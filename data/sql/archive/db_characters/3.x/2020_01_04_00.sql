-- DB update 2019_12_09_00 -> 2020_01_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_characters' AND COLUMN_NAME = '2019_12_09_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_characters CHANGE COLUMN 2019_12_09_00 2020_01_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_characters WHERE sql_rev = '1572815191193825836'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1572815191193825836');

UPDATE `worldstates` SET `comment`='NextDailyQuestResetTime' WHERE `entry`=20005;
DELETE FROM `worldstates` WHERE `entry`=20004;
INSERT INTO `worldstates` (`entry`, `value`, `comment`) VALUES(20004, 0, 'cleaning_flags');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

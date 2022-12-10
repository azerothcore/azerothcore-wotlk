-- DB update 2019_05_15_00 -> 2019_11_22_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_characters' AND COLUMN_NAME = '2019_05_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_characters CHANGE COLUMN 2019_05_15_00 2019_11_22_00 bit;
SELECT sql_rev INTO OK FROM version_db_characters WHERE sql_rev = '1572030074009407852'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1572030074009407852');

UPDATE `worldstates` SET `comment`='NextArenaPointDistributionTime' WHERE `entry`=20001;
UPDATE `worldstates` SET `comment`='NextWeeklyQuestResetTime' WHERE `entry`=20002;
UPDATE `worldstates` SET `comment`='NextBGRandomDailyResetTime' WHERE `entry`=20003;
UPDATE `worldstates` SET `comment`='cleaning_flags' WHERE `entry`=20005;
UPDATE `worldstates` SET `comment`='NextGuildDailyResetTime' WHERE `entry`=20006;
UPDATE `worldstates` SET `comment`='NextMonthlyQuestResetTime' WHERE `entry`=20007;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

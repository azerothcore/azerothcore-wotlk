-- DB update 2022_04_23_10 -> 2022_04_23_11
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_23_10';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_23_10 2022_04_23_11 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648483014206486262'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648483014206486262');

UPDATE `creature_template_locale` SET `Title`='' WHERE `entry`=23863;
UPDATE `creature_template_locale` SET `Name`='Zul\'jin' WHERE `entry`=23863 AND `locale` IN ('deDE','esES','esMX','frFR');
UPDATE `creature_template_locale` SET `Name`='줄진' WHERE `entry`=23863 AND `locale` IN ('koKR');
UPDATE `creature_template_locale` SET `Name`='Зул\'джин' WHERE `entry`=23863 AND `locale` IN ('ruRU');
UPDATE `creature_template_locale` SET `Name`='祖尔金' WHERE `entry`=23863 AND `locale` IN ('zhCN');
UPDATE `creature_template_locale` SET `Name`='祖爾金' WHERE `entry`=23863 AND `locale` IN ('zhTW');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_23_11' WHERE sql_rev = '1648483014206486262';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

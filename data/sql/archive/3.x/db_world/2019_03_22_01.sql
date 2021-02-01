-- DB update 2019_03_22_00 -> 2019_03_22_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_03_22_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_03_22_00 2019_03_22_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1553131188458998104'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553131188458998104');

-- achievement_reward
ALTER TABLE `achievement_reward` CHANGE `entry` `ID` mediumint(8) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `achievement_reward` CHANGE `title_A` `TitleA` mediumint(8) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `achievement_reward` CHANGE `title_H` `TitleH` mediumint(8) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `achievement_reward` CHANGE `item` `ItemID` mediumint(8) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `achievement_reward` CHANGE `sender` `Sender` mediumint(8) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `achievement_reward` CHANGE `subject` `Subject` varchar(255) DEFAULT NULL;
ALTER TABLE `achievement_reward` CHANGE `text` `Body` text;
ALTER TABLE `achievement_reward` CHANGE `mailTemplate` `MailTemplateID` mediumint(8) unsigned DEFAULT '0';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

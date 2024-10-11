-- DB update 2021_01_18_02 -> 2021_01_18_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_18_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_18_02 2021_01_18_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1591646826613634700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1591646826613634700');

UPDATE `command` SET `help` = "Syntax: .reload page_text\r\nReload page_text table.\nYou need to delete your client cache or change the cache number in the config in order for your players see the changes." WHERE `name` = "reload page_text";
UPDATE `command` SET `help` = "Syntax: .reload page_text_locale\r\nReload page_text_locale table.\nYou need to delete your client cache or change the cache number in config in order for your players see the changes." WHERE `name` = "reload page_text_locale";

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

-- DB update 2022_03_06_02 -> 2022_03_06_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_06_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_06_02 2022_03_06_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643973891449948100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643973891449948100');

DELETE FROM `command` WHERE `name` IN ('reload quest_greeting', 'reload quest_greeting_locale');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload quest_greeting', 3, 'Syntax: .reload quest_greeting\nReload quest_greeting table.'),
('reload quest_greeting_locale', 3, 'Syntax: .reload quest_greeting_locale\nReload quest_greeting_locale table.');

DROP TABLE IF EXISTS `quest_greeting`;
CREATE TABLE `quest_greeting` (
  `ID` MEDIUMINT UNSIGNED NOT NULL DEFAULT '0',
  `type` TINYINT UNSIGNED NOT NULL DEFAULT '0',
  `GreetEmoteType` SMALLINT UNSIGNED NOT NULL DEFAULT '0',
  `GreetEmoteDelay` INT UNSIGNED NOT NULL DEFAULT '0',
  `Greeting` TEXT,
  `VerifiedBuild` SMALLINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`type`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `quest_greeting_locale`;
CREATE TABLE `quest_greeting_locale` (
  `ID` MEDIUMINT UNSIGNED NOT NULL DEFAULT '0',
  `type` TINYINT UNSIGNED NOT NULL DEFAULT '0',
  `locale` VARCHAR(4) NOT NULL,
  `Greeting` TEXT,
  `VerifiedBuild` SMALLINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`type`,`locale`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8mb4;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_06_03' WHERE sql_rev = '1643973891449948100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643973891449948100');

DELETE FROM `command` WHERE `name` IN ('reload quest_greeting', "reload quest_greeting_locale");
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload quest_greeting', 3, 'Syntax: .reload quest_greeting\nReload quest_greeting table.'),
('reload quest_greeting_locale', 3, 'Syntax: .reload quest_greeting_locale\nReload quest_greeting_locale table.');

DROP TABLE IF EXISTS `quest_greeting`;
CREATE TABLE `quest_greeting` (
  `ID` MEDIUMINT UNSIGNED NOT NULL DEFAULT '0',
  `Type` TINYINT UNSIGNED NOT NULL DEFAULT '0',
  `GreetEmoteType` SMALLINT UNSIGNED NOT NULL DEFAULT '0',
  `GreetEmoteDelay` INT UNSIGNED NOT NULL DEFAULT '0',
  `Greeting` TEXT,
  `VerifiedBuild` SMALLINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`Type`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `quest_greeting_locale`;
CREATE TABLE `quest_greeting_locale` (
  `ID` MEDIUMINT UNSIGNED NOT NULL DEFAULT '0',
  `Type` TINYINT UNSIGNED NOT NULL DEFAULT '0',
  `locale` VARCHAR(4) NOT NULL,
  `Greeting` TEXT,
  `VerifiedBuild` SMALLINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`Type`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8mb4;

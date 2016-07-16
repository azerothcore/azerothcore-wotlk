--
-- CREATE STRUCTURE
--

DROP TABLE IF EXISTS `quest_bugged`;
CREATE TABLE `quest_bugged` (
	`ID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
	`bugged` BOOLEAN NOT NULL DEFAULT '1',
	PRIMARY KEY (`ID`)
);

--
-- ADD DATA
--

DELETE FROM `command` WHERE `name` = 'qc';
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('qc', 0, 'Syntax: .qc [Quest]');

DELETE FROM `quest_bugged`;
INSERT INTO `quest_bugged` (SELECT `ID`, 0 FROM `quest_template`);

-- DB update 2023_02_12_00 -> 2023_02_12_01
--
DROP TABLE IF EXISTS `namesreserved_dbc`;
CREATE TABLE `namesreserved_dbc` (
	`ID` INT UNSIGNED NOT NULL,
	`Pattern` TINYTEXT NOT NULL,
    `LanguagueID` TINYINT NOT NULL,
	PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS `namesprofanity_dbc`;
CREATE TABLE `namesprofanity_dbc` (
	`ID` INT UNSIGNED NOT NULL,
	`Pattern` TINYTEXT NOT NULL,
    `LanguagueID` TINYINT NOT NULL,
	PRIMARY KEY (`ID`)
);

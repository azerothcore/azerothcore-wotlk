--

DROP TABLE IF EXISTS `namesprofanity_dbc`;
CREATE TABLE `namesprofanity_dbc` (
	`ID` INT UNSIGNED NOT NULL,
	`Name` TINYTEXT NOT NULL,
    `Languague` TINYINT NOT NULL,
	PRIMARY KEY (`ID`)
);

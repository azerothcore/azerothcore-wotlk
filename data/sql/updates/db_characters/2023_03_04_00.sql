-- DB update 2023_01_31_00 -> 2023_03_04_00
--
DROP TABLE IF EXISTS `profanity_name`;
CREATE TABLE `profanity_name` (
	`name` VARCHAR(12) NOT NULL,
	PRIMARY KEY (`name`)
) ENGINE=InnoDB;

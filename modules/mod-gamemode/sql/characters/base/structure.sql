DROP TABLE IF EXISTS `acore_characters`.`character_modes`;


CREATE TABLE `acore_characters`.`character_modes` (
  `guid` INT UNSIGNED NOT NULL,
  `mode` INT UNSIGNED NOT NULL,
  `done` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`guid`, `mode`));

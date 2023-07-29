DROP TABLE IF EXISTS `acore_characters`.`forge_character_talents`;
DROP TABLE IF EXISTS `acore_characters`.`forge_character_specs`;
DROP TABLE IF EXISTS `acore_characters`.`forge_character_points`;
DROP TABLE IF EXISTS `acore_characters`.`forge_character_talents_spent`;


CREATE TABLE `acore_characters`.`forge_character_talents` (
  `guid` INT UNSIGNED NOT NULL,
  `spec` INT UNSIGNED NOT NULL,
  `spellid` MEDIUMINT UNSIGNED NOT NULL,
  `tabId` INT UNSIGNED NOT NULL,
  `currentrank` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`guid`, `spec`, `spellid`, `tabId`));

CREATE TABLE `acore_characters`.`forge_character_specs` (
  `id` INT UNSIGNED NOT NULL,
  `guid` INT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NULL,
  `active` TINYINT NOT NULL,
  `spellicon` MEDIUMINT UNSIGNED NOT NULL,
  `visability` TINYINT UNSIGNED NOT NULL,
  `charSpec` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `guid`));

CREATE TABLE `acore_characters`.`forge_character_points` (
  `guid` INT UNSIGNED NOT NULL,
  `type` INT UNSIGNED NOT NULL,
  `spec` INT UNSIGNED NOT NULL,
  `sum` INT UNSIGNED NOT NULL,
  `max` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`guid`, `type`, `spec`));

  CREATE TABLE `acore_characters`.`forge_character_talents_spent` (
  `guid` INT UNSIGNED NOT NULL,
  `spec` INT UNSIGNED NOT NULL,
  `tabId` INT UNSIGNED NOT NULL,
  `spent` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`guid`, `spec`, `tabId`));



INSERT INTO `acore_characters`.`forge_character_points` (`guid`, `type`, `spec`, `sum`, `max`) VALUES (4294967295, 0, 0, 0, 71);
INSERT INTO acore_characters.forge_character_points (`guid`,`type`,`spec`,`sum`,`max`) VALUES (4294967295,1,0,50,500);
INSERT INTO acore_characters.forge_character_points (`guid`,`type`,`spec`,`sum`,`max`) VALUES (4294967295,3,0,0,311);
SET GLOBAL local_infile=1;



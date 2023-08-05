-- Put only sql structure in this file (create table if exists, delete table, alter table etc...).
-- If you don't use this database, then delete this file.
CREATE TABLE `acore_characters`.`character_accountwide_reputation` (
  `accountId` INT UNSIGNED NOT NULL,
  `standing` INT UNSIGNED NOT NULL,
  `value` INT UNSIGNED NOT NULL,
  `rep` INT UNSIGNED NULL,
  PRIMARY KEY (`accountId`, `factionGroup`, `factionId`));


CREATE TABLE `acore_characters`.`character_accountwide_taxi` (
  `accountId` INT UNSIGNED NOT NULL,
  `faction` INT UNSIGNED NOT NULL,
  `node` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`accountId`, `faction`, `node`));

CREATE TABLE `acore_characters`.`character_accountwide_title` (
  `accountId` INT UNSIGNED NOT NULL,
  `title` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`accountId`, `title`));

CREATE TABLE `acore_characters`.`character_accountwide_mount` (
  `accountId` INT UNSIGNED NOT NULL,
  `spellId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`accountId`, `spellId`));

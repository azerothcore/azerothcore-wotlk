-- DB update 2024_12_15_00 -> 2025_01_26_00
DROP TABLE IF EXISTS `autobroadcast_locale`;
CREATE TABLE `autobroadcast_locale` (
  `realmid` INT NOT NULL,
  `id` INT NOT NULL,
  `locale` VARCHAR(4) NOT NULL,
  `text` VARCHAR(45) NULL,
  PRIMARY KEY (`realmid`, `id`))
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
;

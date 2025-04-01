-- DB update 2024_11_15_00 -> 2024_12_15_00
CREATE TABLE IF NOT EXISTS `motd_localized` (
  `realmid` INT,
  `locale` VARCHAR(4) NOT NULL COLLATE 'utf8mb4_unicode_ci',
  `text` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
  PRIMARY KEY (`realmid`, `locale`)
)
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
;

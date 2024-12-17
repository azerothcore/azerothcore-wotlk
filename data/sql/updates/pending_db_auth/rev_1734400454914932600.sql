DROP TABLE IF EXISTS `autobroadcast_localized`;
CREATE TABLE `autobroadcast_localized` (
  `realmid` INT NOT NULL,
  `id` INT NOT NULL,
  `locale` VARCHAR(4) NOT NULL,
  `text` VARCHAR(45) NULL,
  PRIMARY KEY (`realmid`, `id`));

--
CREATE TABLE `motd_localized` (
  `realmid` INT,
  `locale` VARCHAR(5),
  `localized_text` LONGTEXT,
  PRIMARY KEY (`realmid`, `locale`),
  FOREIGN KEY (`realmid`) REFERENCES `motd`(`realmid`)
);
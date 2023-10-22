-- DB update 2023_01_31_00 -> 2023_02_20_00
--
DROP TABLE IF EXISTS `motd`;
CREATE TABLE `motd` (
    `realmid` INT NOT NULL,
    `text` LONGTEXT NULL DEFAULT NULL,
    PRIMARY KEY (`realmid`)
) ENGINE=InnoDB;

DELETE FROM `motd` WHERE  `realmid`=1;
INSERT INTO `motd` (`realmid`, `text`) VALUES
(-1, 'Welcome to an AzerothCore server.');

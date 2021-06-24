INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1624468542752528700');

ALTER TABLE `characters` DROP IF EXISTS `order`;
ALTER TABLE `characters` ADD `order` TINYINT(1) NULL DEFAULT NULL AFTER `grantableLevels`;

INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1554142988374631100');

ALTER TABLE `account` CHANGE COLUMN `online` `online` INT UNSIGNED NOT NULL DEFAULT '0' AFTER `last_login`;
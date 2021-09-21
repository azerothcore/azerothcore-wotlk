INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1632228952688651200');

ALTER TABLE `characters` ADD COLUMN `innTriggerId` INT UNSIGNED NOT NULL AFTER `deleteDate`;

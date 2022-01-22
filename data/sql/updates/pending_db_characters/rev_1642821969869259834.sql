INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1642821969869259834');

-- column `type` contains type of logged action
ALTER TABLE `log_money` ADD COLUMN `type` char(255) NOT NULL AFTER `date`;

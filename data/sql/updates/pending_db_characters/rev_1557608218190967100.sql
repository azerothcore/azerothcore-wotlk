INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1557608218190967100');

ALTER TABLE `characters`
	ADD COLUMN `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `grantableLevels`;

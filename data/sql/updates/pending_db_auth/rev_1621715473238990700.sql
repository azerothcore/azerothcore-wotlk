INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1621715473238990700');

ALTER TABLE `version_db_auth`
	ADD COLUMN `date` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci' AFTER `required_rev`;

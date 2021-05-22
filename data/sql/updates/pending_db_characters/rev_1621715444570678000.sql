INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1621715444570678000');

ALTER TABLE `version_db_characters`
	ADD COLUMN `date` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci' AFTER `required_rev`;

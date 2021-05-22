INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621709841145351300');

ALTER TABLE `version_db_world`
	ADD COLUMN `date` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci' AFTER `required_rev`;

ALTER TABLE `quest_template_locale`
	CHANGE COLUMN `locale` `Locale` VARCHAR(4) NOT NULL COLLATE 'utf8mb4_0900_ai_ci' AFTER `ID`,
	CHANGE COLUMN `Title` `LogTitle` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci' AFTER `Locale`,
	CHANGE COLUMN `Details` `QuestDescription` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci' AFTER `LogTitle`,
	CHANGE COLUMN `Objectives` `LogDescription` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci' AFTER `QuestDescription`,
	CHANGE COLUMN `EndText` `AreaDescription` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci' AFTER `LogDescription`,
	CHANGE COLUMN `CompletedText` `QuestCompletionLog` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci' AFTER `AreaDescription`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`ID`, `Locale`) USING BTREE;

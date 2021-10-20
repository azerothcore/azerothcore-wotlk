INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634585414602428800');

ALTER TABLE `quest_template` ADD COLUMN `RewardMoneyDifficulty` INT UNSIGNED DEFAULT 0 NOT NULL AFTER `RewardMoney`; 

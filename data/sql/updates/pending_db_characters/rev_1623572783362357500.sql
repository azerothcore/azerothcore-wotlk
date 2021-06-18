INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1623572783362357500');

ALTER TABLE `item_loot_storage`
ADD COLUMN `conditionLootId` INT NOT NULL AFTER `needs_quest`; 



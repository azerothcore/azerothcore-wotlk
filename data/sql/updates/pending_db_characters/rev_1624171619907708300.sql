INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1624171619907708300');

ALTER TABLE `item_loot_storage` CHANGE `conditionLootId` `conditionLootId` INT DEFAULT 0 NOT NULL;

INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1626271703991541000');
ALTER TABLE `item_loot_storage` 
  ADD COLUMN `item_index` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `count`;

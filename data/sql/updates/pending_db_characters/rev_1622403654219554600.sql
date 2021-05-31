INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1622403654219554600');

ALTER TABLE `item_loot_storage`
ADD COLUMN `follow_loot_rules` TINYINT UNSIGNED NOT NULL AFTER `randomSuffix`,
ADD COLUMN `freeforall` TINYINT UNSIGNED NOT NULL AFTER `follow_loot_rules`,
ADD COLUMN `is_blocked` TINYINT UNSIGNED NOT NULL AFTER `freeforall`,
ADD COLUMN `is_counted` TINYINT UNSIGNED NOT NULL AFTER `is_blocked`,
ADD COLUMN `is_underthreshold` TINYINT UNSIGNED NOT NULL AFTER `is_counted`,
ADD COLUMN `needs_quest` TINYINT UNSIGNED NOT NULL AFTER `is_underthreshold`; 

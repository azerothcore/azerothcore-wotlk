-- DB update 2025_07_29_00 -> 2025_09_03_00
-- Add petition_id column to petition table
ALTER TABLE `petition` ADD COLUMN `petition_id` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `petitionguid`;
-- Populate petition_id based on petitionguid
UPDATE `petition` SET `petition_id` = CASE WHEN `petitionguid` <= 2147483647 THEN `petitionguid` ELSE `petitionguid` - 2147483648 END WHERE `petition_id` = 0;
-- Add index on petition_id
ALTER TABLE `petition` ADD INDEX `idx_petition_id` (`petition_id`);
-- Add petition_id column to petition_sign table
ALTER TABLE `petition_sign` ADD COLUMN `petition_id` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `petitionguid`;
-- Populate petition_id in petition_sign from petition table
UPDATE `petition_sign` AS `ps` JOIN `petition` AS `p` ON `p`.`petitionguid` = `ps`.`petitionguid` SET `ps`.`petition_id` = `p`.`petition_id` WHERE `ps`.`petition_id` = 0;
-- Add index on petition_id and playerguid in petition_sign
ALTER TABLE `petition_sign` ADD INDEX `idx_petition_id_player` (`petition_id`, `playerguid`);
-- Update enchantments in item_instance with petition_id prefix
UPDATE `item_instance` AS `ii` JOIN `petition` AS `p` ON `p`.`petitionguid` = `ii`.`guid` SET `ii`.`enchantments` = CONCAT(`p`.`petition_id`, SUBSTRING(`ii`.`enchantments`, LOCATE(' ', `ii`.`enchantments`))) WHERE `ii`.`enchantments` IS NOT NULL AND `ii`.`enchantments` <> '';

--
-- Add 31-bit safe petition_id to decouple from item_instance.guid
ALTER TABLE `petition`
    ADD COLUMN `petition_id` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `petitionguid`;

-- Map existing rows: prefer same value if <= INT32_MAX, else fold bit 31
UPDATE `petition`
SET `petition_id` = CASE
    WHEN `petitionguid` <= 2147483647 THEN `petitionguid`
    ELSE `petitionguid` - 2147483648
END
WHERE `petition_id` = 0;

-- Index for fast lookups by petition_id
ALTER TABLE `petition`
    ADD INDEX `idx_petition_id` (`petition_id`);

-- Signatures: add petition_id and backfill from petition table
ALTER TABLE `petition_sign`
    ADD COLUMN `petition_id` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `petitionguid`;

UPDATE `petition_sign` AS `ps`
JOIN `petition` AS `p` ON `p`.`petitionguid` = `ps`.`petitionguid`
SET `ps`.`petition_id` = `p`.`petition_id`
WHERE `ps`.`petition_id` = 0;

-- Index to support deletes by petition_id
ALTER TABLE `petition_sign`
    ADD INDEX `idx_petition_id_player` (`petition_id`, `playerguid`);

-- Repair existing charter items: set first enchantment token to petition_id
UPDATE `item_instance` AS `ii`
JOIN `petition` AS `p` ON `p`.`petitionguid` = `ii`.`guid`
SET `ii`.`enchantments` = CONCAT(`p`.`petition_id`, SUBSTRING(`ii`.`enchantments`, LOCATE(' ', `ii`.`enchantments`)))
WHERE `ii`.`enchantments` IS NOT NULL AND `ii`.`enchantments` <> '';
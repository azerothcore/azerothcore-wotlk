-- Add comment column to npc_vendor
ALTER TABLE `npc_vendor`
ADD COLUMN `Comment` VARCHAR(255) NULL;

-- Fill comment with "Vendor name - Item name".
UPDATE `npc_vendor`
INNER JOIN `creature_template` ON `npc_vendor`.`entry` = `creature_template`.`entry`
INNER JOIN `item_template` ON `npc_vendor`.`item` = `item_template`.`entry`
SET `npc_vendor`.`comment` = CONCAT(`creature_template`.`name`, ' - ', `item_template`.`name`)
WHERE `npc_vendor`.`comment` IS NULL;
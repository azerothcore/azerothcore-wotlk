DELETE `creature_loot_template` FROM `creature_loot_template`
JOIN `item_template` ON `item_template`.`Entry` = `creature_loot_template`.`Item`
WHERE `creature_loot_template`.`Entry` = 4096 AND `item_template`.`RequiredLevel` > 30;

-- DB update 2026_07_22_00 -> 2026_08_15_00
--
-- Pet numbers are recycled across restarts, so rows left behind by a deleted pet get picked up by
-- whichever pet is later assigned the same number.
DELETE `ps` FROM `pet_spell` `ps` LEFT JOIN `character_pet` `cp` ON `cp`.`id` = `ps`.`guid` WHERE `cp`.`id` IS NULL;
DELETE `pa` FROM `pet_aura` `pa` LEFT JOIN `character_pet` `cp` ON `cp`.`id` = `pa`.`guid` WHERE `cp`.`id` IS NULL;
DELETE `psc` FROM `pet_spell_cooldown` `psc` LEFT JOIN `character_pet` `cp` ON `cp`.`id` = `psc`.`guid` WHERE `cp`.`id` IS NULL;

-- DB update 2026_08_15_00 -> 2026_10_31_00
--
-- Keep only the most recently saved current pet per owner, move the others out of the current slot
UPDATE `character_pet` AS `cp`
INNER JOIN `character_pet` AS `newer` ON `newer`.`owner` = `cp`.`owner` AND `newer`.`slot` = 0
    AND (`newer`.`savetime` > `cp`.`savetime` OR (`newer`.`savetime` = `cp`.`savetime` AND `newer`.`id` > `cp`.`id`))
    SET `cp`.`slot` = 100 WHERE `cp`.`slot` = 0 AND `cp`.`PetType` = 0;

-- DB update 2022_07_24_00 -> 2022_07_24_01
--
UPDATE `reference_loot_template` SET `Chance`=0 WHERE  `Entry`=35026 AND `Item` IN (22407, 22406, 22405, 22404, 22403);

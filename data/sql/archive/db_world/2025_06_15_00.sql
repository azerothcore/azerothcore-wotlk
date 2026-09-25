-- DB update 2025_06_12_04 -> 2025_06_15_00
--
UPDATE `reference_loot_template` SET `Chance` = 0,  `GroupId` = 3 WHERE `Entry` = 1276884;

UPDATE `creature_loot_template` SET `MinCount` = 3, `MaxCount` = 3 WHERE `Entry`= 17968 AND`Item` = 34069 AND `Reference` = 1276884;

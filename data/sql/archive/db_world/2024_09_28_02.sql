-- DB update 2024_09_28_01 -> 2024_09_28_02
DELETE FROM `skill_extra_item_template` WHERE `spellId` = 28551;
INSERT INTO `skill_extra_item_template` (`spellId`, `requiredSpecialization`, `additionalCreateChance`, `additionalMaxNum`) VALUES (28551, 28675, 14, 4);

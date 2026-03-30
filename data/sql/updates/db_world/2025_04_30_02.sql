-- DB update 2025_04_30_01 -> 2025_04_30_02
--
DELETE FROM `spell_group` WHERE `id` = 1005 AND `spell_id` = 23060;
INSERT INTO `spell_group` VALUES (1005, 23060, 0);

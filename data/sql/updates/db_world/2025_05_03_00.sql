-- DB update 2025_05_01_00 -> 2025_05_03_00
--
DELETE FROM `spell_group` WHERE `spell_id` = 27648 AND `id` = 1014;
INSERT INTO `spell_group` VALUES (1014, 27648, 0);

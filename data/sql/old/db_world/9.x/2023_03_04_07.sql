-- DB update 2023_03_04_06 -> 2023_03_04_07
--
DELETE FROM `spell_group` WHERE `id`=1001 AND `spell_id`=25661;
INSERT INTO `spell_group` VALUES
(1001,25661,0);

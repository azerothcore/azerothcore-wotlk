-- DB update 2022_06_14_05 -> 2022_06_14_06
--
DELETE FROM `spell_group` WHERE `spell_id` IN (8042,20005);
INSERT INTO `spell_group` VALUES
(1014,8042,0),
(1014,20005,0);

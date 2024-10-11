-- DB update 2023_03_13_03 -> 2023_03_14_00
--
DELETE FROM `spell_custom_attr` WHERE `spell_id`=69489;
INSERT INTO `spell_custom_attr` VALUES
(69489,0x02000000);

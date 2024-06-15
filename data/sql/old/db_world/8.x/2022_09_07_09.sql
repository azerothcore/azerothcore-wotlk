-- DB update 2022_09_07_08 -> 2022_09_07_09
--
DELETE FROM `spell_script_names` WHERE `spell_id`=21848;
INSERT INTO `spell_script_names` VALUES
(21848,'spell_item_snowman');

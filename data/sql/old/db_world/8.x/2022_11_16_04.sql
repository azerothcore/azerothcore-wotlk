-- DB update 2022_11_16_03 -> 2022_11_16_04
--
DELETE FROM `spell_script_names` WHERE `spell_id`=9160;
INSERT INTO `spell_script_names` VALUES
(9160,'spell_item_green_whelp_armor');

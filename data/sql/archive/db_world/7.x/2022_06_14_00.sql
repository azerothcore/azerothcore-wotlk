-- DB update 2022_06_13_05 -> 2022_06_14_00
--
DELETE FROM `spell_script_names` WHERE `spell_id`=24684;
INSERT INTO `spell_script_names` VALUES
(24684,'spell_chain_burn');

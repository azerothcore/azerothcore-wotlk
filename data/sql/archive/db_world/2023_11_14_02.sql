-- DB update 2023_11_14_01 -> 2023_11_14_02
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 29494;
INSERT INTO `spell_script_names` VALUES
(29494, 'spell_karazhan_temptation');

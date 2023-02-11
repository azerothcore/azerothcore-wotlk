-- DB update 2022_09_25_01 -> 2022_09_25_02
--
DELETE FROM `spell_script_names` WHERE `spell_id`=818;
INSERT INTO `spell_script_names` VALUES
(818,'spell_gen_basic_campfire');

-- DB update 2022_07_24_02 -> 2022_07_24_03
--
DELETE FROM `spell_script_names` WHERE `spell_id`=56246;
INSERT INTO `spell_script_names` VALUES
(56246,'spell_warl_glyph_of_felguard');

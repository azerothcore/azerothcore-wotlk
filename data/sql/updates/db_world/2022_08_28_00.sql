-- DB update 2022_08_27_08 -> 2022_08_28_00
--
DELETE FROM `spell_script_names` WHERE `spell_id`=24905;
INSERT INTO `spell_script_names` VALUES
(24905,'spell_dru_moonkin_form_passive_proc');

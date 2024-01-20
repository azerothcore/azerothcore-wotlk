-- DB update 2023_11_02_00 -> 2023_11_02_01
-- Choking Vines
DELETE FROM `spell_custom_attr` WHERE `spell_id`=35244;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (35244, 4194304);

DELETE FROM `spell_script_names` WHERE `spell_id`=35244 AND `ScriptName`='spell_gen_choking_vines';
INSERT INTO `spell_script_names` VALUES (35244, 'spell_gen_choking_vines');

-- DB update 2024_04_30_00 -> 2024_05_04_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 30166;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (30166, 'spell_magtheridon_shadow_grasp_visual');

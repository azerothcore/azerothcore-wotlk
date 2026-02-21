-- DB update 2024_09_24_00 -> 2024_09_24_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 36092;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(36092, 'spell_kaelthas_kael_explodes');

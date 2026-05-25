-- DB update 2024_03_11_00 -> 2024_03_11_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 36819;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(36819, 'spell_kael_pyroblast');

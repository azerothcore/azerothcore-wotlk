-- DB update 2025_09_16_02 -> 2025_09_16_03
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 51009;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(51009, 'spell_soul_deflection');

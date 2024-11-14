-- DB update 2024_11_14_00 -> 2024_11_14_01
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_entropius_negative_energy';
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_entropius_negative_energy_periodic' AND `spell_id` = 46284;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(46284, 'spell_entropius_negative_energy_periodic');

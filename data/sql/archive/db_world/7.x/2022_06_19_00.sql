-- DB update 2022_06_18_15 -> 2022_06_19_00
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_mandokir_charge';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(24408, 'spell_mandokir_charge');

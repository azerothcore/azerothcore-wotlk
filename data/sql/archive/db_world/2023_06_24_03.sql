-- DB update 2023_06_24_02 -> 2023_06_24_03
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_capacitus_polarity_charge_aura';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(39088, 'spell_capacitus_polarity_charge_aura'),
(39091, 'spell_capacitus_polarity_charge_aura');

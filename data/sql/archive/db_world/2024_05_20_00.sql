-- DB update 2024_05_19_01 -> 2024_05_20_00
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_anetheron_sleep';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(31298, 'spell_anetheron_sleep');

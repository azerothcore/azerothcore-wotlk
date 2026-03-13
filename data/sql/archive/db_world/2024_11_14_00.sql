-- DB update 2024_11_13_04 -> 2024_11_14_00
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_electrial_storm' AND `spell_id` = 43648;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(43648, 'spell_electrial_storm');

-- DB update 2024_12_03_02 -> 2024_12_05_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 43657;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(43657, 'spell_electrical_storm_proc');

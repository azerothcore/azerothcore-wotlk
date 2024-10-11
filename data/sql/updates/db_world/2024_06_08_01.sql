-- DB update 2024_06_08_00 -> 2024_06_08_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 32014;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(32014, 'spell_air_burst');

-- DB update 2023_02_18_07 -> 2023_02_18_08
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 38194;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(38194, 'spell_talon_king_ikiss_blink');

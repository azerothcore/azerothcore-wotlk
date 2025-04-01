-- DB update 2024_12_31_01 -> 2025_01_03_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 43096;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(43096, 'spell_summon_all_players_dummy');

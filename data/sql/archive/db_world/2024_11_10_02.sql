-- DB update 2024_11_10_01 -> 2024_11_10_02
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 39594;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(39594, 'spell_gen_select_target_count_15_4');

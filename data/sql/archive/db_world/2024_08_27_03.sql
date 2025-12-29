-- DB update 2024_08_27_02 -> 2024_08_27_03
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 41357;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(41357, 'spell_gen_select_target_count_15_3');

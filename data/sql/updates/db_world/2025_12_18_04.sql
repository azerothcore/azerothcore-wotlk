-- DB update 2025_12_18_03 -> 2025_12_18_04
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_gen_26pct_count_pct_from_max_hp' AND `spell_id` = 29879;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(29879, 'spell_gen_26pct_count_pct_from_max_hp');

-- DB update 2022_07_20_10 -> 2022_07_20_11
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 25371 AND `ScriptName` = 'spell_consume_aq20';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (25371, 'spell_consume_aq20');
DELETE FROM `spell_script_names` WHERE `spell_id` = 25373 AND `ScriptName` = 'spell_gen_10pct_count_pct_from_max_hp';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (25373, 'spell_gen_10pct_count_pct_from_max_hp');

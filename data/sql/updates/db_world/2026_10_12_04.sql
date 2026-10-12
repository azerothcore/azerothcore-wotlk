-- DB update 2026_10_12_03 -> 2026_10_12_04
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 63984 AND `ScriptName` = 'spell_gen_hate_to_zero';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63984, 'spell_gen_hate_to_zero');

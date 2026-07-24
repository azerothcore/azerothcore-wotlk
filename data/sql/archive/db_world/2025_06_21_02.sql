-- DB update 2025_06_21_01 -> 2025_06_21_02
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (58552,58533) AND `ScriptName`='spell_chapter5_return_to_capital';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(58552, 'spell_chapter5_return_to_capital'),
(58533, 'spell_chapter5_return_to_capital');

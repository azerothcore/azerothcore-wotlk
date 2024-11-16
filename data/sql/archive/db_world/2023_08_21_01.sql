-- DB update 2023_08_21_00 -> 2023_08_21_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (37906, 36298);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(37906, 'spell_q10651_q10692_book_of_fel_names');

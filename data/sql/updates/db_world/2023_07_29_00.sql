-- DB update 2023_07_28_00 -> 2023_07_29_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 38048;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (38048, 'spell_gen_curse_of_pain');

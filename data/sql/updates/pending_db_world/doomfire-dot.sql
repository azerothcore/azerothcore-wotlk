DELETE FROM `spell_script_names` WHERE `spell_id` = 31944;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (31944, 'spell_doomfire');

DELETE FROM `spell_custom_attr` WHERE `spell_id` = 31944;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (31944, 4194304);

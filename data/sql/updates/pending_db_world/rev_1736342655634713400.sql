--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (7098, 39647);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(7098, 'spell_gen_proc_on_victim'),
(39647, 'spell_gen_proc_on_victim');

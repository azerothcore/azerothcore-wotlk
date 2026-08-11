-- DB update 2026_08_08_07 -> 2026_08_08_08
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_gen_clear_demonic_circle';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62037, 'spell_gen_clear_demonic_circle');

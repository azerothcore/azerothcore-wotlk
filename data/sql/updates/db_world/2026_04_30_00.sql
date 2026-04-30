-- DB update 2026_04_29_07 -> 2026_04_30_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 27812 AND `ScriptName` = 'spell_kelthuzad_void_blast';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(27812, 'spell_kelthuzad_void_blast');

--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (57491, 60241);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(57491, 'spell_obsidian_sanctum_flame_tsunami'),
(60241, 'spell_obsidian_sanctum_flame_tsunami_leap');

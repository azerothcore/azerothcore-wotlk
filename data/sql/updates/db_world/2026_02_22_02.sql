-- DB update 2026_02_22_01 -> 2026_02_22_02
-- Honor Among Thieves spell script registration
DELETE FROM `spell_script_names` WHERE `spell_id` IN (51698, 51700, 51701, 52916);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(51698, 'spell_rog_honor_among_thieves'),
(51700, 'spell_rog_honor_among_thieves'),
(51701, 'spell_rog_honor_among_thieves'),
(52916, 'spell_rog_honor_among_thieves_proc');

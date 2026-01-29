-- Register Nether Protection spell script
DELETE FROM `spell_script_names` WHERE `spell_id` = -30299;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-30299, 'spell_warl_nether_protection');

-- Register Curse of Agony spell script
DELETE FROM `spell_script_names` WHERE `spell_id` = -980;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-980, 'spell_warl_curse_of_agony');

-- Fix Nightfall and Glyph of Corruption registrations
DELETE FROM `spell_script_names` WHERE `spell_id` = -18094;
DELETE FROM `spell_script_names` WHERE `spell_id` = 56218;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-18094, 'spell_warl_nightfall'),
(56218, 'spell_warl_glyph_of_corruption_nightfall');

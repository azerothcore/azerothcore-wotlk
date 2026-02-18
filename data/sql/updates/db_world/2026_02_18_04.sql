-- DB update 2026_02_18_03 -> 2026_02_18_04
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

-- Register Acclimation spell script (DK)
DELETE FROM `spell_script_names` WHERE `spell_id` = -49200;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-49200, 'spell_dk_acclimation');

-- Register Advantage T10 4P spell script (DK)
DELETE FROM `spell_script_names` WHERE `spell_id` = 70656;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(70656, 'spell_dk_advantage_t10_4p');

-- Register Glyph of Barkskin spell script (Druid)
DELETE FROM `spell_script_names` WHERE `spell_id` = 63057;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63057, 'spell_dru_glyph_of_barkskin');

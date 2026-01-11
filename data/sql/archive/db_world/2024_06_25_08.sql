-- DB update 2024_06_25_07 -> 2024_06_25_08
-- Drunken Haze, Drunken Skull Crack
DELETE FROM `spell_script_names` WHERE `spell_id` IN (37591,29690);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(37591, 'spell_gen_sober_up'),
(29690, 'spell_gen_sober_up');

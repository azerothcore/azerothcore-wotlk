-- DB update 2023_09_26_01 -> 2023_09_26_02
-- #12145 midsummer add spell script spell_midsummer_ribbon_pole_visual
DELETE FROM `spell_script_names` WHERE `spell_id` = 29172;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(29172, 'spell_midsummer_ribbon_pole_visual');

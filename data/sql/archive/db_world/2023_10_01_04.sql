-- DB update 2023_10_01_03 -> 2023_10_01_04
-- #12145 midsummer add spell script spell_midsummer_ribbon_pole_visual
DELETE FROM `spell_script_names` WHERE `spell_id` IN (29531, 29705, 29726, 29727);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(29531, 'spell_midsummer_ribbon_pole_visual'),
(29705, 'spell_midsummer_ribbon_pole_visual'),
(29726, 'spell_midsummer_ribbon_pole_visual'),
(29727, 'spell_midsummer_ribbon_pole_visual');

-- Midsummer - add spell script for 29235 Fire Festival Fortitude
DELETE FROM `spell_script_names` WHERE `spell_id` = 29235;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(29235, 'spell_fire_festival_fortitude');

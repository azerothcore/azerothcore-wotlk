-- DB update 2026_03_14_01 -> 2026_03_14_02
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (60936, 60939);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(60936, 'spell_malygos_surge_of_power_25'),
(60939, 'spell_malygos_surge_of_power_warning_selector_25');

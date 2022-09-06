-- DB update 2022_08_25_03 -> 2022_08_25_04
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (26546, 26555);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(26546, 'spell_aq_shadow_storm'),
(26555, 'spell_aq_shadow_storm');

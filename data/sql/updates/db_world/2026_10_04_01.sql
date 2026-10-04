-- DB update 2026_10_04_00 -> 2026_10_04_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (66733, 66683, 67660, 67661, 67662);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(66733, 'spell_icehowl_jump_back'),
(66683, 'spell_icehowl_massive_crash'),
(67660, 'spell_icehowl_massive_crash'),
(67661, 'spell_icehowl_massive_crash'),
(67662, 'spell_icehowl_massive_crash');

--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (62168, 65250) AND `ScriptName` = 'spell_algalon_black_hole_ignore_pets';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62168, 'spell_algalon_black_hole_ignore_pets'),
(65250, 'spell_algalon_black_hole_ignore_pets');

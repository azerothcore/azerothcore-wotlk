-- DB update 2024_01_07_00 -> 2024_01_07_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 18461 AND `ScriptName` = 'spell_rog_vanish_purge';
DELETE FROM `spell_script_names` WHERE `spell_id` = -1856 AND `ScriptName` = 'spell_rog_vanish';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(18461, 'spell_rog_vanish_purge'),
(-1856, 'spell_rog_vanish');

-- DB update 2026_09_17_01 -> 2026_09_18_00
--
-- Ancient Water Spirit: Tidal Wave damage and knockback now follow the cast, not a timer

DELETE FROM `spell_script_names` WHERE `spell_id` IN (62653, 62935) AND `ScriptName` = 'spell_freya_tidal_wave';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62653, 'spell_freya_tidal_wave'),
(62935, 'spell_freya_tidal_wave');

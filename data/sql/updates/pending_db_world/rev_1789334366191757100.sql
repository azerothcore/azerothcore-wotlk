--
-- Ancient Water Spirit: Tidal Wave damage and knockback now come from the charge itself

DELETE FROM `spell_script_names` WHERE `spell_id` IN (62653, 62935);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62653, 'spell_freya_tidal_wave'),
(62935, 'spell_freya_tidal_wave');

--
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_hakkar_cause_insanity', 'spell_hakkar_blood_siphon');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(24327, 'spell_hakkar_cause_insanity'),
(24324, 'spell_hakkar_blood_siphon');

-- DB update 2022_06_26_01 -> 2022_06_26_02
--
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_hakkar_blood_siphon');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(24324, 'spell_hakkar_blood_siphon');

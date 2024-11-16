-- DB update 2024_11_06_03 -> 2024_11_06_04
--
DELETE FROM `spell_script_names` WHERE `spell_id`=24323 AND `ScriptName`='spell_blood_siphon_aura';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (24323, 'spell_blood_siphon_aura');

-- DB update 2026_11_25_03 -> 2026_11_25_04
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 55479 AND `ScriptName` = 'spell_razuvious_force_obedience';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(55479, 'spell_razuvious_force_obedience');

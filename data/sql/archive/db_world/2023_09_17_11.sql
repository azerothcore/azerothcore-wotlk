-- DB update 2023_09_17_10 -> 2023_09_17_11
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_malchezaar_enfeeble' AND `spell_id` = 30843;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(30843, 'spell_malchezaar_enfeeble');

-- DB update 2024_11_13_01 -> 2024_11_13_02
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 45217 AND `ScriptName` = 'spell_ritual_of_power';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (45217, 'spell_ritual_of_power');

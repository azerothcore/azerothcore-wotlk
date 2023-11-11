-- DB update 2023_11_11_01 -> 2023_11_11_02
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 38452 AND `ScriptName` = 'spell_karathress_power_of_tidalvess';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(38452, 'spell_karathress_power_of_tidalvess');

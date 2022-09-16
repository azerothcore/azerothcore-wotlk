-- DB update 2022_07_09_07 -> 2022_07_09_08
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_hakkar_power_down';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(24693, 'spell_hakkar_power_down');

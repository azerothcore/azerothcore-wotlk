-- DB update 2023_12_12_11 -> 2023_12_12_12
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 37429 AND `ScriptName` = 'spell_lurker_below_spout';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(37429, 'spell_lurker_below_spout');

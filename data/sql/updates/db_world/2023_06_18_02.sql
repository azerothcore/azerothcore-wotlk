-- DB update 2023_06_18_01 -> 2023_06_18_02
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_gargolmar_retalliation' AND `spell_id` = 22857;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(22857, 'spell_gargolmar_retalliation');

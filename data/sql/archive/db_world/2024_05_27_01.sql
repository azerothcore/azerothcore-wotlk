-- DB update 2024_05_27_00 -> 2024_05_27_01
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_azgalor_doom' AND `spell_id` = 31347;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(31347, 'spell_azgalor_doom');

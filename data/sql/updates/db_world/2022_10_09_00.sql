-- DB update 2022_10_08_00 -> 2022_10_09_00
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_cthun_dark_glare';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(26029, 'spell_cthun_dark_glare');

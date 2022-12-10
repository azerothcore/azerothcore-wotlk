-- DB update 2022_10_11_01 -> 2022_10_11_02
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_cthun_digestive_acid';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(26476, 'spell_cthun_digestive_acid');

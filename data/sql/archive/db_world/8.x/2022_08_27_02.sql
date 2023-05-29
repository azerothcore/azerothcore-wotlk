-- DB update 2022_08_27_01 -> 2022_08_27_02
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_huhuran_poison_bolt';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(26052, 'spell_huhuran_poison_bolt');

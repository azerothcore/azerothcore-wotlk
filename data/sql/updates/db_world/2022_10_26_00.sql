-- DB update 2022_10_25_03 -> 2022_10_26_00
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_huhuran_poison_bolt' AND `spell_id` = 26180;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(26180, 'spell_huhuran_poison_bolt');

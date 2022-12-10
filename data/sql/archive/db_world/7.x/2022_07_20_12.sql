-- DB update 2022_07_20_11 -> 2022_07_20_12
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 26180 AND `ScriptName` = 'spell_huhuran_wyvern_sting';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (26180, 'spell_huhuran_wyvern_sting');

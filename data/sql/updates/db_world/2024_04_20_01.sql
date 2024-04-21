-- DB update 2024_04_20_00 -> 2024_04_20_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 31538;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (31538, 'spell_cannibalize_heal');

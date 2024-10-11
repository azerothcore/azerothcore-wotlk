-- DB update 2022_09_25_00 -> 2022_09_25_01
--
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_q4735_collect_rookery_egg';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(15958, 'spell_q4735_collect_rookery_egg');

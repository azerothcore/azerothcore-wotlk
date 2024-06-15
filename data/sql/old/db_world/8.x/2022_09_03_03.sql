-- DB update 2022_09_03_02 -> 2022_09_03_03
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 26077 AND `ScriptName` = 'spell_itch_aq40';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (26077, 'spell_itch_aq40');

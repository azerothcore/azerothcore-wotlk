-- DB update 2022_07_25_02 -> 2022_07_25_03
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 25185 AND `ScriptName` = 'spell_itch_aq20';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (25185, 'spell_itch_aq20');

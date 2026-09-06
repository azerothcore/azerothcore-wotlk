-- DB update 2026_08_20_00 -> 2026_08_20_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (47062, 47063, 47064) AND `ScriptName` = 'spell_q12058_the_runic_prophecies';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(47062, 'spell_q12058_the_runic_prophecies'),
(47063, 'spell_q12058_the_runic_prophecies'),
(47064, 'spell_q12058_the_runic_prophecies');

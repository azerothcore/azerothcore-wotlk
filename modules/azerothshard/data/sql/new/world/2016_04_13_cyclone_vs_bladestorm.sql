/*
-- Query: select * from spell_script_names where scriptname like 'spell_dru_cyclone_check'
LIMIT 0, 1000

-- Date: 2016-04-13 21:28
*/
DELETE FROM `spell_script_names` where `ScriptName` = 'spell_dru_cyclone_check';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (33786,'spell_dru_cyclone_check');

-- DB update 2023_11_18_12 -> 2023_11_18_13
-- Mark of Malice
DELETE FROM `spell_script_names` WHERE `spell_id`=33493 AND `ScriptName`='spell_mark_of_malice';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (33493, 'spell_mark_of_malice');

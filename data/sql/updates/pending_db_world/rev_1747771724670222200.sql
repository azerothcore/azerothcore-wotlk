--
DELETE FROM `spell_script_names` WHERE `spell_id`=30610 AND `ScriptName`='spell_karazhan_wrath_titans_stacker';
DELETE FROM `spell_script_names` WHERE `spell_id`=30554 AND `ScriptName`='spell_karazhan_wrath_titans_aura';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(30610, 'spell_karazhan_wrath_titans_stacker'),
(30554, 'spell_karazhan_wrath_titans_aura');

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616715058536439500');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_gen_clear_debuffs';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(34098, 'spell_gen_clear_debuffs');

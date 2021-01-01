INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609539037767254100');

DELETE FROM `spell_script_names` WHERE `spell_id` = 35201 AND `ScriptName`='spell_gen_paralytic_poison';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(35201, 'spell_gen_paralytic_poison');

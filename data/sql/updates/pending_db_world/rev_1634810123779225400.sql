INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634810123779225400');

DELETE FROM `spell_script_names` WHERE `spell_id`=3488 AND `ScriptName`='spell_felstorm_ressurection';
INSERT INTO `spell_script_names` VALUES (3488,'spell_felstorm_ressurection');

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634764926168630600');

DELETE FROM `spell_script_names` WHERE `spell_id`=29519 AND `ScriptName`='spell_silithyst';
INSERT INTO `spell_script_names` VALUES (29519,'spell_silithyst');

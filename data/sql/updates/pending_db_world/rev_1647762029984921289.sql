INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647762029984921289');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_pri_lightwell');
INSERT INTO `spell_script_names` VALUES
(60123,'spell_pri_lightwell');

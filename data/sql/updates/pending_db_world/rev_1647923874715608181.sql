INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647923874715608181');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_q1846_bending_shinbone');
INSERT INTO `spell_script_names` VALUES
(8856, 'spell_q1846_bending_shinbone');

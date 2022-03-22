INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647924729405978168');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_death_knight_initiate_visual');
INSERT INTO `spell_script_names` VALUES
(51519, 'spell_death_knight_initiate_visual');

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647762263757948026');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_gen_teleporting');
INSERT INTO `spell_script_names` VALUES
(59317,'spell_gen_teleporting');

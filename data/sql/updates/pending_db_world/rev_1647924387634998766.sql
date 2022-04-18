INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647924387634998766');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_gen_remove_impairing_auras');
INSERT INTO `spell_script_names` VALUES
(20589, 'spell_gen_remove_impairing_auras'),
(30918, 'spell_gen_remove_impairing_auras');

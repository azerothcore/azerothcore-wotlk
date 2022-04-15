INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647924198689563161');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_item_mirrens_drinking_hat');
INSERT INTO `spell_script_names` VALUES
(29830, 'spell_item_mirrens_drinking_hat');

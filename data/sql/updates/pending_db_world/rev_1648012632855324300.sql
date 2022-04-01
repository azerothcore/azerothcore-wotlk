INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648012632855324300');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_item_brittle_armor','spell_item_mercurial_shield');
INSERT INTO `spell_script_names` VALUES
(24590,'spell_item_brittle_armor'),
(26465,'spell_item_mercurial_shield');

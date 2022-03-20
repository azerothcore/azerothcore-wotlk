INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647761424947662456');

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_item_runic_healing_injector';
INSERT INTO `spell_script_names` VALUES
(67489,'spell_item_runic_healing_injector');

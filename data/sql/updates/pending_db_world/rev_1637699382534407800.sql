INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637699382534407800');

DELETE FROM `spell_script_names` WHERE `spell_id`=605;
INSERT INTO `spell_script_names` VALUES
(605,'spell_pri_mind_control');

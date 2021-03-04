INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1614891941285225200');

DELETE FROM `spell_script_names` WHERE (`spell_id` = 7932);
INSERT INTO `spell_script_names` VALUES ('7932', 'spell_item_anti_venom');
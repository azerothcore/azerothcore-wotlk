INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631201007246764700');

DELETE FROM `spell_custom_attr` WHERE `spell_id`=21909;
INSERT INTO `spell_custom_attr` VALUES
(21909,0x06000000);

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650033460420476500');

DELETE FROM `spell_custom_attr` WHERE `spell_id` = 22247;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(22247, 0x00000040);

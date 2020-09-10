INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1599741911528143300');

DELETE FROM `spell_custom_attr` WHERE `spell_id` = 60988;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES 
(60988, 524288);

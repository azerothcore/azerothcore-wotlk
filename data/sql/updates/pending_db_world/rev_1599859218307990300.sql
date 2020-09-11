INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1599859218307990300');

DELETE FROM `spell_custom_attr` WHERE `spell_id` = 38318;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(38318, 33554432|67108864);

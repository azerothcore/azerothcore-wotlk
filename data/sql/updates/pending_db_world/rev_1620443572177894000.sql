INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620443572177894000');

DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (60988,55550,42772,59685);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(60988, 0x00080000),
(55550, 0x00080000),
(42772, 0x00080000),
(59685, 0x00080000);

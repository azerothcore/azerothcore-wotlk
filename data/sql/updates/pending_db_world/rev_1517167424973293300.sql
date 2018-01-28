INSERT INTO version_db_world (`sql_rev`) VALUES ('1517167424973293300');

DELETE FROM `areatrigger_scripts` WHERE `entry` = 5709;
INSERT INTO `areatrigger_scripts` VALUES (5709, 'at_lady_deathwhisper_entrance');

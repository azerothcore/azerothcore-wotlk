INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559394390864887200');

UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 128 WHERE `entry` = 20308;

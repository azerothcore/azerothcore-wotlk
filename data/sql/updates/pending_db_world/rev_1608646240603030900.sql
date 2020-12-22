INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1608646240603030900');

UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|33554432 WHERE `entry` IN (17767,17808,17842,17888,17968);

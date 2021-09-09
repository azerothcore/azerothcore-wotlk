INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631088531210049294');

UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`&~(33554432) WHERE `entry` = 3917;

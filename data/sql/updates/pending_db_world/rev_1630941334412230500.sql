INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630941334412230500');

UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`& ~(1 << 26) WHERE `entry`=3917;

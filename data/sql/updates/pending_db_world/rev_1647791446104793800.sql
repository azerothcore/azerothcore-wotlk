INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647791446104793800');

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|512 WHERE `entry` IN (10184,36538);

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647709960805661700');

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry` IN (34146,34150,34151);

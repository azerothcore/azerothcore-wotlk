INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635012097182969400');

UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~0x00000200 WHERE `entry` IN (727,1496,1652,1738,1743,1745,1746);

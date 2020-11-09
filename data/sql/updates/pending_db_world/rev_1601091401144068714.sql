INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601091401144068714');

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x00000080 WHERE `entry` IN (24202, 24203, 24204, 24205);

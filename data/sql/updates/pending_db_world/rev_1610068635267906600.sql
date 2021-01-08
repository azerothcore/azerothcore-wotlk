INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1610068635267906600');

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x00001000 WHERE `entry` = 27914;

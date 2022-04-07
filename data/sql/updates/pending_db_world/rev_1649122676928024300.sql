INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649122676928024300');

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|256 WHERE `entry` = 14020;

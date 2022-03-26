INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648266327758563400');

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|512 WHERE `entry`=36597;

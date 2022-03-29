INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648266327758563400');

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|512 WHERE `entry` IN (36597, 39166, 39167, 39168);

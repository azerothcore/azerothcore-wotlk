INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645976772405658200');

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|512 WHERE `entry` IN (33186,33724,28859,31734);

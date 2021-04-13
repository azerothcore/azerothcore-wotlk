INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617863055133088000');

UPDATE `gameobject` SET `phaseMask`=1|2|16|32|64|128 WHERE `id` BETWEEN 192028 AND 192033;

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612183595364592000');

UPDATE `item_template` SET `flags`=`flags`|2048 WHERE `entry` = 14610;

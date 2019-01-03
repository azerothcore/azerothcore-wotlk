INSERT INTO version_db_auth (`sql_rev`) VALUES ('1546540718864817294');

ALTER TABLE `account` CHANGE `last_login` `last_login` TIMESTAMP NULL;

UPDATE `account` SET `last_login`=NULL WHERE `last_login`='0000-00-00 00:00:00';
INSERT INTO version_db_auth (`sql_rev`) VALUES ('1478975214169487000');

ALTER TABLE `account`
    ADD `token_key` VARCHAR(100) NOT NULL DEFAULT '' AFTER `s`,
    ADD `reg_mail` VARCHAR(255) NOT NULL DEFAULT '' AFTER `mail`,
    ADD `last_attempt_ip` VARCHAR(15) NOT NULL DEFAULT '127.0.0.1' AFTER `last_ip`,
    ADD `lock_country` VARCHAR(2) NOT NULL DEFAULT '00' AFTER `locked`;

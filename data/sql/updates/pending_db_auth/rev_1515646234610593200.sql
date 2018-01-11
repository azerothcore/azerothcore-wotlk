INSERT INTO version_db_auth (`sql_rev`) VALUES ('1515646234610593200');

DROP TABLE IF EXISTS `account_muted`;

CREATE TABLE `account_muted` (
    `guid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
    `mutedate` INT(10) UNSIGNED NOT NULL DEFAULT '0',
    `mutetime` INT(10) UNSIGNED NOT NULL DEFAULT '0',
    `mutedby` VARCHAR(50) NOT NULL,
    `mutereason` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`guid`, `mutedate`)
)
COMMENT='mute List' ENGINE=InnoDB;

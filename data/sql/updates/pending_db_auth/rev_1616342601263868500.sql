INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1616342601263868500');

ALTER TABLE `account`
    CHANGE COLUMN `id` `id` INT,
    CHANGE COLUMN `failed_logins` `failed_logins` INT,
    CHANGE COLUMN `locked` `locked` TINYINT,
    CHANGE COLUMN `online` `online` INT,
    CHANGE COLUMN `expansion` `expansion` TINYINT,
    CHANGE COLUMN `mutetime` `mutetime` BIGINT,
    CHANGE COLUMN `locale` `locale` TINYINT,
    CHANGE COLUMN `recruiter` `recruiter` INT,
    CHANGE COLUMN `totaltime` `totaltime` INT,
    CONVERT TO CHARACTER SET UTF8MB4;

ALTER TABLE `account_access`
  CHANGE COLUMN `id` `id` INT unsigned NOT NULL,
  CHANGE COLUMN `gmlevel` `gmlevel` TINYINT unsigned NOT NULL,
  CHANGE COLUMN `RealmID` `RealmID` INT NOT NULL DEFAULT -1,
  CONVERT TO CHARACTER SET UTF8MB4;

ALTER TABLE `account_banned`
  CHANGE COLUMN `id` `id` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Account id',
  CHANGE COLUMN `bandate` `bandate` INT unsigned NOT NULL DEFAULT 0,
  CHANGE COLUMN `unbandate` `unbandate` INT unsigned NOT NULL DEFAULT 0,
  CHANGE COLUMN `active` `active` TINYINT unsigned NOT NULL DEFAULT 1,
  CONVERT TO CHARACTER SET UTF8MB4;

ALTER TABLE `account_muted`
  CHANGE COLUMN `guid` `guid` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  CHANGE COLUMN `mutedate` `mutedate` INT unsigned NOT NULL DEFAULT 0,
  CHANGE COLUMN `mutetime` `mutetime` INT unsigned NOT NULL DEFAULT 0;

ALTER TABLE `autobroadcast`
  CHANGE COLUMN `realmid` `realmid` INT NOT NULL DEFAULT -1,
  CHANGE COLUMN `id` `id` TINYINT unsigned NOT NULL AUTO_INCREMENT,
  CHANGE COLUMN `weight` `weight` TINYINT unsigned DEFAULT 1,
  CONVERT TO CHARACTER SET UTF8MB4;

ALTER TABLE `ip2nation`
  CHANGE COLUMN `ip` `ip` INT unsigned NOT NULL DEFAULT 0,
  CONVERT TO CHARACTER SET UTF8MB4;

ALTER TABLE `ip2nationCountries`
  CONVERT TO CHARACTER SET UTF8MB4;

ALTER TABLE `ip_banned`
  CHANGE COLUMN `bandate` `bandate` INT unsigned NOT NULL,
  CHANGE COLUMN `unbandate` `unbandate` INT unsigned NOT NULL,
  CONVERT TO CHARACTER SET UTF8MB4;

ALTER TABLE `logs`
  CHANGE COLUMN `time` `time` INT unsigned NOT NULL,
  CHANGE COLUMN `realm` `realm` INT unsigned NOT NULL,
  CHANGE COLUMN `level` `level` TINYINT unsigned NOT NULL DEFAULT 0,
  CONVERT TO CHARACTER SET UTF8MB4;

ALTER TABLE `logs_ip_actions`
  CHANGE COLUMN `id` `id` INT unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Identifier',
  CHANGE COLUMN `account_id` `account_id` INT unsigned NOT NULL COMMENT 'Account ID',
  CHANGE COLUMN `character_guid` `character_guid` INT unsigned NOT NULL COMMENT 'Character Guid',
  CHANGE COLUMN `type` `type` TINYINT unsigned NOT NULL,
  CHANGE COLUMN `unixtime` `unixtime` INT unsigned NOT NULL COMMENT 'Unixtime',
  CONVERT TO CHARACTER SET UTF8MB4;

ALTER TABLE `realmcharacters`
  CHANGE COLUMN `realmid` `realmid` INT unsigned NOT NULL DEFAULT 0,
  CHANGE COLUMN `acctid` `acctid` INT unsigned NOT NULL,
  CHANGE COLUMN `numchars` `numchars` TINYINT unsigned NOT NULL DEFAULT 0,
  CONVERT TO CHARACTER SET UTF8MB4;

ALTER TABLE `realmlist`
  CHANGE COLUMN `id` `id` INT unsigned NOT NULL AUTO_INCREMENT,
  CHANGE COLUMN `port` `port` SMALLINT unsigned NOT NULL DEFAULT 8085,
  CHANGE COLUMN `icon` `icon` TINYINT unsigned NOT NULL DEFAULT 0,
  CHANGE COLUMN `flag` `flag` TINYINT unsigned NOT NULL DEFAULT 2,
  CHANGE COLUMN `timezone` `timezone` TINYINT unsigned NOT NULL DEFAULT 0,
  CHANGE COLUMN `allowedSecurityLevel` `allowedSecurityLevel` TINYINT unsigned NOT NULL DEFAULT 0,
  CHANGE COLUMN `population` `population` FLOAT NOT NULL DEFAULT 0,
  CHANGE COLUMN `gamebuild` `gamebuild` INT unsigned NOT NULL DEFAULT 12340,
  ADD CHECK (`population`>=0),
  CONVERT TO CHARACTER SET UTF8MB4;

ALTER TABLE `uptime`
  CHANGE COLUMN `realmid` `realmid` INT unsigned NOT NULL,
  CHANGE COLUMN `starttime` `starttime` INT unsigned NOT NULL DEFAULT 0,
  CHANGE COLUMN `uptime` `uptime` INT unsigned NOT NULL DEFAULT 0,
  CHANGE COLUMN `maxplayers` `maxplayers` SMALLINT unsigned NOT NULL DEFAULT 0,
  CONVERT TO CHARACTER SET UTF8MB4;

LOCK TABLES `version_db_auth` WRITE;

ALTER TABLE `version_db_auth`
  DROP FOREIGN KEY `required`,
  CONVERT TO CHARACTER SET UTF8MB4;

ALTER TABLE `version_db_auth`
  ADD CONSTRAINT `required` FOREIGN KEY (`required_rev`) REFERENCES `version_db_auth` (`sql_rev`);

UNLOCK TABLES;

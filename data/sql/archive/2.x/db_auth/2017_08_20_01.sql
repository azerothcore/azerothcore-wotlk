-- DB update 2017_08_19_00 -> 2017_08_20_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_auth' AND COLUMN_NAME = '2017_08_19_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_auth CHANGE COLUMN 2017_08_19_00 2017_08_20_01 bit;
SELECT sql_rev INTO OK FROM version_db_auth WHERE sql_rev = '1498796201292521600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_auth (`sql_rev`) VALUES ('1498796201292521600');

DROP TABLE IF EXISTS `ip2nation`;
CREATE TABLE `ip2nation` (
  `ip` int(11) unsigned NOT NULL default '0',
  `country`char(2) NOT NULL default '',
  KEY `ip` (`ip`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ip2nationCountries`;
CREATE TABLE `ip2nationCountries` (
  `code` varchar(4) NOT NULL default '',
  `iso_code_2` varchar(2) NOT NULL default '',
  `iso_code_3` varchar(3) default '',
  `iso_country` varchar(255) NOT NULL default '',
  `country` varchar(255) NOT NULL default '',
  `lat` float NOT NULL default '0',
  `lon` float NOT NULL default '0',  
  PRIMARY KEY  (`code`),
  KEY `code` (`code`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

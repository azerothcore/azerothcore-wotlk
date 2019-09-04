INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1567594119367206874');

CREATE TABLE IF NOT EXISTS `account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `username` varchar(32) NOT NULL DEFAULT '',
  `sha_pass_hash` varchar(40) NOT NULL DEFAULT '',
  `sessionkey` varchar(80) NOT NULL DEFAULT '',
  `v` varchar(64) NOT NULL DEFAULT '',
  `s` varchar(64) NOT NULL DEFAULT '',
  `token_key` varchar(100) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `reg_mail` varchar(255) NOT NULL DEFAULT '',
  `joindate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_ip` varchar(15) NOT NULL DEFAULT '127.0.0.1',
  `last_attempt_ip` varchar(15) NOT NULL DEFAULT '127.0.0.1',
  `failed_logins` int(10) unsigned NOT NULL DEFAULT '0',
  `locked` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `lock_country` varchar(2) NOT NULL DEFAULT '00',
  `last_login` timestamp NULL DEFAULT NULL,
  `online` int(10) unsigned NOT NULL DEFAULT '0',
  `expansion` tinyint(3) unsigned NOT NULL DEFAULT '2',
  `mutetime` bigint(20) NOT NULL DEFAULT '0',
  `mutereason` varchar(255) NOT NULL DEFAULT '',
  `muteby` varchar(50) NOT NULL DEFAULT '',
  `locale` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `os` varchar(3) NOT NULL DEFAULT '',
  `recruiter` int(10) unsigned NOT NULL DEFAULT '0',
  `totaltime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='Account System';

-- Dumping data for table acore_auth.account: ~18 rows (approximately)
DELETE FROM `account`;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` (`id`, `username`, `sha_pass_hash`, `sessionkey`, `v`, `s`, `token_key`, `email`, `reg_mail`, `joindate`, `last_ip`, `last_attempt_ip`, `failed_logins`, `locked`, `lock_country`, `last_login`, `online`, `expansion`, `mutetime`, `mutereason`, `muteby`, `locale`, `os`, `recruiter`, `totaltime`) VALUES
	(1, 'test1', '047ce22643f9b0bd6baeb18d51bf1075a4d43fc6', '', '', '', '', '', '', '2016-01-31 05:09:43', '127.0.0.1', '127.0.0.1', 0, 0, '00', NULL, 0, 2, 0, '', '', 0, '', 0, 0),
	(2, 'test2', '10eb1ff16cf5380147e8281cd8080a210ecb3c53', '', '', '', '', '', '', '2016-01-31 05:09:43', '127.0.0.1', '127.0.0.1', 0, 0, '00', NULL, 0, 2, 0, '', '', 0, '', 0, 0),
	(3, 'test3', 'e546bbf9ca93ae5291f0b441bb9ea2fa0c466176', '', '', '', '', '', '', '2016-01-31 05:09:43', '127.0.0.1', '127.0.0.1', 0, 0, '00', NULL, 0, 2, 0, '', '', 0, '', 0, 0),
	(4, 'test4', '61015d83b456a9c6a7defdff07f55265f24097af', '', '', '', '', '', '', '2016-01-31 05:09:43', '127.0.0.1', '127.0.0.1', 0, 0, '00', NULL, 0, 2, 0, '', '', 0, '', 0, 0),
	(5, 'test5', 'dddeac4ffe5f286ec57b7a1ed63bf3a859debe1e', '', '', '', '', '', '', '2016-01-31 05:09:43', '127.0.0.1', '127.0.0.1', 0, 0, '00', NULL, 0, 2, 0, '', '', 0, '', 0, 0),
	(6, 'test6', 'f1f94cdffd83c8c4182d66689077f92c807ab579', '', '', '', '', '', '', '2016-01-31 05:09:43', '127.0.0.1', '127.0.0.1', 0, 0, '00', NULL, 0, 2, 0, '', '', 0, '', 0, 0),
	(7, 'test7', '6fcd35c35b127be1d9ca040b2b478eb366506ce2', '', '', '', '', '', '', '2016-01-31 05:09:43', '127.0.0.1', '127.0.0.1', 0, 0, '00', NULL, 0, 2, 0, '', '', 0, '', 0, 0),
	(8, 'test8', '484332ccb02e284e4e0a04573c3fa417f4745fdf', '', '', '', '', '', '', '2016-01-31 05:09:43', '127.0.0.1', '127.0.0.1', 0, 0, '00', NULL, 0, 2, 0, '', '', 0, '', 0, 0),
	(9, 'test9', '4fce15ed251721f02754d5381ae9d0137b6a6a30', '', '', '', '', '', '', '2016-01-31 05:09:43', '127.0.0.1', '127.0.0.1', 0, 0, '00', NULL, 0, 2, 0, '', '', 0, '', 0, 0),
	(10, 'test10', 'b22d249228e84ab493b39a2bd765bee9b7c0b350', '', '', '', '', '', '', '2016-01-31 05:09:43', '127.0.0.1', '127.0.0.1', 0, 0, '00', NULL, 0, 2, 0, '', '', 0, '', 0, 0),
	(11, 'YUNA', '8490DD874DF8FC5528CCA66351E558ACF460BBCC', '8F876FC8A6B55E3900D909F98ECE4E38A063D3F7AE28766B8DBCBFCFAC95558566BAABD8D820162F', '7E099E3CB96170374DF7B5A86972A4B1C75ACB69591AA7B8E06EA28B37F53F06', 'E0BBC3BA969CE3582D8A538820E09A852C3ABB3F6A9E488C8D12863883F9A09F', '', '', '', '2019-08-31 16:00:37', '60.169.16.34', '60.169.16.34', 0, 0, '00', '2019-09-03 18:10:35', 0, 2, 0, '', '', 0, 'Win', 0, 29677),
	(13, 'SOAP', '1D7340E998DC472289B35CC81D8114A87E6CDD72', '', '', '', '', '', '', '2019-08-31 18:17:54', '127.0.0.1', '127.0.0.1', 0, 0, '00', NULL, 0, 2, 0, '', '', 0, '', 0, 0),
	(14, 'AHBOT', '47FFF78FAA983E719FFD59EE21FDFDF75AD259F7', 'E99137FAA4405E1E1F6F7771B9D063153D5EF923457512A6478DE3E234F5FABAD8B458B8F9BDD650', '528F86943FE682FA0EF4EBEFFDBA17587BCC0D179003D33C12CB511F4FE398EB', 'A160B89D7DCCE39218B70D580FEBB45B4C261E4A216EBB01F8A5B0609C5F7FB9', '', '', '', '2019-08-31 18:21:10', '60.169.16.34', '60.169.16.34', 0, 0, '00', '2019-08-31 21:58:09', 0, 2, 0, '', '', 0, 'Win', 0, 42),
	(16, 'FIREMOG', 'AC974AE0DFEDB81E30225147A6B353AA2EAE7597', 'E6E9F130DF078E3CF986F25B6E47611507055D05FDB0B8A5E61969E234D59E025D6AD00DC36BD791', '281964927E98F4A629B5753F7F23FD5B5F15E643BD28013D62B374A5CFDBAF53', 'C954F6D62836688B18C11AAE9AB30DA94B0D81971D32C9AA18C5298FCCDEC49F', '', '', '', '2019-09-02 08:14:45', '60.169.16.34', '60.169.16.34', 0, 0, '00', '2019-09-02 18:11:42', 0, 2, 0, '', '', 0, 'Win', 0, 200),
	(17, 'FIREMOG2', '844ACABF42862E871C63EC6026BBACE4F0113E1E', '', '', '', '', 'wakasstaka@gmail.com', '', '2019-09-02 21:00:56', '127.0.0.1', '127.0.0.1', 0, 0, '00', NULL, 0, 2, 0, '', '', 0, '', 0, 0),
	(18, 'FIREMOG3', '34F02426B026C746C03DF5B42B6A022CA3AFBDC0', '', '', '', '', '', '', '2019-09-02 21:02:59', '127.0.0.1', '127.0.0.1', 0, 0, '00', NULL, 0, 2, 0, '', '', 0, '', 0, 0),
	(20, 'YUNA2', '6F351EA725AF090541E3D72BFA31E6B6649BEF4F', 'B2C62084585349E057774389C40F1F48E464CB2EE6B92D115CB186D6F3500E16786AF75365877EBB', '2EF6E777B8001CD03FDE0AFDE0BFA9933F41B1135CB6527621B972C71DABF4F4', 'C5C369E890A1C1583572D107CA19828629C26AC55A18CD3D47B3E08108AC916F', '', '', '', '2019-09-02 22:23:00', '182.16.101.40', '182.16.101.40', 0, 0, '00', '2019-09-03 09:10:41', 1, 2, 0, '', '', 0, 'Win', 0, 983),
	(21, 'psycho', '60F7B3BD685014BB8A20BA35021B21F900BF87D7', 'AB6A9FC2100A9B6DF42668C3809E8C0662971059841FA5F33438AD1D1B69C92A2452E59503D473A3', '4D2117C5F574DE1621D7BB68576D4B6F4206544CACB638B3A5B2619B82CA3303', 'D4AABD2F00D66752CA90E70A9068D6F7DDECC283A93918A85858FBF3B1C0413B', '', 'oct4nus@gmail.com', '', '2019-09-03 06:49:05', '66.18.161.19', '66.18.161.19', 0, 0, '00', '2019-09-03 06:51:23', 0, 2, 0, '', '', 0, 'Win', 0, 0);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;

-- Dumping structure for table acore_auth.account_access
CREATE TABLE IF NOT EXISTS `account_access` (
  `id` int(10) unsigned NOT NULL,
  `gmlevel` tinyint(3) unsigned NOT NULL,
  `RealmID` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`,`RealmID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table acore_auth.account_access: ~15 rows (approximately)
DELETE FROM `account_access`;
/*!40000 ALTER TABLE `account_access` DISABLE KEYS */;
INSERT INTO `account_access` (`id`, `gmlevel`, `RealmID`) VALUES
	(1, 4, -1),
	(2, 4, -1),
	(3, 4, -1),
	(4, 4, -1),
	(5, 4, -1),
	(6, 4, -1),
	(7, 4, -1),
	(8, 4, -1),
	(9, 4, -1),
	(10, 4, -1),
	(11, 3, -1),
	(12, 3, -1),
	(13, 3, -1),
	(14, 3, -1),
	(20, 3, -1);
/*!40000 ALTER TABLE `account_access` ENABLE KEYS */;

-- Dumping structure for table acore_auth.account_banned
CREATE TABLE IF NOT EXISTS `account_banned` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Account id',
  `bandate` int(10) unsigned NOT NULL DEFAULT '0',
  `unbandate` int(10) unsigned NOT NULL DEFAULT '0',
  `bannedby` varchar(50) NOT NULL,
  `banreason` varchar(255) NOT NULL,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`bandate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ban List';

-- Dumping data for table acore_auth.account_banned: ~0 rows (approximately)
DELETE FROM `account_banned`;
/*!40000 ALTER TABLE `account_banned` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_banned` ENABLE KEYS */;

-- Dumping structure for table acore_auth.account_muted
CREATE TABLE IF NOT EXISTS `account_muted` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `mutedate` int(10) unsigned NOT NULL DEFAULT '0',
  `mutetime` int(10) unsigned NOT NULL DEFAULT '0',
  `mutedby` varchar(50) NOT NULL,
  `mutereason` varchar(255) NOT NULL,
  PRIMARY KEY (`guid`,`mutedate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='mute List';

-- Dumping data for table acore_auth.account_muted: ~0 rows (approximately)
DELETE FROM `account_muted`;
/*!40000 ALTER TABLE `account_muted` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_muted` ENABLE KEYS */;

-- Dumping structure for table acore_auth.autobroadcast
CREATE TABLE IF NOT EXISTS `autobroadcast` (
  `realmid` int(11) NOT NULL DEFAULT '-1',
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `weight` tinyint(3) unsigned DEFAULT '1',
  `text` longtext NOT NULL,
  PRIMARY KEY (`id`,`realmid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table acore_auth.autobroadcast: ~0 rows (approximately)
DELETE FROM `autobroadcast`;
/*!40000 ALTER TABLE `autobroadcast` DISABLE KEYS */;
/*!40000 ALTER TABLE `autobroadcast` ENABLE KEYS */;

-- Dumping structure for table acore_auth.ip2nation
CREATE TABLE IF NOT EXISTS `ip2nation` (
  `ip` int(11) unsigned NOT NULL DEFAULT '0',
  `country` char(2) NOT NULL DEFAULT '',
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table acore_auth.ip2nation: ~0 rows (approximately)
DELETE FROM `ip2nation`;
/*!40000 ALTER TABLE `ip2nation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip2nation` ENABLE KEYS */;

-- Dumping structure for table acore_auth.ip2nationCountries
CREATE TABLE IF NOT EXISTS `ip2nationCountries` (
  `code` varchar(4) NOT NULL DEFAULT '',
  `iso_code_2` varchar(2) NOT NULL DEFAULT '',
  `iso_code_3` varchar(3) DEFAULT '',
  `iso_country` varchar(255) NOT NULL DEFAULT '',
  `country` varchar(255) NOT NULL DEFAULT '',
  `lat` float NOT NULL DEFAULT '0',
  `lon` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`code`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table acore_auth.ip2nationCountries: ~0 rows (approximately)
DELETE FROM `ip2nationCountries`;
/*!40000 ALTER TABLE `ip2nationCountries` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip2nationCountries` ENABLE KEYS */;

-- Dumping structure for table acore_auth.ip_banned
CREATE TABLE IF NOT EXISTS `ip_banned` (
  `ip` varchar(15) NOT NULL DEFAULT '127.0.0.1',
  `bandate` int(10) unsigned NOT NULL,
  `unbandate` int(10) unsigned NOT NULL,
  `bannedby` varchar(50) NOT NULL DEFAULT '[Console]',
  `banreason` varchar(255) NOT NULL DEFAULT 'no reason',
  PRIMARY KEY (`ip`,`bandate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Banned IPs';

-- Dumping data for table acore_auth.ip_banned: ~0 rows (approximately)
DELETE FROM `ip_banned`;
/*!40000 ALTER TABLE `ip_banned` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_banned` ENABLE KEYS */;

-- Dumping structure for table acore_auth.logs
CREATE TABLE IF NOT EXISTS `logs` (
  `time` int(10) unsigned NOT NULL,
  `realm` int(10) unsigned NOT NULL,
  `type` varchar(250) NOT NULL,
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `string` text CHARACTER SET latin1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table acore_auth.logs: ~0 rows (approximately)
DELETE FROM `logs`;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;

-- Dumping structure for table acore_auth.logs_ip_actions
CREATE TABLE IF NOT EXISTS `logs_ip_actions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Identifier',
  `account_id` int(10) unsigned NOT NULL COMMENT 'Account ID',
  `character_guid` int(10) unsigned NOT NULL COMMENT 'Character Guid',
  `type` tinyint(3) unsigned NOT NULL,
  `ip` varchar(15) NOT NULL DEFAULT '127.0.0.1',
  `systemnote` text COMMENT 'Notes inserted by system',
  `unixtime` int(10) unsigned NOT NULL COMMENT 'Unixtime',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp',
  `comment` text COMMENT 'Allows users to add a comment',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Used to log ips of individual actions';

-- Dumping data for table acore_auth.logs_ip_actions: ~0 rows (approximately)
DELETE FROM `logs_ip_actions`;
/*!40000 ALTER TABLE `logs_ip_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_ip_actions` ENABLE KEYS */;

-- Dumping structure for table acore_auth.realmcharacters
CREATE TABLE IF NOT EXISTS `realmcharacters` (
  `realmid` int(10) unsigned NOT NULL DEFAULT '0',
  `acctid` int(10) unsigned NOT NULL,
  `numchars` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`realmid`,`acctid`),
  KEY `acctid` (`acctid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Realm Character Tracker';

-- Dumping data for table acore_auth.realmcharacters: ~18 rows (approximately)
DELETE FROM `realmcharacters`;
/*!40000 ALTER TABLE `realmcharacters` DISABLE KEYS */;
INSERT INTO `realmcharacters` (`realmid`, `acctid`, `numchars`) VALUES
	(1, 1, 0),
	(1, 2, 0),
	(1, 3, 0),
	(1, 4, 0),
	(1, 5, 0),
	(1, 6, 0),
	(1, 7, 0),
	(1, 8, 0),
	(1, 9, 0),
	(1, 10, 0),
	(1, 11, 1),
	(1, 12, 0),
	(1, 13, 0),
	(1, 14, 1),
	(1, 16, 1),
	(1, 17, 0),
	(1, 18, 0),
	(1, 20, 1);
/*!40000 ALTER TABLE `realmcharacters` ENABLE KEYS */;

-- Dumping structure for table acore_auth.realmlist
CREATE TABLE IF NOT EXISTS `realmlist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  `address` varchar(255) NOT NULL DEFAULT '127.0.0.1',
  `localAddress` varchar(255) NOT NULL DEFAULT '127.0.0.1',
  `localSubnetMask` varchar(255) NOT NULL DEFAULT '255.255.255.0',
  `port` smallint(5) unsigned NOT NULL DEFAULT '8085',
  `icon` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `flag` tinyint(3) unsigned NOT NULL DEFAULT '2',
  `timezone` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `allowedSecurityLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `population` float unsigned NOT NULL DEFAULT '0',
  `gamebuild` int(10) unsigned NOT NULL DEFAULT '12340',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Realm System';

-- Dumping data for table acore_auth.realmlist: ~0 rows (approximately)
DELETE FROM `realmlist`;
/*!40000 ALTER TABLE `realmlist` DISABLE KEYS */;
INSERT INTO `realmlist` (`id`, `name`, `address`, `localAddress`, `localSubnetMask`, `port`, `icon`, `flag`, `timezone`, `allowedSecurityLevel`, `population`, `gamebuild`) VALUES
	(1, 'Stormforged', 'stormforgedwow.com', '127.0.0.1', '255.255.255.0', 8085, 0, 0, 2, 3, 0, 12340);
/*!40000 ALTER TABLE `realmlist` ENABLE KEYS */;

-- Dumping structure for table acore_auth.uptime
CREATE TABLE IF NOT EXISTS `uptime` (
  `realmid` int(10) unsigned NOT NULL,
  `starttime` int(10) unsigned NOT NULL DEFAULT '0',
  `uptime` int(10) unsigned NOT NULL DEFAULT '0',
  `maxplayers` smallint(5) unsigned NOT NULL DEFAULT '0',
  `revision` varchar(255) NOT NULL DEFAULT 'AzerothCore',
  PRIMARY KEY (`realmid`,`starttime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Uptime system';

-- Dumping data for table acore_auth.uptime: ~22 rows (approximately)
DELETE FROM `uptime`;
/*!40000 ALTER TABLE `uptime` DISABLE KEYS */;
INSERT INTO `uptime` (`realmid`, `starttime`, `uptime`, `maxplayers`, `revision`) VALUES
	(1, 1550400304, 121, 0, 'AzerothCore rev. 2bcedc2859e7 2019-02-17 10:04:09 +0100 (master branch) (Unix, Debug)'),
	(1, 1550400454, 1440, 0, 'AzerothCore rev. 2bcedc2859e7 2019-02-17 10:04:09 +0100 (master branch) (Unix, Debug)'),
	(1, 1567238424, 120, 1, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567246612, 241, 0, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567246918, 61, 0, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567247033, 2078, 1, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567253014, 2879, 1, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567256201, 3279, 1, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567259639, 1903, 1, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567261599, 328, 1, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567262742, 422, 1, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567263178, 73514, 1, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567339259, 42558, 1, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567382899, 2383, 2, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567385628, 495, 1, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567387565, 115, 1, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567390736, 28320, 2, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567419086, 1332, 1, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567423860, 8380, 1, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567432266, 1356, 1, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567432369, 0, 0, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)'),
	(1, 1567433800, 160256, 2, 'AzerothCore rev. 8853302da935 2019-08-31 06:08:36 +0000 (master branch) (Unix, Release)');
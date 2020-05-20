INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587630388241612100');

ALTER TABLE `acore_string`
	CHANGE `content_loc1` `locale_koKR` TEXT,
	CHANGE `content_loc2` `locale_frFR` TEXT,
	CHANGE `content_loc3` `locale_deDE` TEXT,
	CHANGE `content_loc4` `locale_zhCN` TEXT,
	CHANGE `content_loc5` `locale_zhTW` TEXT,
	CHANGE `content_loc6` `locale_esES` TEXT,
	CHANGE `content_loc7` `locale_esMX` TEXT,
	CHANGE `content_loc8` `locale_ruRU` TEXT;

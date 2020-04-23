INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587630388241612100');

ALTER TABLE `acore_string`
	RENAME COLUMN `content_loc1` TO `locale_koKR`,
ALTER TABLE `acore_string`
	RENAME COLUMN `content_loc2` TO `locale_frFR`,
ALTER TABLE `acore_string`
	RENAME COLUMN `content_loc3` TO `locale_deDE`,
ALTER TABLE `acore_string`
	RENAME COLUMN `content_loc4` TO `locale_zhCN`,
ALTER TABLE `acore_string`
	RENAME COLUMN `content_loc5` TO `locale_zhTW`,
ALTER TABLE `acore_string`
	RENAME COLUMN `content_loc6` TO `locale_esES`,
ALTER TABLE `acore_string`
	RENAME COLUMN `content_loc7` TO `locale_esMX`,
ALTER TABLE `acore_string`
	RENAME COLUMN `content_loc8` TO `locale_ruRU`;

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1591992052509403400');

DELETE FROM `playercreateinfo_item` WHERE `itemid` = 40582 AND `amount` = -1;

ALTER TABLE `playercreateinfo_item`
	CHANGE `amount` `amount` SMALLINT UNSIGNED NOT NULL DEFAULT 1;

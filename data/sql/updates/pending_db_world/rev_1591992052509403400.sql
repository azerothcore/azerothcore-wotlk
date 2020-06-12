INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1591992052509403400');

ALTER TABLE `playercreateinfo_item`
	CHANGE `amount` `amount` SMALLINT SIGNED NOT NULL DEFAULT 1;

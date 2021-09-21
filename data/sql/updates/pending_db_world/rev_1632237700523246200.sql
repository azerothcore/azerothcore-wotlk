INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632237700523246200');

DELETE FROM
	`creature_loot_template`
WHERE
	`Entry` = 1018
AND
	`Item` IN (24067, 24733);

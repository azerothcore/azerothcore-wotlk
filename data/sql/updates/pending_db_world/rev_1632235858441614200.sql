INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632235858441614200');

UPDATE 
	`creature_loot_template` 
SET 
	`Chance` = 
	(CASE 
		WHEN `Entry` = 7438 THEN 7
		WHEN `Entry` = 7439 THEN 7
		WHEN `Entry` = 7440 THEN 8
		WHEN `Entry` = 7441 THEN 8
		WHEN `Entry` = 7442 THEN 8
		WHEN `Entry` = 10199 THEN 7
		WHEN `Entry` = 10916 THEN 6
	END)
WHERE
	`Item` = 12820
AND
	`Entry` IN (7438, 7439, 7440, 7441, 7442, 10199, 10916);

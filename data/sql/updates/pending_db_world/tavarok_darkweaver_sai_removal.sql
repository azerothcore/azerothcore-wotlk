--
UPDATE `creature_template`
SET `Scriptname` =
	CASE
	WHEN `entry` = 18343 THEN 'boss_tavarok'
	WHEN `entry` = 18472 THEN 'boss_darkweaver_syth'
	END, `AIName` = ''
WHERE `entry` IN (18343, 18472);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18343, 18472, 1847200) AND `source_type` = 0 OR `source_type` = 9;

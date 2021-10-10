INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633565365065272800');

-- Door (Karazhan)
UPDATE `gameobject` SET `map` = 0, `zoneId` = 0, `areaId` = 0 WHERE `guid` = 14033 AND `id` = 176578;

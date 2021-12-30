INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640875137436794000');

UPDATE `gameobject` SET `map` = 30, `zoneId` = 0, `areaId` = 0 WHERE `guid` IN (11766,11765,11768,11767,11769) AND `id` = 2413;

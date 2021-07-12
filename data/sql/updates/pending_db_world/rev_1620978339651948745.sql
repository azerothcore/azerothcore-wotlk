INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620978339651948745');

DELETE FROM `gameobject`
WHERE `guid` IN (1396, 1374, 1686, 1740);

DELETE FROM `pool_gameobject`
WHERE `guid` IN (1396, 1374, 1686, 1740)
AND `pool_entry` = 950;

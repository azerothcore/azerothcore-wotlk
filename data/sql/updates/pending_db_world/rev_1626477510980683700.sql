INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626477510980683700');

-- Removes the four objects
DELETE FROM `gameobject` WHERE `id` = 177272 AND `guid` IN (42907, 42908, 42909, 42910);

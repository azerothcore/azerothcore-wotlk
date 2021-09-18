INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631973253175864827');

-- Slightly changes the position of two mining Nodes, so that the whole Node is visible
UPDATE `gameobject` SET `position_z` = -277 WHERE `id` = 123848 AND `guid` = 15462;
UPDATE `gameobject` SET `position_z` = -233 WHERE `id` = 123309 AND `guid` = 15423;

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627133872787794145');

-- Set Bingles' tools to all have consistent respawn
UPDATE `gameobject` SET `spawntimesecs` = 8 WHERE `id` = 104564 AND `guid` = 12863;
UPDATE `gameobject` SET `spawntimesecs` = 8 WHERE `id` = 104569 AND `guid` = 12872;
UPDATE `gameobject` SET `spawntimesecs` = 8 WHERE `id` = 104574 AND `guid` = 12864;
UPDATE `gameobject` SET `spawntimesecs` = 8 WHERE `id` = 104575 AND `guid` = 12871;


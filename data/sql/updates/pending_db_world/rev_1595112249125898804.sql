INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1595112249125898804');

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE guid IN (36738, 182011, 142088, 176484, 176485, 176486, 176487);
UPDATE `gameobject` SET `spawntimesecs`=180 WHERE guid IN (182199, 176249, 177287);
UPDATE `gameobject` SET `spawntimesecs`=300 WHERE guid IN (20726, 19284, 19283, 103664, 142477, 13949, 177964, 91138, 113757, 125477);
UPDATE `gameobject` SET `spawntimesecs`=7200 WHERE guid = 179545;

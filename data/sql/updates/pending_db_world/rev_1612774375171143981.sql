INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612774375171143981');

-- Lower respawn of Unfinished Painting

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=28477;

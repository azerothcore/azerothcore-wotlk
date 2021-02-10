INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612957477367642592');

-- Lower respawn rate for Tirisfal Pumpkin

UPDATE `gameobject` SET `spawntimesecs`=300 WHERE `guid` IN (45042, 45043, 45157, 45194, 45195, 45196, 45197, 45198, 45200, 45201);

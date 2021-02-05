INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612518645889979917');

-- Lower respawn of Rituals of Power from 24h to 2s

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=32237;

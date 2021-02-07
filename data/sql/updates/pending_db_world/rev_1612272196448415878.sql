INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612272196448415878');

-- Deserter Propaganda should respawn way faster

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=9175;

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612441103905701673');

-- Faster respawn of Beginnings of the Undead Threat

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=11901;

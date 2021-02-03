INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612359807867711613');

-- Fix DK quest: The Path Of The Righteous Crusader

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=66308;

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1610978234315303947');

--- Core Fragment in Blackrock Depths shouldn't despawn after being looted once

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=43133;

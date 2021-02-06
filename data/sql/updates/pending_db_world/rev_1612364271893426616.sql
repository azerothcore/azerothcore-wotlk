INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612364271893426616');

-- Fix DK quest: Nowhere To Run And Nowhere To Hide

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=66384;

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612401387393772200');

-- Removing Dupe Veins across lower parts of STV
DELETE FROM `gameobject` WHERE `guid` IN (12189, 85752, 64095, 40021, 12150, 15430, 9465, 40021);
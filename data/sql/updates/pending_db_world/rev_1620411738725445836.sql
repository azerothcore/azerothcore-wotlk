INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620411738725445836');

UPDATE `gameobject` SET `spawntimesecs`= 7200 WHERE FIND_IN_SET (`id`,'2855,2857,4096,4149,153453,153454,153451,153468');
UPDATE `gameobject` SET `spawntimesecs`= 36000 WHERE FIND_IN_SET (`id`,'153464,153469');


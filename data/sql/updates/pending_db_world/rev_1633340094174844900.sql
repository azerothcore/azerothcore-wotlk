INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633340094174844900');

DELETE FROM `gameobject` WHERE `guid`=80309;
DELETE FROM `game_event_gameobject` WHERE `guid`=80309;

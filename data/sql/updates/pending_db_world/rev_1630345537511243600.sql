INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630345537511243600');

DELETE FROM `gameobject` WHERE `guid`=87978;
INSERT INTO `gameobject` VALUES
(87978,188021,0,0,0,1,1,-137.439,-815.147,55.2293,1.36284,-0,-0,-0.629895,-0.77668,300,0,1,'',0);

DELETE FROM `game_event_gameobject` WHERE `guid`=87978;
INSERT INTO `game_event_gameobject` VALUES
(1,87978);

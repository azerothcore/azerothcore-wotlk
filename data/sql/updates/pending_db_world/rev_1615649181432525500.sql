INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615649181432525500');

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 24 AND `guid` = 59179);
INSERT INTO `game_event_gameobject` VALUES (24, 59179);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 24 AND `guid` = 59180);
INSERT INTO `game_event_gameobject` VALUES (24, 59180);

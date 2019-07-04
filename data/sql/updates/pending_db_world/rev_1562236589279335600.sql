INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1562236589279335600');

DELETE FROM `game_event_gameobject` WHERE `guid` IN (78033,78106,78117);
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(12,78033),
(12,78106),
(12,78117);

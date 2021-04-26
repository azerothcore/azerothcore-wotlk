INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619469854375537568');

DELETE FROM `game_event_gameobject` WHERE `guid` IN (59183, 59184);
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(24, 59183),
(24, 59184);
